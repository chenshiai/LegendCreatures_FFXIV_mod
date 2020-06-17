extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "拉拉肥冒险者"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 1
	evos = ["cFFXIVLarafel_1", "cFFXIVLarafel_2", "cFFXIVLarafel_3"]
	atkEff = "atk_dao"
	addCdSkill("5", 5)
	addSkillTxt("[光之加护]：每5秒，获得5层[狂怒][抵御]")
	addSkillTxt(TEXT.format("""[进化分支]
[{TTreatment}]白魔法师
[{TAttack}]黑魔法师
[{TAttack}]赤魔法师"""))

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "5":
		addBuff(b_kuangNu.new(5))
		addBuff(b_diYu.new(5))