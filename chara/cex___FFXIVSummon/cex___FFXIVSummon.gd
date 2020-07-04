extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

var Summoner = null

func _extInit():
	._extInit()
	chaName = "召唤兽模板"
	isSumm = true
	normalSpr.position = Vector2(-40, 0)
	self.get_node("ui/hpBar").visible = false
