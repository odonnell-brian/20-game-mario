extends StaticBody2D

const DISABLED_COLOR: Color = Color.DIM_GRAY

@export_category("Dependencies")
@export var item_spawn_component: ItemSpawnComponent
@export var spawn_fx: FxComponent


func _ready() -> void:
	item_spawn_component.item_spawn_started.connect(on_item_spawn)

func on_item_spawn() -> void:
	spawn_fx.do_fx()
	modulate = DISABLED_COLOR
