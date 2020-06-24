class BaseBuff extends Buff:
	var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
	var shieldBar:TextureProgress = null
	var shieldBarValue = 0
	# 当我不想对在角色文件中使用addBuff的时候，我会把角色传到buff里面使用addBuff()
	func addBuff(cha):
		if cha != null:
			cha.addBuff(self)

	# 我不想让两个不同的buff同时生效，我就要删除它
	func conflict(cha, buffId):
		var bf = cha.hasBuff(buffId)
		if bf != null and bf != self:
			bf.isDel = true

class BassShield extends BaseBuff:
	var shieldValue = 0

	# 给目标套上一个同种护盾，需要更新目标身上的护盾值
	func updateShield(cha):
		if cha == null:
			return
		var bf = cha.hasBuff(self.id)
		if bf != null and bf != self:
			bf.shieldValue = self.shieldValue

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		if shieldValue > atkInfo.hurtVal:
			shieldValue -= atkInfo.hurtVal
			atkInfo.hurtVal = 0
		else:
			atkInfo.hurtVal -= shieldValue
			shieldValue = 0

		if shieldValue <= 0:
			self.isDel = true


class ReduceDemage extends BaseBuff:
	var reduce_type = null
	var reduce_pw = 0

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		if reduce_type == null:
			atkInfo.hurtVal *= 1 - reduce_pw
		elif reduce_type == atkInfo.hurtType:
			atkInfo.hurtVal *= 1 - reduce_pw

# 深恶痛绝，提高魔防
class b_Abhor:
	extends BaseBuff
	func _init(cha = null):
		attInit()
		id = "b_Abhor"
		isNegetive = false
		att.mgiDefL = 0.10
		addBuff(cha)

# 暗黑布道，减少魔法伤害
class b_DarkMissionary:
	extends ReduceDemage
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_DarkMissionary"
		life = dur
		isNegetive = false
		reduce_type = Chara.HurtType.MGI
		reduce_pw = 0.10
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 6)

# 至黑之夜，护盾。可以吸收一定数值的伤害
class b_TheBlackestNight:
	extends BassShield
	func _init(val = 0, cha = null):
		attInit()
		id = "b_TheBlackestNight"
		self.shieldValue = val
		isNegetive = false
		addBuff(cha)

# 活死人，无敌，但是还是会死
class b_LivingDeath:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_LivingDeath"
		isNegetive = false
		life = dur
		addBuff(cha)

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		atkInfo.hurtVal = 0

	func _upS():
		life = clamp(life, 0, 10)

	func _del():
		if life < 0:
			masCha.att.hp = 1

# 强甲破点突，削弱双抗
class b_ArmorCrush:
	extends BaseBuff
	func _init(dur = 1, pw = 0.15, cha = null):
		attInit()
		id = "b_ArmorCrush"
		life = dur
		att.defL -= pw
		att.mgiDefL -= pw
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 7)

# 战栗，提高最大生命值和治疗量
class b_Shiver:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Shiver"
		isNegetive = false
		life = dur
		att.maxHpL = 0.20
		att.reHp = 0.20
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 20)

# 原初的解放，提高暴击率
class b_InnerRelease:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_InnerRelease"
		isNegetive = false
		att.cri = 1
		life = dur
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 8)

# 超火流星，无敌
class b_Superbolide:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Superbolide"
		isNegetive = false
		life = dur
		addBuff(cha)

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		atkInfo.hurtVal = 0

	func _upS():
		life = clamp(life, 0, 10)

# 光之心，减少{TMgiHurt}
class b_HeartOfLight:
	extends ReduceDemage
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_HeartOfLight"
		life = dur
		isNegetive = false
		reduce_type = Chara.HurtType.MGI
		reduce_pw = 0.10
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 10)

# 舞伴，攻击力提高
class b_DancingPartner:
	extends BaseBuff
	func _init(cha = null):
		attInit()
		id = "b_DancingPartner"
		isNegetive = false
		att.atkL = 0.10
		att.mgiAtkL = 0.10
		addBuff(cha)

# 伶俐，攻击力提高
class b_DanceStep:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_DanceStep"
		isNegetive = false
		life = dur
		att.atkL = 0.10
		att.mgiAtkL = 0.10
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 10)

