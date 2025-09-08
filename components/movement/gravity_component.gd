class_name GravityComponent
extends Node2D

@export_category("Dependencies")
@export var velocity_component: VelocityComponent

@export_subgroup("Settings")
@export var gravity: float = 20.0

var is_falling: bool = false
