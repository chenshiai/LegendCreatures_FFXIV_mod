extends "../Base/BaseChara.gd"


var SkillText = TEXT.format("{c_skill}[工程专精]{/c}：解锁基础图纸，略微降低建设所消耗的资源。")


func _extInit():
	._extInit()
	chaName = "工程师"
	lv = 1
	attCoe.atkRan = 1
	attCoe.maxHp = 8
	attCoe.atk = 10
	attCoe.mgiAtk = 8
	attCoe.def = 2
	attCoe.mgiDef = 2
	evos = ["cNoveaEngineer_1", "cNoveaEngineer_2"]
	atkEff = "atk_dao"
	addSkillTxt(SkillText)

