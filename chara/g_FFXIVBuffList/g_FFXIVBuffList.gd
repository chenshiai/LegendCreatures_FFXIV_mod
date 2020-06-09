func _init():
	print("最终幻想14：—————— 状态列表加载 ——————")
	pass


class BuffOption:
	# 删除目标身上的buff
	static func conflict(masCha, buffId):
		var bf = masCha.hasBuff(buffId)
		if bf != null:
			bf.isDel = true

	# 护盾减伤计算
	static func shield(total, atkInfo):
		if total >= 0:
			if total > atkInfo.hurtVal:
				total -= atkInfo.hurtVal
				atkInfo.hurtVal = 0
			else:
				atkInfo.hurtVal -= total
				total = 0
		elif total <= 0:
			total = 0
		return total

class BassShield:
	extends Buff
	var shieldValue = 0

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		shieldValue = BuffOption.shield(shieldValue, atkInfo)

# 深恶痛绝，提高魔防
class b_Abhor:
	extends Buff
	func _init():
		attInit()
		id = "b_Abhor"
		isNegetive = false
		att.mgiDefL = 0.10

# 暗黑布道，减少魔法伤害
class b_DarkMissionary:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_DarkMissionary"
		life = dur
		isNegetive = false

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		if atkInfo.hurtType == Chara.HurtType.MGI:
			atkInfo.hurtVal *= 0.90
			
	func _upS():
		life = clamp(life, 0, 6)

# 至黑之夜，护盾。可以吸收一定数值的伤害
class b_TheBlackestNight:
	extends Buff
	var total = 0
	func _init(val = 0):
		attInit()
		id = "b_TheBlackestNight"
		total = val
		isNegetive = false

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		total = BuffOption.shield(total, atkInfo)

# 活死人，无敌，但是还是会死
class b_LivingDeath:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_LivingDeath"
		isNegetive = false
		life = dur

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		atkInfo.hurtVal = 0

	func _upS():
		life = clamp(life, 0, 10)

	func _del():
		if life < 0:
			masCha.hurtChara(masCha, masCha.att.maxHp, Chara.HurtType.REAL)

# 强甲破点突，削弱双抗
class b_ArmorCrush:
	extends Buff
	func _init(dur = 1, pw = 0.15):
		attInit()
		id = "b_ArmorCrush"
		life = dur
		att.defL -= pw
		att.mgiDefL -= pw
	
	func _upS():
		life = clamp(life, 0, 7)

# 战栗，提高最大生命值和治疗量
class b_Shiver:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Shiver"
		isNegetive = false
		life = dur
		att.maxHpL = 0.20
		att.reHp = 0.20

	func _upS():
		life = clamp(life, 0, 20)

# 原初的解放，提高暴击率
class b_InnerRelease:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_InnerRelease"
		isNegetive = false
		att.cri = 1
		life = dur

	func _upS():
		life = clamp(life, 0, 8)

# 超火流星，无敌
class b_Superbolide:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Superbolide"
		isNegetive = false
		life = dur

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		atkInfo.hurtVal = 0

	func _upS():
		life = clamp(life, 0, 15)

# 光之心，减少魔法伤害
class b_HeartOfLight:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_HeartOfLight"
		life = dur
		isNegetive = false

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		if atkInfo.hurtType == Chara.HurtType.MGI:
			atkInfo.hurtVal *= 0.90
			
	func _upS():
		life = clamp(life, 0, 10)

# 舞伴，攻击力提高
class b_DancingPartner:
	extends Buff
	func _init():
		attInit()
		id = "b_DancingPartner"
		isNegetive = false
		att.atkL = 0.10
		att.mgiAtkL = 0.10

# 伶俐，攻击力提高
class b_DanceStep:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_DanceStep"
		isNegetive = false
		life = dur
		att.atkL = 0.10
		att.mgiAtkL = 0.10

	func _upS():
		life = clamp(life, 0, 10)

class b_Devilment:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_DanceStep"
		isNegetive = false
		life = dur
		att.atkL = 0.20
		att.mgiAtkL = 0.20

	func _upS():
		life = clamp(life, 0, 8)

# 再生，持续恢复
class b_Regen:
	extends Buff
	var hot = 0
	func _init(dur = 1, val = 0):
		attInit()
		id = "b_Regen"
		hot = val
		life = dur

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 18)

# 黑魔纹，冷却缩减
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

# 天语
class b_Enochian:
	extends Buff
	func _init(lv):
		attInit()
		id = "b_Enochian"
		isNegetive = false

	func _connect():
		masCha.connect("onAtkChara", self, "run")
	
	func run(atkInfo):
		if atkInfo.atkType != Chara.AtkType.EFF:
			atkInfo.hurtVal *= 1 + (0.05 * (lv - 1))

# 倍增,提高法强
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

# 鼓舞，护盾。可以吸收一定数值的伤害
class b_Adloquium:
	extends BassShield
	func _init(dur = 1, val = 0):
		attInit()
		id = "b_Adloquium"
		shieldValue = val
		life = dur
		isNegetive = false

	func _connect():
		._connect()
		BuffOption.conflict(masCha, "b_Night")

	func _upS():
		life = clamp(life, 0, 10)

# 野战治疗阵，减伤，持续恢复
class b_SacredSoil:
	extends Buff
	var hot = 0
	func _init(dur = 1, val = 0):
		attInit()
		id = "b_SacredSoil"
		hot = val
		life = dur
		isNegetive = false

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 0.9

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 10)

# 连环计
class b_ChainStratagem:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_ChainStratagem"
		life = dur
		isNegetive = false
	
	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		if sys.rndPer(10):
			atkInfo.hurtVal *= 2
			atkInfo.isCri = true

