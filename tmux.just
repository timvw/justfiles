# Attach to (or create) a new tmux session
[group("tmux")]
tmux session=invocation_directory():
	tmux new -As "$(printf '%s' "{{session}}" | tr '.' '_')"
