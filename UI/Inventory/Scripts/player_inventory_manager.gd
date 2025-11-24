class_name PlayerInventoryManager extends VBoxContainer

@onready var inventory_ui: InventoryUi = $InventoryUI


func _ready() -> void:
	inventory_ui.inventory = ReferenceStash.inventory
	inventory_ui.inventory_slot_selected.connect(_on_inventory_slot_selected)


func grab_inventory_ui_focus() -> void:
	inventory_ui.grab_inventory_slot_focus()


func _on_inventory_slot_selected(inventory: InventoryUi, inventory_slot_ui: InventorySlotUi, event: InputEvent) -> void:
	pass
