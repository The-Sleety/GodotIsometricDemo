extends TextureProgressBar

@onready var player = $"../.."

func _ready():
	max_value = player.MaxStamina

func _process(_delta):
	value = player.stamina
