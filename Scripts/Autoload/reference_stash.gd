extends Node

var inventory: Inventory = (
	Inventory.new()
			.set_size(32)
			.add_item(load("res://Resources/Equipment/sword.tres"))
			.add_item(load("res://Resources/Equipment/axe.tres"))
			.add_item(load("res://Resources/Equipment/pickaxe.tres"))
			.add_item(load("res://Resources/Equipment/shovel.tres"))
)