#Run the aws command
[group("aws")]
aws *PARAMS="":
    aws {{PARAMS}}

# Login to AWS
[group("aws")]
login:
    aws sso login

# Display the caller identity
[group("aws")]
whoami:
    aws sts get-caller-identity

