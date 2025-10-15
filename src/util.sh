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
	local -r IFS=$'\n'
	local -i idx len=${#FUNCNAME[@]}-1
	local -n result="${1:?}"
	local -a caller=("${FUNCNAME[@]::len}")
	local -A defmap=()
	local temp func file line

	util.uniq caller

	shopt -q extdebug
	local -i extdebug=${?}

	(( extdebug )) && shopt -s extdebug

	for temp in $(declare -F "${caller[@]}"); do
		func="${temp%% *}"
		file="${temp##* }"

		defmap["${func}"]="${file}"
	done

	(( extdebug )) && shopt -u extdebug

	for ((idx = 1; idx < len; ++idx)); do
		func="${FUNCNAME[idx]}"
		file="${defmap[${FUNCNAME[idx+1]:-\ }]:-${BASH_SOURCE[-1]}}"
		line="${BASH_LINENO[idx]}"
		result+=("    at ${func}(${file}:${line})")
	done

	result+=("    at <main>(${BASH_SOURCE[-1]})")
}