class b_Devilment:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_DanceStep"
		isNegetive = false
		life = dur
		att.atkL = 0.20
		att.mgiAtkL = 0.20
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 8)

# 再生，持续恢复
class b_Regen:
	extends BaseBuff
	var hot = 0
	func _init(dur = 1, val = 0, cha = null):
		attInit()
		id = "b_Regen"
		hot = val
		life = dur
		addBuff(cha)

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 18)

# 黑魔纹，冷却缩减
class b_LeyLines:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_LeyLines"
		isNegetive = false
		att.cd = 0.15
		life = dur
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 30)

# 天语
class b_Enochian:
	extends BaseBuff
	func _init(lv = 1, cha = null):
		attInit()
		id = "b_Enochian"
		isNegetive = false
		addBuff(cha)

	func _connect():
		masCha.connect("onAtkChara", self, "run")
	
	func run(atkInfo):
		if atkInfo.atkType != Chara.AtkType.EFF:
			atkInfo.hurtVal *= 1 + (0.05 * (lv - 1))

# 倍增,提高法强
class b_Manafication:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Manafication"
		isNegetive = false
		life = dur
		att.mgiAtkL = 0.10
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 10)

# 鼓舞，护盾。可以吸收一定数值的伤害
class b_Adloquium:
	extends BassShield
	func _init(dur = 1, val = 0, cha = null):
		attInit()
		id = "b_Adloquium"
		self.shieldValue = val
		life = dur
		isNegetive = false
		conflict(cha, "b_Night")
		addBuff(cha)
		updateShield(cha)

	func _upS():
		life = clamp(life, 0, 10)

# 野战治疗阵，减伤，持续恢复
class b_SacredSoil:
	extends ReduceDemage
	var hot = 0
	func _init(dur = 1, val = 0, cha = null):
		attInit()
		id = "b_SacredSoil"
		hot = val
		life = dur
		isNegetive = false
		reduce_pw = 0.10
		addBuff(cha)

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 10)

# 连环计
class b_ChainStratagem:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_ChainStratagem"
		life = dur
		isNegetive = false
		addBuff(cha)
	
	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		if sys.rndPer(10):
			atkInfo.hurtVal *= 2
			atkInfo.isCri = true

# 龙神迸发，提高法强
class b_Dreadwyrm:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Dreadwyrm"
		life = dur
		isNegetive = false
		att.mgiAtkL = 0.20
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 8)

# 贤者的叙事谣，提高非特效伤害
class b_Ballad:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Ballad"
		isNegetive = false
		life = dur
		addBuff(cha)
	
	func _connect():
		masCha.connect("onAtkChara", self, "onAtkChara")

	func _upS():
		life = clamp(life, 0, 8)

	func onAtkChara(atkInfo:AtkInfo):
		if atkInfo.atkType != Chara.AtkType.EFF: 
			atkInfo.hurtVal *= 1.08

# 光阴神的礼赞凯歌，debuff免疫
class b_Paean:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Paean"
		isNegetive = false
		life = dur
		addBuff(cha)
	
	func _connect():
		masCha.connect("onAddBuff", self, "onAddBuff")

	func onAddBuff(buff:Buff):
		if buff.isNegetive:
			buff.isDel = true

	func _upS():
		life = clamp(life, 0, 3)

# 行吟，减伤			
class b_Troubadour:
	extends ReduceDemage
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Troubadour"
		isNegetive = false
		life = dur
		reduce_pw = 0.10
		conflict(cha, "b_Troubadour")
		addBuff(cha)

# 魔人曲。魔法易伤
class b_RequiemOfTheDevil:
	extends BaseBuff
	func _init(cha = null):
		attInit()
		id = "b_RequiemOfTheDevil"
		isNegetive = false
		conflict(cha, "b_RequiemOfTheDevil")
		addBuff(cha)
	
	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		if atkInfo.hurtType == Chara.HurtType.MGI: 
			atkInfo.hurtVal *= 1.1
		
# 钢铁意志，提高防御
class b_SteelBelief:
	extends BaseBuff
	func _init(cha = null):
		attInit()
		id = "b_SteelBelief"
		isNegetive = false
		att.defL = 0.10
		addBuff(cha)

# 安魂祈祷
class b_Requiescat:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Requiescat"
		life = dur
		isNegetive = false
		att.mgiAtk = 50
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 15)

