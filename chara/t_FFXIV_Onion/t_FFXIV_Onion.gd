extends Talent
func init():
	name = "迷你欧米茄"

var bg = false
func _connect():
	player.connect("onAddTalent", self, "bgChange")

func bgChange(talent:Talent):
	if !bg && talent.name == "迷你欧米茄":
		var utils = globalData.infoDs["g_FFXIVUtils"]
		utils.backGroundChange()
		bg = true

func get_info():
	return "欧米茄：说不定就能够找到回到归所的道路了啊……。\n学习此天赋后，战斗场地将改变为\n[欧米茄时空夹缝 阿尔法幻境]"