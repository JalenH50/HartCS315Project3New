extends CharacterBody2D

@export var speed = 2
@export var playerHealth = 100
var animation_player: AnimationPlayer
@export var health_bar: TextureProgressBar

func _ready():
	animation_player = $Sprite2D/AnimationPlayer
	var direction = "up"

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("left") and Input.is_action_pressed("down"):
		var direction = "downLeft"
		velocity = Vector2(-1, 1)
		animation_player.play("walk_downLeft")
	elif Input.is_action_pressed("left") and Input.is_action_pressed("up"):
		var direction = "upLeft"
		velocity = Vector2(-1, -1)
		animation_player.play("walk_upLeft")
	elif Input.is_action_pressed("right") and Input.is_action_pressed("up"):
		var direction = "upRight"
		velocity = Vector2(1, -1)
		animation_player.play("walk_upRight")
	elif Input.is_action_pressed("right") and Input.is_action_pressed("down"):
		var direction = "downRight"
		velocity = Vector2(1, 1)
		animation_player.play("walk_downRight")
	elif Input.is_action_pressed("left"):
		var direction = "left"
		velocity.x = -1
		animation_player.play("walk_left")
	elif Input.is_action_pressed("right"):
		var direction = "right"
		velocity.x = 1
		animation_player.play("walk_right")
	elif Input.is_action_pressed("up"):
		var direction = "up"
		velocity.y = -1
		animation_player.play("walk_up")
	elif Input.is_action_pressed("down"):
		var direction = "down"
		velocity.y = 1
		animation_player.play("walk_down")
	else:
		animation_player.play("idle")
		
	velocity = velocity.normalized() * speed
	move_and_collide(velocity)

# Handle damage signal from slimes
func _on_slime_damage_player(amount: Variant) -> void:
	playerHealth -= amount
	print("Player damaged! Current health = " + str(playerHealth))
	_update_player_health()
	if playerHealth <= 0:
		print("player should die here")

# Update health bar when player health changes
func _update_player_health():
	health_bar.value = playerHealth
