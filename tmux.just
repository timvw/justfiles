# Attach to (or create) a new tmux session
[group("tmux")]
tmux session=file_name(canonicalize(invocation_directory())):
	tmux new -As "$(printf '%s' "{{session}}" | tr '.' '_')"
