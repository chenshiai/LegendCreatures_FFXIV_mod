var name = "BuffList"

func _ready():
	pass

func _init():
	print("最终幻想14：—————— Buff列表加载 ——————")
	pass

# 深恶痛绝，提高魔防
class b_Abhor:
	extends Buff
	func _init():
		attInit()
		id = "b_Abhor"
		isNegetive = false
		att.mgiDefL = 0.20

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 0.90

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
			atkInfo.hurtVal *= 0.80
			
	func _upS():
		life = clamp(life, 0, 6)
		if life <= 1:
			life = 0

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
		masCha.connect("onHurt", self, "onHurt")

	func onHurt(atkInfo:AtkInfo):
		if total >= 0:
			if total > atkInfo.hurtVal:
				total -= atkInfo.hurtVal
				atkInfo.hurtVal = 0
			else:
				atkInfo.hurtVal -= total
				total = 0
		elif total <= 0:
			total = 0

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
		if life <= 1:
			life = 0

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
		life = clamp(life, 0, 10)
		if life <= 1:
			life = 0

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
		if life <= 1:
			life = 0

# 超火流星，无敌
class b_Superbolide:
	extends Buff
	func _init(dur = 1):
		attInit()
		id = "b_Superbolide"
		isNegetive = false
		life = dur

	func _connect():
		masCha.connect("onHurt", self, "onHurt")

	func onHurt(atkInfo:AtkInfo):
		atkInfo.hurtVal = 0

	func _upS():
		life = clamp(life, 0, 15)
		if life <= 1:
			life = 0

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
		if life <= 1:
			life = 0

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
		if life <= 1:
			life = 0

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
		if life <= 1:
			life = 0

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
		if life <= 1:
			life = 0

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
		if life <= 1:
			life = 0

# 鼓舞，护盾。可以吸收一定数值的伤害
class b_Adloquium:
	extends Buff
	var total = 0
	func _init(dur = 1, val = 0):
		attInit()
		id = "b_Adloquium"
		total = val
		life = dur
		isNegetive = false

	func _connect():
		var bf = masCha.hasBuff("b_Night")
		if bf != null:
			bf.isDel = true
		masCha.connect("onHurt", self, "onHurt")

	func _upS():
		life = clamp(life, 0, 10)
		if life <= 1:
			life = 0

	func onHurt(atkInfo:AtkInfo):
		if total >= 0:
			if total > atkInfo.hurtVal:
				total -= atkInfo.hurtVal
				atkInfo.hurtVal = 0
			else:
				atkInfo.hurtVal -= total
				total = 0
		elif total <= 0:
			total = 0

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
		masCha.connect("onHurt", self, "onHurt")

	func onHurt(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 0.9

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 10)
		if life <= 1:
			life = 0			

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
		if life <= 1:
			life = 0

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
		if life <= 1:
			life = 0

	func onAtkChara(atkInfo:AtkInfo):
		if atkInfo.atkType != Chara.AtkType.EFF: 
			atkInfo.hurtVal *= 1.05

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
		if life <= 1:
			life = 0

# 行吟，减伤			
class b_Troubadour:
	extends Buff
	func _init():
		attInit()
		id = "b_Troubadour"
		isNegetive = false

	func _connect():
		masCha.connect("onHurt", self, "onHurt")

	func onHurt(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 0.90

# 钢铁意志，提高防御，固定减伤
class b_SteelBelief:
	extends Buff
	func _init():
		attInit()
		id = "b_SteelBelief"
		isNegetive = false
		att.defL = 0.10

	func _connect():
		masCha.connect("onHurt", self, "onHurt")

	func onHurt(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 0.90

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
		if life <= 1:
			life = 0

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
		if life < 1:
			life = 0

# 过载			
class b_Overload:
	extends Buff
	func _init(dur = 1):
		._init()
		attInit()
		id = "b_Overload"
		isNegetive = false
		life = dur

	func _upS():
		if life > 5:
			att.atkR = 0.20
		else:
			att.atkR = -0.10 
		life = clamp(life, 0, 13)
		if life < 1:
			life = 0

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
		if life <= 1:
			life = 0

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
		if life <= 1:
			life = 0

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
		if life <= 1:
			life = 0

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
		if life <= 1:
			life = 0

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
		if life <= 1:
			life = 0

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
		if life <= 1:
			life = 0

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
		var bf = masCha.hasBuff("b_Adloquium")
		if bf != null:
			bf.isDel = true
		masCha.connect("onHurt", self, "onHurt")

	func _upS():
		life = clamp(life, 0, 10)
		if life <= 1:
			life = 0

	func onHurt(atkInfo:AtkInfo):
		if total >= 0:
			if total > atkInfo.hurtVal:
				total -= atkInfo.hurtVal
				atkInfo.hurtVal = 0
			else:
				atkInfo.hurtVal -= total
				total = 0
		elif total <= 0:
			total = 0

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