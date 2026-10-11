
extends Control

@onready var settings_panel: Control = $SettingsPanel

@onready var master_slider: HSlider = $SettingsPanel/HSlider
@onready var master_label: Label = $SettingsPanel/MasterLabel

@onready var fullscreen_button: CheckButton = $SettingsPanel/CheckButton


@onready var reset_button: Button = $SettingsPanel/ResetButton
@onready var back_button: Button = $SettingsPanel/BackButton

@onready var resolution_option: OptionButton = \
	$SettingsPanel/HBoxContainer/OptionButton


const DEFAULT_MASTER_VOLUME: float = 80.0

var default_fullscreen: bool = false
var default_screen_shake: bool = true

var screen_shake_enabled: bool = true

var resolutions: Array[Vector2i] = [
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080)
]


func _ready() -> void:
	# Connect signals.
	master_slider.value_changed.connect(_on_master_volume_changed)
	fullscreen_button.toggled.connect(_on_fullscreen_toggled)
	reset_button.pressed.connect(_on_reset_pressed)
	back_button.pressed.connect(_on_back_pressed)
	resolution_option.item_selected.connect(_on_resolution_selected)

	# Configure master volume.
	master_slider.min_value = 0
	master_slider.max_value = 100
	master_slider.step = 1

	var master_bus: int = AudioServer.get_bus_index("Master")

	if master_bus != -1:
		master_slider.value = (
			AudioServer.get_bus_volume_linear(master_bus) * 100.0
		)

	_update_master_label(master_slider.value)

	# Initialize fullscreen.
	fullscreen_button.button_pressed = (
		DisplayServer.window_get_mode()
		== DisplayServer.WINDOW_MODE_FULLSCREEN
	)


	# Populate resolution dropdown.
	resolution_option.clear()

	for resolution in resolutions:
		resolution_option.add_item(
			"%d × %d" % [resolution.x, resolution.y]
		)

	_select_current_resolution()


# -------------------------
# MASTER VOLUME
# -------------------------

func _update_master_label(value: float) -> void:
	master_label.text = "MASTER VOLUME  %d%%" % int(value)


func _on_master_volume_changed(value: float) -> void:
	var master_bus: int = AudioServer.get_bus_index("Master")

	if master_bus == -1:
		return

	if value <= 0.0:
		AudioServer.set_bus_volume_db(master_bus, -80.0)
	else:
		AudioServer.set_bus_volume_linear(master_bus, value / 100.0)

	_update_master_label(value)


# -------------------------
# FULLSCREEN
# -------------------------

func _on_fullscreen_toggled(enabled: bool) -> void:
	if enabled:
		DisplayServer.window_set_mode(
			DisplayServer.WINDOW_MODE_FULLSCREEN
		)
	else:
		DisplayServer.window_set_mode(
			DisplayServer.WINDOW_MODE_WINDOWED
		)


# -------------------------
# SCREEN SHAKE
# -------------------------

func _on_screen_shake_toggled(enabled: bool) -> void:
	screen_shake_enabled = enabled

	# Your camera/player script must check this setting
	# to disable screen shake during gameplay.


# -------------------------
# RESOLUTION
# -------------------------

func _select_current_resolution() -> void:
	var current_size: Vector2i = DisplayServer.window_get_size()

	for i in range(resolutions.size()):
		if resolutions[i] == current_size:
			resolution_option.select(i)
			return

	# Select the first option if the current size is not listed.
	resolution_option.select(0)


func _on_resolution_selected(index: int) -> void:
	if index < 0 or index >= resolutions.size():
		return

	var new_size: Vector2i = resolutions[index]

	# Resolution changes require windowed mode.
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_WINDOWED
	)
	DisplayServer.window_set_size(new_size)


# -------------------------
# RESET SETTINGS
# -------------------------

func _on_reset_pressed() -> void:
	master_slider.value = DEFAULT_MASTER_VOLUME

	fullscreen_button.button_pressed = default_fullscreen

	# Restore the default volume explicitly.
	_on_master_volume_changed(DEFAULT_MASTER_VOLUME)

	# Restore the default window mode.
	_on_fullscreen_toggled(default_fullscreen)

	# Restore the screen shake value.
	_on_screen_shake_toggled(default_screen_shake)

	# Reset the resolution to 1280 × 720.
	resolution_option.select(0)
	_on_resolution_selected(0)


# -------------------------
# BACK TO MAIN MENU
# -------------------------

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(
		"res://Scenes/main_menu.tscn"
	)
