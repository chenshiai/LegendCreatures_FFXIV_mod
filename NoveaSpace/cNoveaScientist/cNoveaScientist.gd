extends "../Base/BaseChara.gd"

var SkillText = "{c_skill}[科学技术]{/c}：解锁基础研究，略微降低研究所消耗的资源。"

func _extInit():
	._extInit()
	chaName = "科学家"
	lv = 1
	attCoe.atkRan = 1
	attCoe.maxHp = 7
	attCoe.atk = 6
	attCoe.mgiAtk = 11
	attCoe.def = 2
	attCoe.mgiDef = 2
	evos = ["cNoveaScientist_1", "cNoveaScientist_2"]
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(SkillText))