# 龙神迸发，提高法强
class b_Dreadwyrm:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Dreadwyrm"
		life = dur
		isNegetive = false
		att.mgiAtkL = 0.10

	func _upS():
		life = clamp(life, 0, 8)

# 贤者的叙事谣，提高非特效伤害
class b_Ballad:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Ballad"
		isNegetive = false
		life = dur
	
	func _connect():
		masCha.connect("onAtkChara", self, "onAtkChara")

	func _upS():
		life = clamp(life, 0, 8)

	func onAtkChara(atkInfo:AtkInfo):
		if atkInfo.atkType != Chara.AtkType.EFF: 
			atkInfo.hurtVal *= 1.08

# 光阴神的礼赞凯歌，debuff免疫
class b_Paean:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Paean"
		isNegetive = false
		life = dur
	
	func _connect():
		masCha.connect("onAddBuff", self, "onAddBuff")

	func onAddBuff(buff:Buff):
		if buff.isNegetive:
			buff.isDel = true

	func _upS():
		life = clamp(life, 0, 3)

# 行吟，减伤			
class b_Troubadour:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Troubadour"
		isNegetive = false
		life = dur

	func _connect():
		BuffOption.conflict(masCha, "b_Troubadour")
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 0.90

# 魔人曲。魔法易伤
class b_RequiemOfTheDevil:
	extends Buff
	func _init():
		attInit()
		id = "b_RequiemOfTheDevil"
		isNegetive = false
	
	func _connect():
		BuffOption.conflict(masCha, "b_RequiemOfTheDevil")
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		if atkInfo.hurtType == Chara.HurtType.MGI: 
			atkInfo.hurtVal *= 1.1
		
# 钢铁意志，提高防御
class b_SteelBelief:
	extends Buff
	func _init():
		attInit()
		id = "b_SteelBelief"
		isNegetive = false
		att.defL = 0.10

# 安魂祈祷
class b_Requiescat:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Requiescat"
		life = dur
		isNegetive = false
		att.mgiAtk = 50

	func _upS():
		life = clamp(life, 0, 15)

# 圣光幕帘，护盾。可以吸收一定数值的伤害
class b_DivineVeil:
	extends Buff
	var total = 0
	func _init(dur = 1, val = 0):
		attInit()
		id = "b_DivineVeil"
		total = val
		isNegetive = false
		life = dur

	func _connect():
		masCha.connect("onHurt", self, "run")

	func _upS():
		life = clamp(life, 0, 10)

	func run(atkInfo:AtkInfo):
		total = BuffOption.shield(total, atkInfo)

class b_Mantra:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Brotherhood"
		isNegetive = false
		life = dur
		att.reHp = 0.10

	func _upS():
		life = clamp(life, 0, 10)

# 野火Buff
class b_Wildfire:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_Wildfire"
		isNegetive = false
		life = dur

	func _upS():
		life = clamp(life, 0, 7)

# 过载			
class b_Overload:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_Overload"
		isNegetive = false
		att.atkR = 0.20
		life = dur

	func _upS():
		life = clamp(life, 0, 8)

# 太阳神之衡  
class b_Balance:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Balance"
		isNegetive = false
		att.atkL = 0.20
		life = dur

	func _upS():
		life = clamp(life, 0, 5)

# 放浪神之箭  
class b_Arrow:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Arrow"
		isNegetive = false
		att.spd = 0.20
		life = dur

	func _upS():
		life = clamp(life, 0, 5)

# 战争神之枪     
class b_Spear:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Spear"
		isNegetive = false
		att.cri = 0.20
		life = dur

	func _upS():
		life = clamp(life, 0, 5)

# 世界树之干
class b_Bole:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Bole"
		isNegetive = false
		att.defL = 0.20
		life = dur

	func _upS():
		life = clamp(life, 0, 5)

# 河流神之瓶
class b_Ewer:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Ewer"
		isNegetive = false
		att.cd = 0.20
		life = dur

	func _upS():
		life = clamp(life, 0, 5)

# 建筑神之塔
class b_Spire:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Spire"
		isNegetive = false
		att.mgiDefL = 0.20
		life = dur

	func _upS():
		life = clamp(life, 0, 5)

# 吉星
class b_LuckyStar:
	extends Buff
	var hot = 0
	func _init(dur = 1, val = 0):
		attInit()
		id = "b_LuckyStar"
		isNegetive = false
		hot = val
		life = dur

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 8)

# 黑夜领域，护盾。可以吸收一定数值的伤害
class b_Night:
	extends Buff
	var total = 0
	func _init(dur = 1, val = 0):
		attInit()
		id = "b_Night"
		total = val
		isNegetive = false
		life = dur

	func _connect():
		BuffOption.conflict(masCha, "b_Adloquium")
		masCha.connect("onHurt", self, "run")

	func _upS():
		life = clamp(life, 0, 10)

	func run(atkInfo:AtkInfo):
		total = BuffOption.shield(total, atkInfo)

# 命运之轮，减少伤害
class b_Collective:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Collective"
		life = dur
		isNegetive = false

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 0.90
			
	func _upS():
		life = clamp(life, 0, 18)


# 红莲龙血
class b_LifeOfTheDragon:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_LifeOfTheDragon"
		isNegetive = false
		att.atkL = 0.15
		life = dur

	func _upS():
		life = clamp(life, 0, 15)

# 静止不动
class b_StaticTime:
	extends Buff
	var oriAi
	func _init(lv):
		attInit()
		id = "b_StaticTime"
		life = lv
		isNegetive = false

	func _connect():
		._connect()
		oriAi = masCha.aiOn
		masCha.aiOn = false

	func _del():
		._del()
		masCha.aiOn = oriAi