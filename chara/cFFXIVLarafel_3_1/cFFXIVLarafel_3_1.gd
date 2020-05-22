extends "../cFFXIVLarafel_3/cFFXIVLarafel_3.gd"
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "抗争之红"
	lv = 3
	evos = []
	addCdSkill("skill_Manafication", 20)
	addSkillTxt("[赤核爆/赤神圣]：被动，使用魔连攻后，立即追加释放一次[赤闪雷/赤疾风]且伤害变为[220%]")
	addSkillTxt("[倍增]：冷却时间20s，使当前的黑/白魔元翻倍，且魔法攻击提高10%，持续10s")
	
func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Manafication": manafication()

func manafication():
	var eff = newEff("numHit", Vector2(30, -60))
	eff.setText("倍增！")
	blackMorgen *= 2
	whiteMorgan *= 2
	if blackMorgen > 100: blackMorgen = 100
	if whiteMorgan > 100: whiteMorgan = 100
	addBuff(b_Manafication.new(10))

class b_Manafication:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Manafication"
		isNegetive = false
		life = dur
		att.mgiAtkL = 0.10

	func _upS():
		life = clamp(life, 0, 10)
		if life <= 1: life = 0