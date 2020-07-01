class BaseBuff extends Buff:
	var Utils = globalData.infoDs["g_aFFXIVUtils"]
	var lifeMax
	func _init(config = {
			"cha": null
		}):
		attInit()
		life = _get(config, "dur", null)
		casCha = _get(config, "cas", null)
		lifeMax = _get(config, "limit", 0)
		var cha = _get(config, "cha", null)
		addBuff(cha)

	func _upS():
		if lifeMax > 0:
			life = clamp(life, 0, lifeMax)
	
	func _get(config, name, default):
		if config.has(name):
			return config[name]
		else:
			return default

	func addBuff(cha):
		if cha != null:
			cha.addBuff(self)

	func conflict(cha, buffId):
		var bf = cha.hasBuff(buffId)
		if bf != null and bf != self:
			bf.isDel = true


class BassShield extends BaseBuff:
	var shieldValue = 0
	func _init(config = {
			"cha": null
		}):
		._init(config)

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
			atkInfo.hurtVal = 0
		else:
			atkInfo.hurtVal -= shieldValue

		shieldValue -= atkInfo.hurtVal
		if shieldValue <= 0:
			self.isDel = true


class ReduceDamage extends BaseBuff:
	var reduce_type = null
	var reduce_pw = 0
	var MGI = Chara.HurtType.MGI
	var PHY = Chara.HurtType.PHY
	var REAL = Chara.HurtType.REAL

	func _init(config = {
			"cha": null
		}):
		._init(config)

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		if reduce_type == null:
			atkInfo.hurtVal *= 1 - reduce_pw
		elif reduce_type == atkInfo.hurtType:
			atkInfo.hurtVal *= 1 - reduce_pw


# 深恶痛绝
class b_Abhor:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Abhor"
		isNegetive = false
		att.mgiDefL = 0.10


# 暗黑布道
class b_DarkMissionary:
	extends ReduceDamage
	func _init(config):
		._init(config)
		id = "b_DarkMissionary"
		isNegetive = false
		reduce_type = MGI
		reduce_pw = 0.10

	func _upS():
		life = clamp(life, 0, 6)

# 至黑之夜
class b_TheBlackestNight:
	extends BassShield
	func _init(config):
		._init(config)
		id = "b_TheBlackestNight"
		isNegetive = false
		self.shieldValue = _get(config, "HD", 0)
		Utils.draw_efftext("至黑之夜", config.cha.position, "#872a8b")

# 活死人，无敌，但是还是会死
class b_LivingDeath:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_LivingDeath"
		isNegetive = false
		Utils.draw_efftext("活死人", config.cha.position, "#d0d0d0")

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		atkInfo.hurtVal = 0

	func _del():
		if life < 0:
			masCha.att.hp = 1

# 强甲破点突，削弱双抗
class b_ArmorCrush:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_ArmorCrush"
		isNegetive = false
		att.defL -= _get(config, "PW", 0)
		att.mgiDefL -= _get(config, "PW", 0)
		Utils.draw_efftext("强甲破点突", config.cha.position, "#59DFD7", false)

	func _upS():
		life = clamp(life, 0, 7)

# 战栗，提高最大生命值和治疗量
class b_Shiver:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Shiver"
		isNegetive = false
		att.maxHpL = 0.20
		att.reHp = 0.20
		Utils.draw_efftext("战栗", config.cha.position, "#3cff00")

# 原初的解放，提高暴击率
class b_InnerRelease:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_InnerRelease"
		isNegetive = false
		att.cri = 1
		Utils.draw_efftext("原初的解放", config.cha.position, "#ff0000")


# 超火流星，无敌
class b_Superbolide:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Superbolide"
		isNegetive = false

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		atkInfo.hurtVal = 0

	func _upS():
		life = clamp(life, 0, 10)

# 光之心，减少魔法伤害
class b_HeartOfLight:
	extends ReduceDamage
	func _init(config):
		._init(config)
		id = "b_HeartOfLight"
		isNegetive = false
		reduce_type = MGI
		reduce_pw = 0.10
		Utils.draw_efftext("光之心", config.cha.position, "#59DFD7")

	func _upS():
		life = clamp(life, 0, 10)

