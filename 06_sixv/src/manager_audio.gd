extends Node

var player_audio : AudioStreamPlayer
var player_music : AudioStreamPlayer

const prefix = "res://assets/audio/"

var sounds: Dictionary = {
	"gravity": preload(prefix + "sound_gravity.wav"),
	"checkpoint": preload(prefix + "sound_checkpoint.wav"),
	"death": preload(prefix + "sound_damage.wav"),
	"win": preload(prefix + "sound_win.wav")
}

var musics: Dictionary = {
	"game": preload(prefix + "beat01.wav"),
	"menu": preload(prefix + "menu01.wav")
}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	player_audio = AudioStreamPlayer.new()
	player_music = AudioStreamPlayer.new()
	
	add_child(player_audio)
	add_child(player_music)
		
	var start_scene = get_tree().current_scene.scene_file_path
	play_music_on_scene_change(start_scene)


func play_music_on_scene_change(scene_path : String):
	if scene_path.contains("game"):
		play_music("game")
	elif scene_path.contains("menu"):
		play_music("menu")
	
		

func play_sound(stream_name : String, volume: float = 0.8):
	if not player_audio: return
	
	player_audio.volume_linear = volume
	player_audio.stream = sounds[stream_name]
	player_audio.play()
	
	
func play_music(stream_name : String, volume: float = 0.3):
	if not player_music: return
	
	player_music.volume_linear = volume
	player_music.stream = musics[stream_name]
	player_music.play()
	print("music playing")
	
	
func stop_music():
	player_music.stop()
	
