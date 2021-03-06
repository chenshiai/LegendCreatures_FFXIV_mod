class BaseSoul:
	const Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
	const TEXT = globalData.infoDs["g_bFFXIVText"]
	const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]
	var toolman = sys.main.newChara("cFFXIV_Tatalu", 2) # 工具人

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

class DarkKnight extends BaseSoul:
	var maxTreatmentVolume = 0
	var treatmentVolume = 0
	var switch = true
	func _init(cha):
		._init(cha)
		name = "{c_pro}暗黑骑士之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代暗黑骑士的记忆和灵魂。{/c}\n"\
			+ "{c_skill}[行尸走肉]{/c}\n"\
			+ "一场战斗最多触发一次。\n"\
			+ "濒死时附加[活死人]状态，免疫死亡(特殊攻击除外)，持续10s。\n"\
			+ "期间累计受到[50%最大生命]的治疗量后，解除[活死人]状态。\n"\
			+ "持续时间结束[活死人]尚未解除，则会立即重伤死亡。"

		att.maxHp = 500
		att.def = 40
		att.mgiDef = 45
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
			BUFF_LIST.b_LivingDeath.new({"cha": masCha, "dur": 10})
			switch = false

	func relieve(val):
		if !switch:
			treatmentVolume += val
			if treatmentVolume >= maxTreatmentVolume:
				var bf = masCha.hasBuff("b_LivingDeath")
				if bf != null:
					bf.isDel = true

class Gunbreaker extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_pro}绝枪战士之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代绝枪战士的记忆和觉悟。{/c}\n"\
			+ "{c_skill}[光之心]{/c}\n"\
			+ "一定时间内，令自身和周围队员所受到的{c_mgi}魔法伤害{/c}减轻10%。\n"\
			+ "此效果不可叠加。\n"\
			+ "冷却20s，持续10s。"
		att.maxHp = 350
		att.atk = 40
		att.def = 40
		att.mgiDef = 30
		setCdSkill("skill_HeartOfLight", 20)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "heartOfLight")

	func heartOfLight(id):
		if id == "skill_HeartOfLight":
			var allys = masCha.getAllChas(2)
			for cha in allys:
				if cha != null:
					BUFF_LIST.b_HeartOfLight.new({"cha": cha, "dur": 10})
			allys = null

class Bard extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_atk}吟游诗人之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代吟游诗人的记忆和旋律。{/c}\n"\
			+ "{c_skill}[魔人的安魂曲]{/c}\n"\
			+ "战斗开始时，使所有敌人受到的{c_mgi}魔法伤害{/c}提高8%。\n"\
			+ "此效果不可叠加。\n"\
			+ "            ———— 纪念曾经的魔人曲"
		att.maxHp = 200
		att.atk = 60
		att.cri = 0.10
		_connect()

	func _connect():
		sys.main.connect("onBattleStart", self, "requiemOfTheDevil")

	func requiemOfTheDevil():
		if sys.main.btChas.has(masCha):
			for cha in masCha.getAllChas(1):
				if cha.team != masTeam:
					BUFF_LIST.b_RequiemOfTheDevil.new({"cha": cha})


class Dragoon extends BaseSoul:
	var count = 1
	var Dragon = false

	func _init(cha):
		._init(cha)
		name = "{c_atk}龙骑士之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代龙骑士的记忆和决心。{/c}\n"\
			+ "{c_skill}[红莲龙血]{/c}\n"\
			+ "使用两次[高跳]后，再使用[武神枪]可以进入[红莲龙血]状态。\n"\
			+ "[红莲龙血]：攻击力提升15%，持续15s。"
		att.maxHp = 250
		att.atk = 60
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
			BUFF_LIST.b_LifeOfTheDragon.new({"cha": masCha, "dur": 15})

