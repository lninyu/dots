util.uniq() {
	local -n uniq="${1:?}" list="${2:-${1}}"
	local -A hash=()
	local item

	for item in "${list[@]}"; do
		hash["${item}"]=
	done

	uniq=("${!hash[@]}")
}

util.stacktrace() {
	local -n result="${1:?}"
	local -r IFS=" "
	local -i idx=1
	local temp line file func="${FUNCNAME[1]}"

	while temp=($(caller ${idx})); do
		((++idx))

		line="${temp[0]}"
		file="${temp[2]}"

		result+=($'\t'"at ${func}(${file}:${line})")

		func="${temp[1]}"
	done

	result+=($'\t'"at <main>(${BASH_SOURCE[-1]})")
}
