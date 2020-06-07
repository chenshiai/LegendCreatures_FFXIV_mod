var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具

func _init():
	print("最终幻想14：—————— SoulCrystal加载 ——————")
	pass

class BaseSoul:
	var BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]
	var masTeam
	var masCha
	var name = ""
	var info = ""
	var att = {
		"maxHp": 0,
		"atk": 0,
		"mgiAtk": 0,
		"def": 0,
		"mgiDef": 0,
		"cri": 0,
		"spd": 0,
		"cd": 0
	}
	
	func setTeam(team):
		masTeam = team

	func setMasCha(cha):
		masCha = cha

class DarkKnight:
	extends BaseSoul
	var maxTreatmentVolume = 0
	var treatmentVolume = 0
	var switch = true

	func _init():
		name = "暗黑骑士之证"
		att.maxHp = 400
		att.def = 10
		att.mgiDef = 20
		info = "灵魂的水晶，刻有历代暗黑骑士的记忆和灵魂。\n"\
			+ "[行尸走肉]\n"\
			+ "一场战斗最多触发一次。\n"\
			+ "濒死时附加[活死人]状态，免疫死亡(特殊攻击除外)，持续10s。\n"\
			+ "期间累计受到[50%最大生命]的治疗量后，解除[活死人]状态。\n"\
			+ "持续时间结束[活死人]尚未解除，则会立即重伤死亡。"

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
	func _init():
		name = "绝枪战士之证"
		info = "灵魂的水晶，刻有历代绝枪战士的记忆和觉悟。\n"\
			+ "[光之心]\n"\
			+ "一定时间内，令自身和周围队员所受到的魔法伤害减轻10%。\n"\
			+ "ÇÐ20s，持续10s。"
		att.atk = 20
		att.def = 20
		att.mgiDef = 10

	func heartOfLight(id):
		if id == "skill_HeartOfLight":
			var toolman = sys.main.newChara("cFFXIV_zTatalu", 2)
			var allys = toolman.getAllChas(masTeam)
			for cha in allys:
				if cha.team == masTeam:
					cha.addBuff(BUFF_LIST.b_HeartOfLight.new(10))
			toolman = null
			allys = null

class Bard:
	extends BaseSoul
	func _init():
		name = "吟游诗人之证"
		att.atk = 30
		att.cri = 0.20
		info = "灵魂的水晶，刻有历代吟游诗人的记忆和旋律。\n"\
			+ "[魔人的安魂曲]\n"\
			+ "战斗开始时，对所有敌方附加[魔法易伤]状态，\n使其受到的魔法伤害提高10%。\n"\
			+ "此效果不可叠加\n"\
			+ "            ———— 纪念曾经的魔人曲"

	func requiemOfTheDevil():
		for cha in sys.main.btChas:
			if cha.team != masTeam:
				cha.addBuff(BUFF_LIST.b_RequiemOfTheDevil.new())

class Dragoon:
	extends BaseSoul
	var count = 1
	var Dragon = false
	func _init():
		name = "龙骑士之证"
		att.atk = 30
		info = "灵魂的水晶，刻有历代龙骑士的记忆和决心。\n"\
			+ "[红莲龙血]\n"\
			+ "使用两次[高跳]后，再使用[武神枪]可以进入[红莲龙血]状态。\n"\
			+ "攻击力提升15%，持续15s。"

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
		name = "黑魔法师之证"
		att.mgiAtk = 30
		masCha = cha
		info = "灵魂的水晶，刻有历代黑魔法师的记忆和魔力。\n"\
			+ "[天语]\n"\
			+ "战斗开始时，为自身附加[天语]效果，提升自身[5%][10%][15%]的伤害。\n"\
			+ "根据黑魔法师的等级来调整。"

	func enochian():
		masCha.addBuff(BUFF_LIST.b_Enochian.new(masCha.lv))

class Astrologian:
	extends BaseSoul
	func _init():
		name = "占星术士之证"
		att.def = 20
		att.mgiAtk = 15
		info = "灵魂的水晶，刻有历代占星术士的记忆和知识。\n"\
			+ "[命运之轮]\n"\
			+ "使自身及周围2格范围内的队友所受到的伤害减轻10%。\n"\
			+ "ÇÐ36s，持续18s"

	func collective(id):
		if id == "skill_Collective":
			var toolman = sys.main.newChara("cFFXIV_zTatalu", 2)
			var allys = toolman.getCellChas(masCha.cell, 2, masTeam)
			for cha in allys:
				if cha.team == masTeam:
					cha.addBuff(BUFF_LIST.b_Collective.new(18))
			toolman = null
			allys = null

class Samurai:
	extends BaseSoul
	func _init():
		name = "武士之证"
		att.atk = 30
		info = "灵魂的水晶，刻有历代武士的记忆和大义。\n"\
			+ "[必杀剑-震天]\n"\
			+ "对目标造成[200%]的物理伤害。\n"\
			+ "ÇÐ8s"

	func shinten(id):
		if id == "skill_Shinten" and masCha.aiCha != null:
			masCha.hurtChara(masCha.aiCha, masCha.att.atk * 2.0, Chara.HurtType.PHY, Chara.AtkType.SKILL)

class Warrior:
	extends BaseSoul
	func _init():
		name = "战士之证"
		att.maxHp = 200
		info = "灵魂的水晶，刻有历代战士的记忆和斗志。\n"\
			+ "[摆脱]\n"\
			+ "为自身和周围队友附加能够抵挡伤害的护盾"

# class RedMage:
# 	extends BaseSoul

# class Monk:
# 	extends BaseSoul

# class Paladin:
# 	extends BaseSoul

# class Ninja:
# 	extends BaseSoul

# class WhiteMage:
# 	extends BaseSoul

# class Scholar:
# 	extends BaseSoul

# class Summoner:
# 	extends BaseSoul

# class Machinist:
# 	extends BaseSoul

# class Dancer:
# 	extends BaseSoul

# class Gunbreaker:
# 	extends BaseSoul