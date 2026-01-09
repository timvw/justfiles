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
    uvx copier copy --trust -d project_name=$(basename "$PWD") -d stack_name={{stack}} https://github.com/timvw/copier-terraform-stack.git .
