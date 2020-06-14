func _init():
	print("最终幻想14：—————— 灵魂水晶加载 ——————")
	pass

class BaseSoul:
	const Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
	const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]
	var toolman = sys.main.newChara("cFFXIV_zTatalu", 2) # 工具人

	var masTeam
	var masCha
	var name = ""
	var info = ""

	var prevCha = toolman
	var prevSkill = ""
	
	var att = {
		"maxHp": 0,
		"atk": 0,
		"mgiAtk": 0,
		"def": 0,
		"mgiDef": 0,
		"cri": 0,
		"spd": 0,
		"cd": 0,
		"pen": 0,
		"mgiPen": 0
	}

	func _init(cha = null):
		if cha != null:
			masTeam = cha.team
			masCha = cha

	func setCdSkill(name, cd):
		for skill in masCha.skills:
			if skill.id == name:
				return

		prevSkill = name
		prevCha = masCha
		masCha.addCdSkill(name, cd)

	# 删除上一个角色装备的技能
	func deleteCdSkill():
		if prevCha != null:
			for skill in prevCha.skills:
				if skill.id == prevSkill:
					prevCha.skills.erase(skill)
					prevCha = null

class DarkKnight:
	extends BaseSoul
	var maxTreatmentVolume = 0
	var treatmentVolume = 0
	var switch = true
	func _init(cha):
		._init(cha)
		name = "[color=#432f2e]暗黑骑士之证"
		info = "灵魂的水晶，刻有历代暗黑骑士的记忆和灵魂。\n"\
			+ "[行尸走肉]\n"\
			+ "一场战斗最多触发一次。\n"\
			+ "濒死时附加[活死人]状态，免疫死亡(特殊攻击除外)，持续10s。\n"\
			+ "期间累计受到[50%最大生命]的治疗量后，解除[活死人]状态。\n"\
			+ "持续时间结束[活死人]尚未解除，则会立即重伤死亡。"
		att.maxHp = 300
		att.def = 10
		att.mgiDef = 20
		_connect()

	func _connect():
		sys.main.connect("onBattleStart", self, "skillInit")
		masCha.connect("onHurt", self, "livingDeath")
		masCha.connect("onPlusHp", self, "relieve")

	func skillInit():
		switch = true
		masCha = null
		treatmentVolume = 0
		maxTreatmentVolume = 0

	func livingDeath(atkInfo:AtkInfo):
		if atkInfo.hitCha.att.hp <= atkInfo.hurtVal and switch:
			masCha = atkInfo.hitCha
			maxTreatmentVolume = masCha.att.maxHp * 0.50
			atkInfo.hurtVal = 0
			masCha.addBuff(BUFF_LIST.b_LivingDeath.new(10))
			switch = false

	func relieve(val):
		if !switch:
			treatmentVolume += val
			if treatmentVolume >= maxTreatmentVolume:
				var bf = masCha.hasBuff("b_LivingDeath")
				if bf != null:
					bf.isDel = true

class Gunbreaker:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#ae9a37]绝枪战士之证"
		info = "灵魂的水晶，刻有历代绝枪战士的记忆和觉悟。\n"\
			+ "[光之心]\n"\
			+ "一定时间内，令自身和周围队员所受到的[color=#00e4ff]魔法伤害[/color]减轻10%。\n"\
			+ "此效果不可叠加。\n"\
			+ "冷却20s，持续10s。"
		att.maxHp = 250
		att.atk = 20
		att.def = 20
		att.mgiDef = 10
		setCdSkill("skill_HeartOfLight", 20)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "heartOfLight")

	func heartOfLight(id):
		if id == "skill_HeartOfLight":
			var allys = masCha.getAllChas(2)
			for cha in allys:
				if cha != null:
					cha.addBuff(BUFF_LIST.b_HeartOfLight.new(10))
			allys = null

class Bard:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#9caa42]吟游诗人之证"
		info = "灵魂的水晶，刻有历代吟游诗人的记忆和旋律。\n"\
			+ "[魔人的安魂曲]\n"\
			+ "战斗开始时，对所有敌方附加[魔法易伤]状态，\n使其受到的[color=#00e4ff]魔法伤害[/color]提高10%。\n"\
			+ "此效果不可叠加。\n"\
			+ "            ———— 纪念曾经的魔人曲"
		att.maxHp = 100
		att.atk = 30
		att.cri = 0.10
		_connect()

	func _connect():
		sys.main.connect("onBattleStart", self, "requiemOfTheDevil")

	func requiemOfTheDevil():
		for cha in masCha.getAllChas(1):
			if cha.team != masTeam:
				BUFF_LIST.b_RequiemOfTheDevil.new(cha)