# 舞伴，攻击力提高
class b_DancingPartner:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_DancingPartner"
		isNegetive = false
		att.atkL = 0.10
		att.mgiAtkL = 0.10
		Utils.draw_efftext("舞伴", config.cha.position, "#F7BC79")

# 伶俐，攻击力提高
class b_DanceStep:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_DanceStep"
		isNegetive = false
		att.atkL = 0.10
		att.mgiAtkL = 0.10

	func _upS():
		life = clamp(life, 0, 10)

class b_Devilment:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Devilment"
		isNegetive = false
		att.atkL = 0.20
		att.mgiAtkL = 0.20

	func _upS():
		life = clamp(life, 0, 8)

# 再生，持续恢复
class b_Regen:
	extends BaseBuff
	var hot = 0
	func _init(config):
		._init(config)
		id = "b_Regen"
		hot = _get(config, "hot", 0)

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 18)

# 黑魔纹，冷却缩减
class b_LeyLines:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_LeyLines"
		isNegetive = false
		att.cd = 0.15
		Utils.draw_efftext("黑魔纹", config.cha.position, "#cb2dff")

	func _upS():
		life = clamp(life, 0, 30)

# 天语
class b_Enochian:
	extends BaseBuff
	var step
	func _init(config):
		._init(config)
		id = "b_Enochian"
		isNegetive = false
		step = _get(config, "lv", 1)

	func _connect():
		masCha.connect("onAtkChara", self, "run")
	
	func run(atkInfo):
		if atkInfo.atkType != Chara.AtkType.EFF:
			atkInfo.hurtVal *= 1 + (0.05 * (step - 1))

# 倍增,提高法强
class b_Manafication:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Manafication"
		isNegetive = false
		att.mgiAtkL = 0.10

	func _upS():
		life = clamp(life, 0, 10)

# 鼓舞，护盾。可以吸收一定数值的伤害
class b_Adloquium:
	extends BassShield
	func _init(config):
		._init(config)
		id = "b_Adloquium"
		isNegetive = false
		self.shieldValue = _get(config, "HD", 0)

		conflict(config.cha, "b_Night")
		updateShield(config.cha)

		Utils.draw_efftext("鼓舞", config.cha.position, "#1a8a00")

	func _upS():
		life = clamp(life, 0, 10)

# 野战治疗阵，减伤，持续恢复
class b_SacredSoil:
	extends ReduceDamage
	var hot = 0
	func _init(config):
		._init(config)
		id = "b_SacredSoil"
		isNegetive = false
		reduce_pw = 0.10
		hot = _get(config, "hot", 0)

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 10)

# 连环计
class b_ChainStratagem:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_ChainStratagem"
		isNegetive = false
		Utils.draw_efftext("连环计", config.cha.position, "#3aa1e9", false)
	
	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		if sys.rndPer(10):
			atkInfo.hurtVal *= 2
			atkInfo.isCri = true

# 龙神迸发，提高法强
class b_Dreadwyrm:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Dreadwyrm"
		isNegetive = false
		att.mgiAtkL = 0.20
		Utils.draw_efftext("附体", config.cha.position, "#21f2ff")

	func _upS():
		life = clamp(life, 0, 8)

# 剧毒菌，持续伤害
class b_Bio:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Bio"
		isNegetive = true
		Utils.draw_efftext("剧毒菌", config.cha.position, "#DEE254", false)

	func _upS():
		casCha.hurtChara(masCha, casCha.att.mgiAtk * 0.05, Chara.HurtType.MGI, Chara.AtkType.SKILL)
		life = clamp(life, 0, 10)

# 瘴暍，持续伤害
class b_Miasma:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Miasma"
		isNegetive = true
		Utils.draw_efftext("瘴暍", config.cha.position, "#59DFD7", false)

	func _upS():
		casCha.hurtChara(masCha, casCha.att.mgiAtk * 0.05, Chara.HurtType.MGI, Chara.AtkType.SKILL)
		life = clamp(life, 0, 10)

