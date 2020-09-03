extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLChyzw"
	RepeatId = id
	ItemSkill = { "SpiritualBlade": true }
	name = "幻影之舞"
	att.spd = 0.40
	att.cri = 0.30
	info = TEXT.format("""{c_base}{c_skill}唯一被动——幽影华尔兹：{/c}与携带者战斗的敌人，对携带者的伤害降低12%，持续4s。
{c_skill}唯一被动——救主灵刃：{/c}在你受到即将使你的生命值降至30%以下的伤害时，为你提供一个护盾，可吸收最多[240/360/480/600]伤害。
护盾数值随携带者等级变化，持续3s (固定冷却：20s){/c}""")

var superbolide = true
var nowTime = 0
const cd = 20

func _onBattleStart():
	superbolide = true

func _onAtkChara(atkInfo):
	if Repeat:
		return
	STATUS.b_youyinghuaerzi.new({
		"cha": atkInfo.hitCha,
		"dur": 4,
		"cas": masCha,
	})

func _onHurt(atkInfo):
	if Repeat or !ItemSkill["SpiritualBlade"]:
		return
	if (masCha.att.hp - atkInfo.hurtVal) <= masCha.att.maxHp * 0.3 and superbolide:
		superbolide = false
		var HD = 120 * (masCha.lv + 1)
		STATUS.b_youyinghuaerziHD.new({
			"cha": masCha,
			"dur": 3,
			"HD": HD
		})

func _upS():
	# 技能冷却计时
	if !superbolide:
		nowTime += 1
		if nowTime >= cd:
			superbolide = true
			nowTime = 0