canvas.new() {
    local -n self="${1:?}"
    local -i size_x="${2:?}"
    local -i size_y="${3:?}"

    assert.mutableIntArray "${!self}"
    assert.canvasSize "${size_x}" "${size_y}"

    self=(size_x size_y)
}

canvas.set() {
    local -n self="${1:?}"
    local -i sx="${self[0]:?}" sy="${self[1]:?}"
    local -r cr="${self[2]:?}" cg="${self[3]:?}"
    local -r cb="${self[4]:?}" ca="${self[5]:?}"
    local -i px="${2:?}" py="${3:?}"
    local -i pr="${4:?}" pg="${5:?}"
    local -i pb="${6:?}" pa="${7:?}"
    local -i idx

    (( 0 <= px && px < sx )) || return $FAIL
    (( 0 <= py && py < sy )) || return $FAIL

    # shellcheck disable=SC2283
    {
        (( idx = sx * py + px ))
        (( $cr[idx] = pr & 255 ))
        (( $cg[idx] = pg & 255 ))
        (( $cb[idx] = pb & 255 ))
        (( $ca[idx] = pa & 255 ))
    }
}

canvas.get() {
    local -n self="${1:?}"
    local -i sx="${self[0]:?}" sy="${self[1]:?}"
    local -r cr="${self[2]:?}" cg="${self[3]:?}"
    local -r cb="${self[4]:?}" ca="${self[5]:?}"
    local -i px="${2:?}" py="${3:?}"
    local -r pr="${4:?}" pg="${5:?}"
    local -r pb="${6:?}" pa="${7:?}"
    local -i idx

    (( 0 <= px && px < sx )) || return $FAIL
    (( 0 <= py && py < sy )) || return $FAIL

    # shellcheck disable=SC2283
    {
        (( idx = sx * py + px ))
        (( pr = $cr[idx] ))
        (( pg = $cg[idx] ))
        (( pb = $cb[idx] ))
        (( pa = $ca[idx] ))
    }
}

#canvas.set.inline() { # sx: int, c{r,g,b,a}: name, px: int, py: int, p{r,g,b,a}: int
#    (($2[(__global=$1*$7+$6)]=$8,$3[__global]=$9,$4[__global]=${10},$5[__global]=${11}))
#}
#
#canvas.get.inline() { # sx: int, c{r,g,b,a}: name, px: int, py: int, p{r,g,b,a}: name
#    (($8=$2[(__global=$1*$7+$6)],$9=$3[__global],${10}=$4[__global],${11}=$5[__global]))
#}

#canvas.add() {
#    (( $cr[idx] = pr & 255 ))
#    (( $cg[idx] = pg & 255 ))
#    (( $cb[idx] = pb & 255 ))
#    (( $ca[idx] = pa + $ca[idx] * (255 - pa) / 255 ))
#}

canvas.import.raw() {
    (())
}

canvas.import.ppm() {
    (())
}

canvas.export.raw() {
    (())
}

canvas.export.ppm() {
    (())
}

canvas.export.cat() {
    (())
}
