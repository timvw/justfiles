# Launch Microsoft Edge with a remote debugging port for CDP/Playwright attachment
[group("browser")]
edge port="9222" url="":
	"/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" \
	--remote-debugging-port="{{port}}" \
	--restore-last-session \
	--no-first-run \
	--no-default-browser-check \
	{{url}}
