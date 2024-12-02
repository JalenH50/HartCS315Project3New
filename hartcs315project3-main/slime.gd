extends CharacterBody2D

signal damage_player(amount)

@export var damage: float = 1
@export var speed: float = 10
@export var sprite: Sprite2D
var player: CharacterBody2D  # Player reference
@export var move_timer: Timer
@export var animation_player: AnimationPlayer
@export var damage_timer: Timer

func _ready():
	# Ensure the move timer starts
	move_timer.start(2)

func set_player(_player: CharacterBody2D) -> void:
	player = _player  # Set the player reference
	self.connect("damage_player", Callable(player, "_on_slime_damage_player"))

func _on_move_timer_timeout() -> void:
	if player:
		var direction = position.direction_to(player.position)
		velocity = direction * speed
		move_and_collide(velocity)

		if direction.x < 0:
			animation_player.play("move")
			sprite.scale.x = 1
		elif direction.x > 0:
			animation_player.play("move")
			sprite.scale.x = -1
	
	move_timer.start(2)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("damage_player", damage)  # Emit damage signal when colliding with player
		damage_timer.start()

func _on_area_2d_body_exited(body: Node2D) -> void:
	damage_timer.stop()

func _on_damage_timer_timeout() -> void:
	print("player damaged")
	emit_signal("damage_player", damage)
