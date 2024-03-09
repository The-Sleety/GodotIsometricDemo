extends TextureProgressBar

@onready var player = $"../.."

func _ready():
	max_value = player.maxProtection

func _process(_delta):
	value = player.protection
