extends Control
var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var originMusic

func _init():
	originMusic = sys.get_node("/root/audio/AudioStreamPlayer").stream

func play(path):
	var track = load(path)
	sys.get_node("/root/audio/AudioStreamPlayer").stop()
	sys.get_node("/root/audio/AudioStreamPlayer").stream = track
	sys.get_node("/root/audio/AudioStreamPlayer").play()


func reset():
	sys.get_node("/root/audio/AudioStreamPlayer").stop()
	sys.get_node("/root/audio/AudioStreamPlayer").stream = originMusic
	sys.get_node("/root/audio/AudioStreamPlayer").play()