# 圣光幕帘，护盾。可以吸收一定数值的伤害
class b_DivineVeil:
	extends BassShield
	func _init(dur = 1, val = 0, cha = null):
		attInit()
		id = "b_DivineVeil"
		self.shieldValue = val
		isNegetive = false
		life = dur
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 10)

class b_Mantra:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Mantra"
		isNegetive = false
		life = dur
		att.reHp = 0.10
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 10)

# 野火Buff
class b_Wildfire:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Wildfire"
		isNegetive = false
		life = dur
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 7)

# 过载			
class b_Overload:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Overload"
		isNegetive = false
		att.atkL = 0.20
		life = dur
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 8)

# 太阳神之衡  
class b_Balance:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Balance"
		isNegetive = false
		att.atkL = 0.20
		att.mgiAtkL = 0.20
		life = dur
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 20)

# 放浪神之箭  
class b_Arrow:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Arrow"
		isNegetive = false
		att.spd = 0.20
		life = dur
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 20)

# 战争神之枪     
class b_Spear:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Spear"
		isNegetive = false
		att.cri = 0.20
		life = dur
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 20)

# 世界树之干
class b_Bole:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Bole"
		isNegetive = false
		att.defL = 0.20
		life = dur
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 20)

# 河流神之瓶
class b_Ewer:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Ewer"
		isNegetive = false
		att.cd = 0.20
		life = dur
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 20)

# 建筑神之塔
class b_Spire:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Spire"
		isNegetive = false
		att.mgiDefL = 0.20
		life = dur
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 20)

# 吉星
class b_LuckyStar:
	extends BaseBuff
	var hot = 0
	func _init(dur = 1, val = 0, cha = null):
		attInit()
		id = "b_LuckyStar"
		isNegetive = false
		hot = val
		life = dur
		addBuff(cha)

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 8)

# 黑夜领域，护盾。可以吸收一定数值的伤害
class b_Night:
	extends BassShield
	func _init(dur = 1, val = 0, cha = null):
		attInit()
		id = "b_Night"
		self.shieldValue = val
		isNegetive = false
		life = dur
		conflict(cha, "b_Adloquium")
		addBuff(cha)
		updateShield(cha)

	func _upS():
		life = clamp(life, 0, 10)

# 命运之轮，减少伤害
class b_Collective:
	extends ReduceDemage
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_Collective"
		life = dur
		isNegetive = false
		reduce_pw = 0.10
		addBuff(cha)
			
	func _upS():
		life = clamp(life, 0, 18)

# 红莲龙血
class b_LifeOfTheDragon:
	extends BaseBuff
	func _init(dur = 1, cha = null):
		attInit()
		id = "b_LifeOfTheDragon"
		isNegetive = false
		att.atkL = 0.15
		life = dur
		addBuff(cha)

	func _upS():
		life = clamp(life, 0, 15)

# 静止不动
class b_StaticTime:
	extends BaseBuff
	var oriAi
	func _init(lv = 1, cha = null):
		attInit()
		id = "b_StaticTime"
		life = lv
		isNegetive = false
		addBuff(cha)

	func _connect():
		oriAi = masCha.aiOn
		masCha.aiOn = false

	func _del():
		._del()
		masCha.aiOn = oriAi
		masCha.isMoveIng = false

	func _upS():
		masCha.isMoveIng = true
		life = clamp(life, 0, 2)

class b_Test:
	extends Buff
	func _init(lv):
		attInit()
		id = "test"
		life = lv
		att.atk = 100
		
	func _connect():
		var direc = masCha.direc
		eff = sys.newEff("animEff", masCha.position)
		eff.setImgs(direc + '你图片的文件地址', 15, false)
		# eff.normalSpr.position = Vector2(0, 0)
		# eff.rotation = deg2rad(0)
		# eff.scale *= 1

	func _process(a):
		eff.position = masCha.position


# 添加A_buff，判断目标是否持有【护盾基类buff】，没有则创建一个护盾槽，挂在角色节点上
# 添加B_buff，判断目标是有持有【护盾基类buff】，有，则将护盾值累加在护盾槽
# 当B_buff消失，目标护盾槽减少b_buff的剩余护盾值

# 当任意护盾buff的护盾值更新，都要触发目标护盾槽值的变化