extends "../Base/BaseChara.gd"

var SkillText = TEXT.format("{c_skill}[飞行专精]{/c}：有着不俗的飞行技术，战斗开始时，己方所有飞行单位的攻击力提高{c_base}2%{/c}，在备战区可以生效，可以叠加（同类效果取最高）")

func _extInit():
	._extInit()
	chaName = "飞行员"
	lv = 1
	attCoe.atkRan = 1
	attCoe.maxHp = 10
	attCoe.atk = 13
	attCoe.mgiAtk = 6
	attCoe.def = 2
	attCoe.mgiDef = 2
	evos = ["cNoveaPilot_1", "cNoveaPilot_2"]
	atkEff = "atk_dao"
	addSkillTxt(SkillText)