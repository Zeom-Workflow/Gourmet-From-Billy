extends Control

@onready var label = $Label
var duration := 1.5

func show_text(text: String):
	# Atur teks
	label.text = text
	visible = true

	# Reset opacity
	modulate.a = 1.0

	# Tween animasi
	var tween = create_tween()

	# Gerak naik sedikit
	tween.tween_property(self, "position:y", position.y - 40, duration)

	# Fade out
	tween.tween_property(self, "modulate:a", 0.0, duration)

	# Hapus node setelah animasi selesai
	tween.tween_callback(queue_free)