class BlackMage extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_atk}黑魔法师之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代黑魔法师的记忆和魔力。{/c}\n"\
			+ "{c_skill}[天语]{/c}\n"\
			+ "战斗开始时，为自身附加{c_skill}[天语]{/c}效果，提升自身[15%][20%][25%]的伤害。\n"\
			+ "根据黑魔法师的等级来调整。"
		att.maxHp = 200
		att.mgiAtk = 60
		att.mgiPen = 30
		_connect()

	func _connect():
		sys.main.connect("onBattleStart", self, "enochian")

	func enochian():
		BUFF_LIST.b_Enochian.new({"cha": masCha, "lv": masCha.lv})

class Astrologian extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_tre}占星术士之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代占星术士的记忆和知识。{/c}\n"\
			+ "{c_skill}[命运之轮]{/c}\n"\
			+ "使自身及队友所受到的伤害减轻{c_base}10%{/c}。\n"\
			+ "此效果不可叠加。\n"\
			+ "冷却24s，持续10s"
		att.maxHp = 200
		att.def = 20
		att.mgiAtk = 50
		setCdSkill("skill_Collective", 24)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "collective")

	func collective(id):
		if id == "skill_Collective":
			var allys = masCha.getAllChas(2)
			for cha in allys:
				if cha != null:
					BUFF_LIST.b_Collective.new({"cha": cha, "dur": 10})
			allys = null

class Samurai extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_atk}武士之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代武士的记忆和大义。{/c}\n"\
			+ "{c_skill}[必杀剑-震天]{/c}\n"\
			+ "对目标造成{c_phy}[200%]{/c}的物理伤害。\n"\
			+ "冷却8s"
		att.maxHp = 250
		att.atk = 65
		setCdSkill("skill_Shinten", 8)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "shinten")

	func shinten(id):
		if id == "skill_Shinten" and masCha.aiCha != null:
			masCha.hurtChara(masCha.aiCha, masCha.att.atk * 2.0, Chara.HurtType.PHY, Chara.AtkType.SKILL)

class Warrior extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_pro}战士之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代战士的记忆和斗志。{/c}\n"\
			+ "{c_skill}[泰然自若]{/c}\n"\
			+ "恢复自身攻击力[300%]的生命值。\n"\
			+ "冷却15s"
		att.maxHp = 450
		att.atk = 40
		att.def = 20
		att.mgiDef = 20
		setCdSkill("skill_Equilibrium", 15)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "equilibrium")

	func equilibrium(id):
		if id == "skill_Equilibrium":
			masCha.plusHp(masCha.att.atk * 3)

class RedMage extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_atk}赤魔法师之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代赤魔法师的记忆和心血。{/c}\n"\
			+ "{c_skill}[赤治疗]{/c}\n"\
			+ "为生命最低的友方单位恢复[80%]法强的生命值。\n"\
			+ "冷却16s"
		att.maxHp = 200
		att.mgiAtk = 50
		att.cd = 0.1
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

class Monk extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_atk}武僧之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代武僧的记忆和气概。{/c}\n"\
			+ "{c_skill}[真言]{/c}\n"\
			+ "使自身及友方单位受到的治疗效果提高{c_base}10%{/c}\n"\
			+ "冷却24s，持续10s"
		att.maxHp = 250
		att.atk = 60
		att.def = 20
		att.mgiDef = 20

		setCdSkill("skill_Mantra", 24)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "mantra")

	func mantra(id):
		if id == "skill_Mantra":
			var allys = masCha.getAllChas(2)
			for cha in allys:
				if cha != null:
					BUFF_LIST.b_Mantra.new({"cha": cha, "dur": 10})
			allys = null

class Paladin extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_pro}骑士之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代骑士的记忆和荣誉。{/c}\n"\
			+ "{c_skill}[安魂祈祷]{/c}\n"\
			+ "自身魔法强度提高50点。\n"\
			+ "冷却27s，持续15s"
		att.maxHp = 350
		att.mgiAtk = 10
		att.def = 40
		att.mgiDef = 40
		setCdSkill("skill_Requiescat", 27)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "requiescat")

	func requiescat(id):
		if id == "skill_Requiescat":
			BUFF_LIST.b_Requiescat.new({"cha": masCha, "dur": 15})

