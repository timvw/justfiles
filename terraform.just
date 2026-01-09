instance := env_var_or_default("INSTANCE", "dev")
stack := env_var_or_default("STACK", "core")
tf_dir := env_var_or_default("TF_DIR", invocation_directory() + "/terraform/stacks/" + stack)
tf_workspace := env_var_or_default("TF_WORKSPACE", "default")

backend_config := "instances"/instance/"config.s3.tfbackend"
var_file := "instances"/instance/"config.instance.tfvars"
terraform_out_dir := ".terraform"
plan_file := terraform_out_dir / "plan.tfplan"
plan_json_file := terraform_out_dir / "plan.json"
plan_summary_file := terraform_out_dir / "plan_summary.txt"
plan_report_file := terraform_out_dir / "plan_report.txt"

# Run a terraform command
[group("terraform")]
tf *PARAMS='':
    cd {{tf_dir}} && terraform {{PARAMS}}

# Initialize the terraform stack
[group("terraform")]
tf-init:
      #!/usr/bin/env bash
      set -euo pipefail
      cd {{tf_dir}} && terraform init -backend-config={{backend_config}} -reconfigure -upgrade
      unset TF_WORKSPACE
      cd {{tf_dir}} && terraform workspace select {{tf_workspace}} 2>/dev/null || terraform workspace new {{tf_workspace}}

# Plan the infrastructure changes
[group("terraform")]
tf-plan: tf-init
    cd {{tf_dir}} && terraform plan -var-file="{{var_file}}" --out "{{plan_file}}"
    cd {{tf_dir}} && terraform show -json "{{plan_file}}" > "{{plan_json_file}}"
    cd {{tf_dir}} && cat "{{plan_json_file}}" | tf-summarize > "{{plan_summary_file}}"
    cd {{tf_dir}} && cat "{{plan_json_file}}" | jq -r '([.resource_changes[]?.change.actions?]|flatten)|{"create":(map(select(.=="create"))|length),"update":(map(select(.=="update"))|length),"delete":(map(select(.=="delete"))|length)}' > "{{plan_report_file}}"
    cd {{tf_dir}} && cat "{{plan_summary_file}}"

# Apply the planned infrastructure changes
[group("terraform")]
tf-apply *PARAMS="": tf-init
    cd {{tf_dir}} && terraform apply {{plan_file}} {{PARAMS}}

# Quickly (-auto-approve) apply the infrastructure changes without planning
[group("terraform")]
tf-quick *PARAMS="": tf-init
    cd {{tf_dir}} && terraform apply --var-file="{{var_file}}" --auto-approve {{PARAMS}}

# Format the terraform code
[group("terraform")]
tf-fmt:
    cd {{tf_dir}} && terraform fmt -recursive .

# Lint the terraform code
[group("terraform")]
tf-lint:
    cd {{tf_dir}} && tflint --var-file="{{var_file}}" --recursive

# Import an existing resource into terraform state
[group('terraform')]
tf-import RESOURCE_ADDRESS RESOURCE_ID: tf-init
    cd {{tf_dir}} && terraform import -var-file="{{var_file}}" {{RESOURCE_ADDRESS}} {{RESOURCE_ID}}


# Unlock the terraform state
[group("terraform")]
tf-unlock LOCK_ID: tf-init
    cd {{tf_dir}} && terraform force-unlock -force {{LOCK_ID}}

# Destroy the terraform stack
[group("terraform")]
tf-destroy *PARAMS="":
    cd {{tf_dir}} && terraform destroy --var-file="{{var_file}}" {{PARAMS}}
