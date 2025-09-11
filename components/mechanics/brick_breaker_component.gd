extends DamageComponent

func try_damage(node: Node2D) -> void:
	if node is ItemSpawnComponent:
		(node as ItemSpawnComponent).spawn_item()

	super(node)
