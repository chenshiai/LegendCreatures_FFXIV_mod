extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "精灵冒险者"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 1
	evos = ["cFFXIVSpirit_1", "cFFXIVSpirit_2", "cFFXIVSpirit_3"]
	atkEff = "atk_dao"
	addCdSkill("5",5)#添加cd技能
	addSkillTxt("[光之加护]：每5秒，获得5层[狂怒][抵御]")
	addSkillTxt(TEXT.format("""[进化分支]
[{TTreatment}]占星术士
[{TAttack}]龙骑士"""))

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "5":
		addBuff(b_diYu.new(5))
		addBuff(b_kuangNu.new(5))