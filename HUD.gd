extends CanvasLayer
signal start_game
signal highscore_name
signal highscore_screen_finish

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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

func _on_message_timer_timeout():
	$Message.hide()
	

	

func _on_start_button_pressed():
	$StartButton.hide()
	$DifficultyButton.hide()
	start_game.emit()
	
func update_highscore(final_score):
	$HighscoreLabel.text = "Score: %s" % final_score

func update_lives(lives):
#	$LivesLabel.text = "Lives: %s" % str(lives)
	$HBoxContainer.update_lives(lives)

func name_box_show():
	$NameBox.show()
	
func name_box_hide():
	$NameBox.hide()

func _on_name_box_text_submitted(new_text):
	highscore_name.emit(new_text) # Replace with function body.
	
func highscore_screen_show(highscore_text):
	$HighscoreScreenLabel.text = highscore_text
	$HighscoreScreenLabel.show()
	$HighscoreScreenTimer.start()

func _on_highscore_screen_timer_timeout():
	highscore_screen_finish.emit()
	print("highscore screen finish emitted")
	$HighscoreScreenLabel.hide()
