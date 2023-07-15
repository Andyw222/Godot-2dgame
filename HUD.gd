extends CanvasLayer
signal start_game
signal highscore_name


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#if Input.is_action_pressed("start_game"):
		#start_game.emit()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	$DifficultyButton.show()

func update_score(score):
	$ScoreLabel.text = "Time: %s" % str(score)

func _on_message_timer_timeout():
	$Message.hide()


func _on_start_button_pressed():
	$StartButton.hide()
	$DifficultyButton.hide()
	start_game.emit()

func update_lives(lives):
#	$LivesLabel.text = "Lives: %s" % str(lives)
	$HBoxContainer.update_lives(lives)
	
func update_mob_left(mob_left):
	$MobSurvived.text = "Mobs Exited %s" % str(mob_left)

func name_box_show():
	$NameBox.show()
	
func name_box_hide():
	$NameBox.hide()

func _on_name_box_text_submitted(new_text):
	highscore_name.emit(new_text) # Replace with function body.
