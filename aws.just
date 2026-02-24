# Run the aws command
[positional-arguments]
[group("aws")]
aws *PARAMS='':
    aws "$@"

# Login to AWS
[group("aws")]
login:
    aws sso login

# Display the caller identity
[group("aws")]
whoami:
    aws sts get-caller-identity

