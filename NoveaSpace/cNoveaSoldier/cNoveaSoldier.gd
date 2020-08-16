extends "../Base/BaseChara.gd"

var SkillText = "{c_skill}[战斗意识]{/c}：体格强壮训练有素，战斗时，每10秒，获得5层狂怒。"

func _extInit():
	._extInit()
	chaName = "士兵"
	lv = 1
	attCoe.atkRan = 1
	attCoe.maxHp = 15
	attCoe.atk = 15
	attCoe.mgiAtk = 8
	attCoe.def = 2
	attCoe.mgiDef = 2
	evos = ["cNoveaSoldier_1", "cNoveaSoldier_2"]
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText))
