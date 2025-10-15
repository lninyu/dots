assert.fail() {
	local -a trace=("${*:-"Assertion failed."}")
	util.stacktrace trace

	if [[ -t 2 ]]
		then printf "\e[31m%s\e[m\n" "${trace[@]}"
		else printf "%s\n" "${trace[@]}"
	fi

	exit 1
} >& 2

assert.mutableIntArray() {
	[[ ${!1@a} == ai ]] || assert.fail
}

assert.canvasSize() {
	(( 0 < ${1:?} && ${1:?} <= CANVAS_MAX && 0 < ${2:?} && ${2:?} <= CANVAS_MAX )) || assert.fail
}
