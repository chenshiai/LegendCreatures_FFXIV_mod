extends Control
var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var originMusic
var TheAudio
var hasChanged = false # 音乐是否被本mod修改过
func _init():
	TheAudio = sys.get_node("/root/audio/AudioStreamPlayer")
	originMusic = TheAudio.stream

func play(path, musicPath):
	hasChanged = true
	var track = load("%s/%s" % [path, musicPath])
	TheAudio.stop()
	TheAudio.stream = track
	TheAudio.play()

func dbDown(n):
	var db = TheAudio.get_volume_db()
	for i in range(n):
		db -= 1
		TheAudio.set_volume_db(db)
		yield(sys.get_tree().create_timer(0.1), "timeout")

func dbUp(n):
	var db = TheAudio.get_volume_db()
	for i in range(n):
		db += 1
		TheAudio.set_volume_db(db)
		yield(sys.get_tree().create_timer(0.1), "timeout")

func reset():
	if hasChanged:
		TheAudio.stop()
		TheAudio.stream = originMusic
		TheAudio.play()
		hasChanged = false

func get_playback_position():
	return TheAudio.get_playback_position()

func set_volume_db(val):
	TheAudio.set_volume_db(val)

func get_volume_db():
	return TheAudio.get_volume_db()

func seek(time):
	TheAudio.seek(time)