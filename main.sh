[[ ${-} == *i* ]] && return

app.csi() {
	local IFS=; echo -n "${*/#/$'\e[?'}"
}

app.onInit() {
	app.csi 1002h 1006h 1049h 25l
	app.onResize
}

app.onExit() {
	app.csi 1002l 1006l 1049l 25h
}

app.onResize() {
	shopt -q checkwinsize && (:) || {
		shopt -s checkwinsize; (:)
	}
}

app.main() {
	[[ -t 0 ]] || exit 1

	source src/assert.sh
	source src/canvas.sh
	source src/util.sh

	local -r WIN_X=COLUMNS
	local -r WIN_Y=LINES

	trap -- app.onExit exit
	trap -- app.onResize winch
	app.onInit

	while read -rsn1 -d ""; do
		case ${REPLY} in
		*) break ;;
		esac
	done
}

if (( ${#BASH_SOURCE[@]} == 1 )); then
	app.main "${@}"
fi