# 贤者的叙事谣，提高非特效伤害
class b_Ballad:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Ballad"
		isNegetive = false
	
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
	func _init(config):
		._init(config)
		id = "b_Paean"
		isNegetive = false
	
	func _connect():
		masCha.connect("onAddBuff", self, "onAddBuff")

	func onAddBuff(buff:Buff):
		if buff.isNegetive:
			buff.isDel = true

	func _upS():
		life = clamp(life, 0, 3)

# 行吟，减伤			
class b_Troubadour:
	extends ReduceDamage
	func _init(config):
		._init(config)
		id = "b_Troubadour"
		isNegetive = false
		reduce_pw = 0.10
		conflict(config.cha, "b_Troubadour")

# 魔人曲。魔法易伤
class b_RequiemOfTheDevil:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_RequiemOfTheDevil"
		isNegetive = false
		conflict(config.cha, "b_RequiemOfTheDevil")
	
	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		if atkInfo.hurtType == Chara.HurtType.MGI: 
			atkInfo.hurtVal *= 1.1
		
# 钢铁意志，提高防御
class b_SteelBelief:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_SteelBelief"
		isNegetive = false
		att.defL = 0.10

# 安魂祈祷
class b_Requiescat:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Requiescat"
		isNegetive = false
		att.mgiAtk = 50
		Utils.draw_efftext("安魂祈祷", config.cha.position, "#0090ff")

	func _upS():
		life = clamp(life, 0, 15)

# 圣光幕帘，护盾。可以吸收一定数值的伤害
class b_DivineVeil:
	extends BassShield
	func _init(config):
		._init(config)
		id = "b_DivineVeil"
		isNegetive = false
		self.shieldValue = _get(config, "HD", 0)
		Utils.draw_efftext("圣光幕帘", config.cha.position, "#a6d8ff")

	func _upS():
		life = clamp(life, 0, 10)

class b_Mantra:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Mantra"
		isNegetive = false
		att.reHp = 0.10
		Utils.draw_efftext("真言", config.cha.position, "#ffd0a6")

	func _upS():
		life = clamp(life, 0, 10)

# 野火Buff
class b_Wildfire:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Wildfire"
		isNegetive = false
		Utils.draw_efftext("野火", config.cha.position, "#ff5f5f")

	func _upS():
		life = clamp(life, 0, 7)

# 过载			
class b_Overload:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Overload"
		isNegetive = false
		att.atkL = 0.20
		Utils.draw_efftext("过载", config.cha.position, "#ff5f5f")

	func _upS():
		life = clamp(life, 0, 8)

# 太阳神之衡  
class b_Balance:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Balance"
		isNegetive = false
		att.atkL = 0.20
		att.mgiAtkL = 0.20
		print(config)

	func _upS():
		life = clamp(life, 0, 20)

# 放浪神之箭  
class b_Arrow:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Arrow"
		isNegetive = false
		att.spd = 0.20
		print(config)

	func _upS():
		life = clamp(life, 0, 20)

# 战争神之枪     
class b_Spear:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Spear"
		isNegetive = false
		att.cri = 0.20
		print(config)

	func _upS():
		life = clamp(life, 0, 20)

# 世界树之干
class b_Bole:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Bole"
		isNegetive = false
		att.defL = 0.20
		print(config)

	func _upS():
		life = clamp(life, 0, 20)

# 河流神之瓶
class b_Ewer:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Ewer"
		isNegetive = false
		att.cd = 0.20
		print(config)

	func _upS():
		life = clamp(life, 0, 20)

# 建筑神之塔
class b_Spire:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Spire"
		isNegetive = false
		att.mgiDefL = 0.20
		print(config)

	func _upS():
		life = clamp(life, 0, 20)

# 吉星
class b_LuckyStar:
	extends BaseBuff
	var hot = 0
	func _init(config):
		._init(config)
		id = "b_LuckyStar"
		isNegetive = false
		hot = _get(config, "hot", 0)

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 8)

