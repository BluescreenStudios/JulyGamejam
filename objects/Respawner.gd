extends Node2D

@export var spawn_points = []
@export var killzones = []
@onready var player = $"../../Player"

func _ready():
	for i in range(killzones.size()):
		var kz: Area3D = get_node(killzones[i])
		kz.id = i
		kz.connect("activate", _on_killzone_activated)

func _on_killzone_activated(killzone_id):
	respawn_player(killzone_id)

func respawn_player(index):
	print("YUH")
	if index < spawn_points.size():
		print(player)
		player.global_position = get_node(spawn_points[index]).global_position
	else:
		print("Error: Index out of bounds for spawn_points array.")
