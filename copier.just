# Bootstrap terraform resources
[group("copier")]
[group("terraform")]
copier-tf-bootstrap:
    #!/usr/bin/env bash
    set -euo pipefail
    project_name=$(basename "$PWD")
    if project_source=$(git remote get-url origin 2>/dev/null); then
        :
    elif project_source=$(git remote -v 2>/dev/null | awk 'NR==1{print $2}'); then
        :
    else
        project_source="${PWD}"
    fi
    uvx copier copy --trust -d project_name="$project_name" -d project_source="$project_source" https://github.com/timvw/copier-terraform-bootstrap.git .

# Add a terraform stack
[group("copier")]
[group("terraform")]
copier-tf-stack stack:
    #!/usr/bin/env bash
    set -euo pipefail
    project_name=$(basename "$PWD")
    stack_name="{{stack}}"
    instance="{{instance}}"
    if aws_account_id=$(aws sts get-caller-identity --query Account --output text 2>/dev/null); then
        :
    elif [ -n "${AWS_ACCOUNT_ID:-}" ]; then
        aws_account_id="${AWS_ACCOUNT_ID}"
    else
        echo "Unable to determine AWS account ID; set AWS_PROFILE or AWS_ACCOUNT_ID." >&2
        exit 1
    fi
    uvx copier copy --trust -d project_name="$project_name" -d stack_name="$stack_name" -d instance="$instance" -d aws_account_id="$aws_account_id" https://github.com/timvw/copier-terraform-stack.git .
