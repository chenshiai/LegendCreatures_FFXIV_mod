extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLCsxzl"
	RepeatId = id
	ItemSkill = { "CursedBlade": true }
	name = "三相之力"
	att.maxHp = 300
	att.atk = 30
	att.mgiAtk = 30
	att.spd = 0.40
	att.cd = 0.20
	info = TEXT.format("""{c_base}{c_skill}唯一被动：{/c}该装备额外提供10%的攻速加成。
{c_skill}唯一被动——咒刃：{/c}施放技能后，下一次普通攻击会造成额外物理伤害，伤害值为基础攻击力的200%{/c}""")

var hasAtk = false
func _connect():
	._connect()
	if Repeat:
		att.spd = 0.4
	else:
		att.spd = 0.5

func _onBattleStart()
	hasAtk = false

func _onCastCdSkill(id):
	hasAtk = true

func _onAtkChara(atkInfo):
	if not ItemSkill["CursedBlade"] or Repeat:
		return
	if atkInfo.atkType == NORMAL and hasAtk:
		hasAtk = false
		masCha.hurtChara(atkInfo.hitCha, masCha.attCoe.atk * 17, PHY, EFF)