class Dragoon:
	extends BaseSoul
	var count = 1
	var Dragon = false

	func _init(cha):
		._init(cha)
		name = "[color=#4752b8]龙骑士之证"
		info = "灵魂的水晶，刻有历代龙骑士的记忆和决心。\n"\
			+ "[红莲龙血]\n"\
			+ "使用两次[高跳]后，再使用[武神枪]可以进入[红莲龙血]状态。\n"\
			+ "[红莲龙血]：攻击力提升15%，持续15s。"
		att.maxHp = 150
		att.atk = 30
		_connect()

	func _connect():
		sys.main.connect("onBattleStart", self, "skillInit")
		masCha.connect("onCastCdSkill", self, "lifeOfTheDragon")

	func skillInit():
		count = 1
		Dragon = false

	func lifeOfTheDragon(id):
		if id == "skill_HighJump":
			count += 1
			if count == 2:
				Dragon = true
		if id == "skill_DragonBlood" and Dragon:
			Dragon = false
			count = 0
			masCha.addBuff(BUFF_LIST.b_LifeOfTheDragon.new(15))

class BlackMage:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#312d3a]黑魔法师之证"
		info = "灵魂的水晶，刻有历代黑魔法师的记忆和魔力。\n"\
			+ "[天语]\n"\
			+ "战斗开始时，为自身附加[天语]效果，提升自身[5%][10%][15%]的伤害。\n"\
			+ "根据黑魔法师的等级来调整。"
		att.maxHp = 100
		att.mgiAtk = 30
		att.mgiPen = 30
		_connect()

	func _connect():
		sys.main.connect("onBattleStart", self, "enochian")

	func enochian():
		masCha.addBuff(BUFF_LIST.b_Enochian.new(masCha.lv))

class Astrologian:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#eba058]占星术士之证"
		info = "灵魂的水晶，刻有历代占星术士的记忆和知识。\n"\
			+ "[命运之轮]\n"\
			+ "使自身及周围2格范围内的队友所受到的伤害减轻10%。\n"\
			+ "此效果不可叠加。\n"\
			+ "冷却36s，持续18s"
		att.maxHp = 100
		att.def = 20
		att.mgiAtk = 15
		setCdSkill("skill_Collective", 36)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "collective")

	func collective(id):
		if id == "skill_Collective":
			var allys = masCha.getCellChas(masCha.cell, 2, 2)
			for cha in allys:
				if cha != null:
					cha.addBuff(BUFF_LIST.b_Collective.new(18))
			allys = null

class Samurai:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#faefd0]武士之证"
		info = "灵魂的水晶，刻有历代武士的记忆和大义。\n"\
			+ "[必杀剑-震天]\n"\
			+ "对目标造成[200%]的[color=#ff7522]物理伤害[/color]。\n"\
			+ "冷却8s"
		att.maxHp = 150
		att.atk = 30
		setCdSkill("skill_Shinten", 8)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "shinten")

	func shinten(id):
		if id == "skill_Shinten" and masCha.aiCha != null:
			masCha.hurtChara(masCha.aiCha, masCha.att.atk * 2.0, Chara.HurtType.PHY, Chara.AtkType.SKILL)

class Warrior:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#bd555a]战士之证"
		info = "灵魂的水晶，刻有历代战士的记忆和斗志。\n"\
			+ "[泰然自若]\n"\
			+ "恢复自身[300%]攻击力的生命值。\n"\
			+ "冷却15s"
		att.maxHp = 250
		att.atk = 20
		att.def = 10
		att.mgiDef = 10
		setCdSkill("skill_Equilibrium", 15)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "equilibrium")

	func equilibrium(id):
		if id == "skill_Equilibrium":
			masCha.plusHp(masCha.att.atk * 3)

class RedMage:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#c12957]赤魔法师之证"
		info = "灵魂的水晶，刻有历代赤魔法师的记忆和心血。\n"\
			+ "[赤治疗]\n"\
			+ "为生命最低的友方单位恢复[80%]法强的生命值。\n"\
			+ "冷却16s"
		att.maxHp = 100
		att.mgiAtk = 15
		att.atk = 15
		setCdSkill("skill_Vercure", 16)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "vercure")

	func vercure(id):
		if id == "skill_Vercure":
			var chas = masCha.getAllChas(2)
			chas.sort_custom(Utils.Calculation, "sort_MinHpP")

			if chas[0] != null:
				chas[0].plusHp(masCha.att.mgiAtk * 0.8)

class Monk:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#a48a21]武僧之证"
		info = "灵魂的水晶，刻有历代武僧的记忆和气概。\n"\
			+ "[真言]\n"\
			+ "使自身和周围友方单位受到的治疗效果提高10%\n"\
			+ "冷却24s，持续10s"
		att.maxHp = 150
		att.atk = 20
		att.def = 20

		setCdSkill("skill_Mantra", 24)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "mantra")

	func mantra(id):
		if id == "skill_Mantra":
			var allys = masCha.getAllChas(2)
			for cha in allys:
				if cha != null:
					cha.addBuff(BUFF_LIST.b_Mantra.new(10))
			allys = null