class Ninja extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_atk}忍者之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代忍者的记忆和精神。{/c}\n"\
			+ "{c_skill}[风遁之术]{/c}\n"\
			+ "获得15%的冷却缩减。"
		att.maxHp = 250
		att.atk = 50
		att.def = 10
		att.mgiDef = 10
		att.cd = 0.15

class WhiteMage extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_tre}白魔法师之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代白魔法师的记忆和圣迹。{/c}\n"\
			+ "{c_skill}[神速咏唱]{/c}\n"\
			+ "获得15%的冷却缩减。"
		att.maxHp = 200
		att.mgiAtk = 50
		att.cd = 0.15

class Scholar extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_tre}学者之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代学者的记忆和学识。{/c}\n"\
			+ "{c_skill}[连环计]{/c}\n"\
			+ "对目标施加[连环计]，使其受到伤害有10%的概率变为双倍。\n"\
			+ "冷却15s，持续8s"
		att.maxHp = 200
		att.mgiAtk = 50
		att.mgiDef = 10

		setCdSkill("skill_ChainStratagem", 15)
		_connect()
	
	func _connect():
		masCha.connect("onCastCdSkill", self, "chainStratagem")

	func chainStratagem(id):
		if id == "skill_ChainStratagem" and masCha.aiCha != null:
			BUFF_LIST.b_ChainStratagem.new({"cha": masCha.aiCha, "dur": 8})

class Summoner extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_atk}召唤师之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代召唤师的记忆和真理。{/c}\n"\
			+ "{c_skill}[三重灾祸]{/c}\n"\
			+ "对目标及周围一格的敌人施加[剧毒菌][瘴暍]。\n"\
			+ "冷却15s，持续10s"
		att.maxHp = 200
		att.mgiAtk = 50
		setCdSkill("skill__TriDisaster", 15)
		_connect()

	func _connect():
		masCha.connect("onCastCdSkill", self, "triDisaster")

	func triDisaster(id):
		if id == "skill__TriDisaster" and masCha.aiCha != null:
			var chas = masCha.getCellChas(masCha.aiCha.cell, 1, 1)
			for i in chas:
				BUFF_LIST.b_Bio.new({"cha": i, "cas": masCha, "dur": 10})
				BUFF_LIST.b_Miasma.new({"cha": i, "cas": masCha, "dur": 10})
				yield(sys.get_tree().create_timer(0.1), "timeout")

class Machinist extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_atk}机工士之证{/c}"
		info = "{c_base}与其他灵魂水晶不同，这颗水晶上尚未刻下历史的记忆。{/c}\n"\
			+ "{c_skill}[火焰喷射器]{/c}\n"\
			+ "普通攻击会对目标及其周围一格的敌人附加2层[烧灼]"
		att.maxHp = 200
		att.atk = 60
		_connect()

	func _connect():
		masCha.connect("onAtkChara", self, "fireGun")

	func fireGun(atkInfo):
		if atkInfo.atkType == Chara.AtkType.NORMAL:
			var chas = masCha.getCellChas(atkInfo.hitCha.cell, 1, 1)
			for i in chas:
					if i != null:
						i.addBuff(b_shaoZhuo.new(2))

class Dancer extends BaseSoul:
	func _init(cha):
		._init(cha)
		name = "{c_atk}舞者之证{/c}"
		info = "{c_base}灵魂的水晶，刻有历代舞者的记忆和舞蹈。{/c}\n"\
			+ "{c_skill}[扇舞·急]{/c}\n"\
			+ "普通攻击有30%概率触发。\n"\
			+ "对目标及周围2格敌人造成{c_phy}[100%]{/c}的物理伤害。"
		att.maxHp = 200
		att.atk = 60
		_connect()

	func _connect():
		masCha.connect("onAtkChara", self, "fanDance")

	func fanDance(atkInfo):
		if atkInfo.atkType == Chara.AtkType.NORMAL and sys.rndPer(30):
			var chas = masCha.getCellChas(masCha.aiCha.cell, 2, 1)
			for i in chas:
				if i != null:
					masCha.hurtChara(i, masCha.att.atk, Chara.HurtType.PHY, Chara.AtkType.SKILL)
