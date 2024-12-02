extends Node2D

@export var slime_scene: PackedScene  # The slime scene to instantiate
@export var num_slimes: int = 5  # Number of slimes to spawn
@export var spawn_radius: float = 200  # Radius around the player to spawn slimes
@export var player: CharacterBody2D  # The player node to spawn slimes around
@export var spawn_timer:Timer

func _ready():
	spawn_timer.start()
	spawn_slimes_radially()

# Function to spawn slimes radially around the player
func spawn_slimes_radially():
	for i in range(num_slimes):
		var angle = randf_range(0, 2 * PI)  # Random angle
		var distance = spawn_radius  # Random distance within the spawn radius
		var spawn_position = player.position + Vector2(cos(angle), sin(angle)) * distance
		
		# Instantiate the slime and set its position
		var slime_instance = slime_scene.instantiate()
		slime_instance.position = spawn_position
		
		# Set the player reference for the newly instantiated slime
		slime_instance.set_player(player)
		
		# Add the slime to the scene
		add_child(slime_instance)

		# Optionally, add the slime to a specific group for easier management
		slime_instance.add_to_group("Slimes")


func _on_enemy_spawn_timer_timeout() -> void:
	spawn_slimes_radially()
