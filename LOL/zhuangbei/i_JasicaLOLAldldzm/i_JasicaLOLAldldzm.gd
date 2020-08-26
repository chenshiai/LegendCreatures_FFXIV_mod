extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLAldldzm"
	RepeatId = id
	name = "兰德里的折磨"	
	att.mgiAtk = 80
	att.maxHp = 300
	att.cd = 0.1
	info = TEXT.format("""{c_base}{c_skill}唯一被动——疯狂：{/c}战斗开始后，每过1秒，携带者造成的伤害提高2%(最大值10%)。
{c_skill}唯一被动——折磨：{/c}伤害型技能会烧·灼目标3秒，每秒造成相当于目标1%最大生命值的魔法伤害，目标每有一个负面效果都会提升50%的烧·灼伤害{/c}""")

var upAtkR = 0 # 疯狂伤害加成

func _onBattleStart():
	upAtkR = 0

func _upS():
	if Repeat:
		return
	
	upAtkR += 0.02
	if upAtkR > 0.1:
		upAtkR = 0.1
	att.atkR = upAtkR

func _onAtkChara(atkInfo:AtkInfo):
	if Repeat:
		return
	if atkInfo.atkType == SKILL:
		STATUS.b_bingshuang.new({
			"cha": atkInfo.hitCha,
			"dur": 3,
			"cas": masCha
		})
	
