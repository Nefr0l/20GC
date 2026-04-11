extends Node

var player : AudioStreamPlayer2D
var player2 : AudioStreamPlayer2D

const prefix = "res://audio/"

var sounds: Dictionary = {
	"hover": preload(prefix + "hover.wav"),
	"select": preload(prefix + "select.wav"),
	"explosion": preload(prefix + "explosion.ogg"),
	"shoot": preload(prefix + "shoot.ogg")
}

var musics: Dictionary = {
	"game": preload(prefix + "game2.ogg"),
	"menu": preload(prefix + "Elka2.mp3")
}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	player = AudioStreamPlayer2D.new()
	player2 = AudioStreamPlayer2D.new()
	add_child(player)
	add_child(player2)
	
	play_music(musics["menu"], 0.6)
	

func play_sound(stream: AudioStream, volume: float = 1):
	if not player: return
	
	player.volume_linear = volume
	player.stream = stream
	player.play()
	
	
func play_music(stream: AudioStream, volume: float = 0.1):
	if not player2: return
	
	player2.volume_linear = volume
	player2.stream = stream
	player2.play()
	
	
func stop_music():
	player2.stop()
	
