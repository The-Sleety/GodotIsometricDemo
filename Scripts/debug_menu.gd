extends Control

@onready var debug_menu = $"."
@onready var debug_main = $DebugMain
@onready var options = $Options
@onready var scene_select = $"Scene Select"
@onready var scene_bottom = $"Scene Select/Bottom"
@onready var menus_select = $"Scene Select/MenusSelect"


func _process(_delta):
	if Input.is_action_just_pressed("drop"):
		debug_menu.visible = !debug_menu.visible


func _on_options_pressed():
	debug_main.visible = false
	scene_select.visible = false
	options.visible = true

func _on_exit_pressed():
	get_tree().quit()

func _on_back_pressed():
	debug_main.visible = true
	options.visible = false
	scene_select.visible = false

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_scene_select_pressed():
	debug_main.visible = false
	options.visible = false
	scene_select.visible = true

func _on_resume_pressed():
	debug_menu.visible = !debug_menu.visible



#scene select

func _on_menus_pressed():
	scene_bottom.visible = false
	menus_select.visible = true


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
