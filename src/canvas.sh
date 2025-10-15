readonly CANVAS_MAX=512

canvas.new() {
	local -n self="${1:?}"
	local -i size_x="${2:-${self[0]:?}}"
	local -i size_y="${3:-${self[1]:?}}"

	assert.mutableIntArray "${self}"
	assert.canvasSize "${size_x}" "${size_y}"

	self=(size_x size_y)
}

canvas.set() {
	(())
}

canvas.get() {
	(())
}

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
