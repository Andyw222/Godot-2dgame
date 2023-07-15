extends Node

func save(content):
	var savegame = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	savegame.store_var(content)

func load():
	var savegame = FileAccess.open("user://save_game.dat", FileAccess.READ)
	if savegame == null:
		return null
		print(savegame)
	else:
		var content = savegame.get_var()
		return content
