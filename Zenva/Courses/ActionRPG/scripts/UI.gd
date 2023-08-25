extends Control

@onready var health_bar: TextureProgressBar = get_node("HealthBar")
@onready var gold_text: Label = get_node("GoldText")

func update_health_bar(current_hp, max_hp):
	health_bar.value = (100 / max_hp) * current_hp

func update_gold_text(amount):
	gold_text.text = str("Gold: ", amount)
