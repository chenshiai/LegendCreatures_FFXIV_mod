extends "../cNoveaPilot_2/cNoveaPilot_2.gd"

var SkillText_2_1 = TEXT.format("""{c_skill}[空降]{/c}：战斗开始时，空降至敌方后排，并获得10层狂怒。
{c_skill}[振动武器专精]{/c}：装备{c_vib}{s}【振动攻击】{/s}{/c}的武器时，攻击力提高20%。""")

func _extInit():
	._extInit()
	chaName = "空降奇兵"
	lv = 3
	attCoe.maxHp += 1
	attCoe.atk += 2
	attCoe.mgiAtk += 1
	evos = []
	atkEff = "atk_dao"
	addSkillTxt(SkillText_2_1)
