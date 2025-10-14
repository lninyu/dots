[[ ${-} == *i* ]] && return

readonly -i CANVAS_MAX=512

canvas.init() {
	local -n self="${1:?}"
	local -i size_x="${2:-${self[0]:?}}"
	local -i size_y="${3:-${self[1]:?}}"

	assert.mutableIntArray "${!self}"
	assert.canvasSize "${size_x}" "${size_y}"

	self=(size_x size_y)
}

assert.fail() {
	echo "${*:-"Assertion failed."}"
	exit 1
} >& 2

assert.mutableIntArray() {
	[[ ${!1@a} == ai ]] || assert.fail
}

assert.canvasSize() {
	(( 0 < ${1:?} && ${1:?} <= CANVAS_MAX && 0 < ${2:?} && ${2:?} <= CANVAS_MAX )) || assert.fail
}

canvas.set() {
	(())
}

canvas.get() {
	(())
}

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

app.export.raw() {
	(())
}

app.export.ppm() {
	(())
}

app.export.cat() {
	(())
}

app.main() {
	[[ -t 0 ]] || exit 1

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
