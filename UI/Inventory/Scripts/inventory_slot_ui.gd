class_name InventorySlotUi extends NinePatchRect

signal selected(inventory_slot_ui: InventorySlotUi, event: InputEvent)

@onready var amount_label: Label = $AmountLabel
@onready var inventory_texture: TextureRect = $InventoryTexture
@onready var item_box: ItemBox = ItemBox.new():
	set(value):
		item_box = value
		if item_box is not ItemBox:
			return
		item_box.item_changed.connect(update_item)
		item_box.amount_changed.connect(update_label_amount)

	
func _ready() -> void:
	update_item()


func _gui_input(event: InputEvent) -> void:
	selected.emit(self, event)


func update_item() -> void:
	ItemSlotManager.update_slot_icon(item_box, inventory_texture)
	update_label_amount()


func update_label_amount() -> void:
	ItemSlotManager.update_slot_amount(item_box, amount_label)