class_name FxComponent
extends Node2D

@warning_ignore("unused_signal")
signal effect_complete()

func do_fx() -> void:
	push_warning("FxComponents need to override the do_fx function")
