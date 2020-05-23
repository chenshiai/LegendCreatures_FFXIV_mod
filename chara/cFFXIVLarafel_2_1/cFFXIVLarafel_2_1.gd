extends "../cFFXIVLarafel_2/cFFXIVLarafel_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "魔石之黑"
	lv = 3
	evos = []
	addCdSkill("skill_LeyLines", 50)
	addCdSkill("skill_Xenoglossy", 30)
	addSkillTxt("[黑魔纹]：冷却时间50s，开局立即释放一次，加快自身15%的技能冷却时间，持续30s")
	addSkillTxt("[异言]：冷却时间30s，对目标造成[750%]法强的魔法伤害")

const XENOGLOSSY_PW = 7.5 # 异言威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	leyLines()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_LeyLines": leyLines()
	if id == "skill_Xenoglossy" && aiCha != null: xenoglossy()

func leyLines():
	addBuff(b_LeyLines.new(30))

func xenoglossy():
	var eff:Eff = newEff("sk_shiBao")
	eff.position = aiCha.position
	yield(reTimer(0.3), "timeout")
	var eff1 = newEff("numHit", Vector2(30, -60))
	eff1.setText("异言！", "#fe99ff")
	if aiCha != null:
		hurtChara(aiCha, att.mgiAtk * XENOGLOSSY_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)

class b_LeyLines:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_LeyLines"
		isNegetive = false
		att.cd = 0.15
		life = dur

	func _upS():
		life = clamp(life, 0, 30)
		if life <= 1: life = 0