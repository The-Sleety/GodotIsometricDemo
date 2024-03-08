extends TextureProgressBar

@onready var player = $"../.."

func _ready():
	max_value = player.maxHealth

func _process(_delta):
	value = player.healt
