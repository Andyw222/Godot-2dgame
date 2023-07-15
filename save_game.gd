extends Node

func save(content, file):
	var savegame = FileAccess.open("user://%s.dat" % file, FileAccess.WRITE)
	savegame.store_var(content)

func load(file):
	var savegame = FileAccess.open("user://%s.dat" % file, FileAccess.READ)
	if savegame == null:
		return null
		print(savegame)
	else:
		var content = savegame.get_var()
		return content
