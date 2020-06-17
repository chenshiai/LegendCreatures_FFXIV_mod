extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "人族冒险者"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 1
	evos = ["cFFXIVHumen_1", "cFFXIVHumen_2", "cFFXIVHumen_3"]
	atkEff = "atk_dao"
	addCdSkill("5",5)#添加cd技能
	addSkillTxt("[光之加护]：每5秒，获得5层[狂怒][抵御]")
	addSkillTxt(TEXT.format("""[进化分支]
[{TProtect}]战士
[{TProtect}]绝枪战士
[{TAttack}]舞者"""))

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