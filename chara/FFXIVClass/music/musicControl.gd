extends Control
var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具

func play():
	var track = load(Utils.Path + "/FFXIVClass/music/music.ogg.oggstr")
	sys.get_node("/root/audio/AudioStreamPlayer").stop()
	sys.get_node("/root/audio/AudioStreamPlayer").stream = track
	sys.get_node("/root/audio/AudioStreamPlayer").play()
