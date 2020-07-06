extends "../cFFXIVBossTheEpicofAlexander_Hide/BossChara.gd"
const BERSERKERTIME_P1 = 120 # P1狂暴时间

func _extInit():
	._extInit()
	chaName = "完美亚历山大"
	lv = 4


# 必要的初始化
func _init():
	._init()
	set_path("cFFXIVBossTheEpicofAlexander_Hide")


func _connect():
	._connect()


func _castCdSkill(id):
	._castCdSkill(id)


func _onBattleStart():
	._onBattleStart()


func _onBattleEnd():
	._onBattleEnd()


func _onAddBuff(buff:Buff):
	pass

func _onHurt(atkInfo):
	._onHurt(atkInfo)
