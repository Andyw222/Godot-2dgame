extends Node

@export var mob_scene: PackedScene

var lives
@export var lives_base = 3
var mob_settings
var score
var mob_left
var final_score
var dead = false
#var save_data = {"highscore": 0}
var save_data = {
	0: {
		"highscore": 0
		},
	1: {
		"highscore": 0
		},
	2: {
		"highscore": 0
		},
	3: {
		"highscore": 0
		},
	4: {
		"highscore": 0
		},
	}
# Called when the node enters the scene tree for the first time.
func _ready():
	var load = $SaveGame.load()
	if load == null:
		save_data = save_data
	else:
		save_data = load
	print(JSON.stringify(save_data))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$Music.stop()
	$DeathSound.play() 
	dead = true
	$ScoreTimer.stop()
	$MobTimer.stop()
	print("final score %s" % final_score)
	if final_score > save_data[$HUD/DifficultyButton.selected].highscore:
		save_data[$HUD/DifficultyButton.selected].highscore = final_score
		save_data[$HUD/DifficultyButton.selected].name = name
		$HUD.name_box_show()
	else: 
		continue_game_over(null)
	$SaveGame.save(save_data)
	
func continue_game_over(name):
	$HUD.name_box_hide()
	$HUD.show_game_over()
	
	
func lives_left():
	print("Lives Left Function Triggered")
	if lives > 1:
		lives -= 1
		$HUD.update_lives(lives)
		print("Not Dead yet! %s Lives left." % lives)
		print("Starting Hit Timer")
		$HitTimer.start()
	else:
		print("Dead!")
		lives -= 1
		$HUD.update_lives(lives)
		$Player.nolives()
		game_over()

	
func new_game():
	score = 0
	#Mod left starts at 1 to enable score to update from start of game
	mob_left = 1 
	final_score = 0
	lives = lives_base
	dead = false
	match $HUD/DifficultyButton.selected:
		0:
			mob_settings = [150.0, 250.0, 0.5]
	
		1:
			mob_settings = [250.0, 350.0, 0.4]
			
		2:
			mob_settings = [350.0, 450.0, 0.3]
	
		3:
			mob_settings = [700.0, 900.0, 0.2]
		4:
			mob_settings = [1400.0, 1800.0, 0.1]
	$MobTimer.wait_time = mob_settings[2]
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_lives(lives)
	$HUD.show_message("Get Ready\n\n\n\n")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()
	$Player.update_sprite_mode("")
	$Player.update_indestructible(false)
	
	
	
	

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	mob.mob_leave.connect(_on_mob_mob_leave)

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(mob_settings[0], mob_settings[1]), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	
	


func _on_score_timer_timeout():
	score += 1
	final_score = score * mob_left
	print("Score: %s" % final_score)
	$HUD.update_highscore(final_score)


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
	



func _on_hit_timer_timeout():
	$Player.update_sprite_mode("")
	$Player.update_indestructible(false)


func _on_mob_mob_leave(blah):
	if ! dead:
		mob_left += 1
		print("mobexited %s" % mob_left)