class Paladin:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#7b9ea4]骑士之证"
		info = "灵魂的水晶，刻有历代骑士的记忆和荣誉。\n"\
			+ "[安魂祈祷]\n"\
			+ "自身魔法强度提高50点。\n"\
			+ "冷却27s，持续15s"
		att.maxHp = 250
		att.mgiAtk = 10
		att.def = 20
		setCdSkill("skill_Requiescat", 27)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "requiescat")

	func requiescat(id):
		if id == "skill_Requiescat":
			masCha.addBuff(BUFF_LIST.b_Requiescat.new(15))

class Ninja:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#6f5e5d]忍者之证"
		info = "灵魂的水晶，刻有历代忍者的记忆和精神。\n"\
			+ "[梦幻三段]\n"\
			+ "对目标连续发动三次普通攻击。\n"\
			+ "冷却19s"
		att.maxHp = 150
		att.atk = 20
		att.def = 10
		att.mgiDef = 10
		setCdSkill("skill_Dream", 19)
		_connect()
	
	func _connect():
		masCha.connect("onCastCdSkill", self, "dream")

	func dream(id):
		if id == "skill_Dream" and masCha.aiCha != null:
			masCha.normalAtkChara(masCha.aiCha)
			masCha.normalAtkChara(masCha.aiCha)
			masCha.normalAtkChara(masCha.aiCha)

class WhiteMage:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#c5bc94]白魔法师之证"
		info = "灵魂的水晶，刻有历代白魔法师的记忆和圣迹。\n"\
			+ "[神速咏唱]\n"\
			+ "[color=#e5e5e5]被动[/color]，技能冷却速度加快15%。"
		att.maxHp = 100
		att.mgiAtk = 20
		att.cd = 0.15

class Scholar:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#5251cb]学者之证"
		info = "灵魂的水晶，刻有历代学者的记忆和学识。\n"\
			+ "[连环计]\n"\
			+ "对目标施加[连环计]，10%的概率使其受到伤害变为双倍。\n"\
			+ "冷却15s，持续8s"
		att.maxHp = 100
		att.mgiAtk = 20
		att.mgiDef = 10

		setCdSkill("skill_ChainStratagem", 15)
		_connect()
	
	func _connect():
		masCha.connect("onCastCdSkill", self, "chainStratagem")

	func chainStratagem(id):
		if id == "skill_ChainStratagem" and masCha.aiCha != null:
			masCha.aiCha.addBuff(BUFF_LIST.b_ChainStratagem.new(8))

class Summoner:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#4b8e13]召唤师之证"
		info = "灵魂的水晶，刻有历代召唤师的记忆和真理。\n"\
			+ "[三重灾祸]\n"\
			+ "对目标施加[中毒][流血]。\n"\
			+ "冷却15s，持续10s"
		att.maxHp = 100
		att.mgiAtk = 30
		setCdSkill("skill__TriDisaster", 15)
		_connect()
	
	func _connect():
		masCha.connect("onCastCdSkill", self, "triDisaster")

	func triDisaster(id):
		if id == "skill__TriDisaster" and masCha.aiCha != null:
			masCha.aiCha.addBuff(b_liuXue.new(10))
			masCha.aiCha.addBuff(b_zhonDu.new(10))

class Machinist:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#6cc7c0]机工士之证"
		info = "与其他灵魂水晶不同，这颗水晶上尚未刻下历史的记忆。\n"\
			+ "[火焰喷射器]\n"\
			+ "[color=#e5e5e5]被动[/color]，普通攻击会对目标及其周围一格的敌人附加2层[烧灼]"
		att.maxHp = 100
		att.atk = 30
		_connect()

	func _connect():
		masCha.connect("onAtkChara", self, "fireGun")

	func fireGun(atkInfo):
		if atkInfo.atkType == Chara.AtkType.NORMAL:
			var chas = masCha.getCellChas(atkInfo.hitCha.cell, 1, 1)
			for i in chas:
					if i != null:
						i.addBuff(b_shaoZhuo.new(2))

class Dancer:
	extends BaseSoul
	func _init(cha):
		._init(cha)
		name = "[color=#ecb1d7]舞者之证"
		info = "灵魂的水晶，刻有历代舞者的记忆和舞蹈。\n"\
			+ "[扇舞·急]\n"\
			+ "[color=#e5e5e5]被动[/color]，普通攻击有30%概率触发。\n"\
			+ "对目标及周围2格敌人造成[100%]的[color=#ff7522]物理伤害[/color]。"
		att.maxHp = 100
		att.atk = 30
		_connect()

	func _connect():
		masCha.connect("onAtkChara", self, "fanDance")

	func fanDance(atkInfo):
		if atkInfo.atkType == Chara.AtkType.NORMAL and sys.rndPer(30):
			var chas = masCha.getCellChas(masCha.aiCha.cell, 2, 1)
			for i in chas:
				if i != null:
					masCha.hurtChara(i, masCha.att.atk, Chara.HurtType.PHY, Chara.AtkType.SKILL)
