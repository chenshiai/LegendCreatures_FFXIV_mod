extends "../../2098858773/BossChara.gd"

const BERSERKERTIME_P1 = 120 # P1狂暴时间

func _extInit():
	._extInit()
	chaName = "完美亚历山大"
	lv = 4
	self.aiOn = false
	self.visible = false
	self.isDeath = true
	
# 必要的初始化
func _init():
	._init()

func _connect():
	._connect()


func _castCdSkill(id):
	._castCdSkill(id)


func _onBattleStart():
	._onBattleStart()
	yield(reTimer(1), "timeout")
	self.isDeath = false

func _onBattleEnd():
	._onBattleEnd()


func _onCharaDel(cha):
	._onCharaDel(cha)
	if cha.id == "cFFXIV_Living_liquid_Hide":
		sys.main.setMatCha(Vector2(6, 2), self)

func _onHurt(atkInfo):
	._onHurt(atkInfo)

func _upS():
	._upS()
	print("亚历山大倒计时中")


func HpBarConnect(cha = null):
	if cha != null:
		FFControl.HpBar.show()
		cha.connect("onHurtEnd", FFControl.HpBar, "hpDown")
		cha.connect("onAtkChara", FFControl.Limit, "limitBreak_up")