# 黑夜领域，护盾。可以吸收一定数值的伤害
class b_Night:
	extends BassShield
	func _init(config):
		._init(config)
		id = "b_Night"
		isNegetive = false
		self.shieldValue = _get(config, "HD", 0)
		conflict(config.cha, "b_Adloquium")
		updateShield(config.cha)
		Utils.draw_efftext("黑夜领域", config.cha.position, "#d05fff")

	func _upS():
		life = clamp(life, 0, 10)

# 命运之轮，减少伤害
class b_Collective:
	extends ReduceDamage
	func _init(config):
		._init(config)
		id = "b_Collective"
		isNegetive = false
		reduce_pw = 0.10
		Utils.draw_efftext("命运之轮", config.cha.position, "#00fcff")

	func _upS():
		life = clamp(life, 0, 18)

# 红莲龙血
class b_LifeOfTheDragon:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_LifeOfTheDragon"
		isNegetive = false
		att.atkL = 0.15
		Utils.draw_efftext("红莲龙血", config.cha.position, "#ff0000")

	func _upS():
		life = clamp(life, 0, 15)

# 易伤
class b_VulnerableSmall:
	extends BaseBuff
	func _init(config):
		._init(config)
		isNegetive = false
		id = "b_VulnerableSmall"
		Utils.draw_efftext("易伤", config.cha.position, "#59DFD7", false)

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo):
		atkInfo.hurtVal *= 1.3
		
# 物理耐性下降·大
class b_VulnerableLarge:
	extends BaseBuff
	func _init(config):
		._init(config)
		isNegetive = false
		id = "b_VulnerableLarge"
		Utils.draw_efftext("物理耐性下降·大", config.cha.position, "#59DFD7", false)
	
	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo):
		if atkInfo.atkType == Chara.AtkType.NORMAL:
			atkInfo.hurtVal *= 99


# 分摊特效
class b_Share:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_Share"
		isNegetive = false
		eff = Utils.draw_effect("share", config.cha.position, Vector2(0, -20), 8, 3, true)

	func _del():
		eff.queue_free()

	func _process(a):
		eff.position = masCha.position


# 击飞旋转角色，至少2秒，且为0.8的整数倍
class RotateCha:
	extends BaseBuff
	var n = 0
	var exit = false
	var tarCha = null
	func _init(config):
		._init(config)
		id = "b_RotateCha"
		isNegetive = false
		n = config.dur * 10
		tarCha = config.cha
		rotateCha()

	func _connect():
		sys.main.connect("tree_exited", self, "gameExit")

	func gameExit():
		exit = true

	func rotateCha():
		# 比较蠢的旋转动画
		tarCha.get_node("ui").visible = false
		tarCha.img.set_pivot_offset(tarCha.img.rect_size / 2)
		for i in range(n):
			yield(sys.get_tree().create_timer(0.1), "timeout")
			if tarCha and !exit and !isDel:
				if i < 10:
					tarCha.normalSpr.position += Vector2(0, -15)
				elif i > n - 10:
					tarCha.normalSpr.position += Vector2(0, 15)
				tarCha.img.set_rotation_degrees(45 * i)
			else:
				return

	func _del():
		tarCha.get_node("ui").visible = true

	func _upS():
		if life < 1:
			tarCha.get_node("ui").visible = true

# 关闭自动攻击 有上限
class b_StaticTime:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_StaticTime"
		isNegetive = false
		config.cha.aiOn = false

	func _del():
		if !masCha.hasBuff("b_StaticTimeUnlock"):
			masCha.aiOn = true

	func _upS():
		life = clamp(life, 0, 2)

# 关闭自动攻击 无上限
class b_StaticTimeUnlock:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_StaticTimeUnlock"
		isNegetive = false
		config.cha.aiOn = false

	func _del():
		masCha.aiOn = true

	func _upS():
		masCha.aiOn = false

# 冻结CD
class b_FrozenCdSkill:
	extends BaseBuff
	func _init(config):
		._init(config)
		id = "b_FrozenCdSkill"
		isNegetive = false
		att.cd = -config.cha.att.cd - 1
