class BaseBuff extends Buff:
	const MGI = Chara.HurtType.MGI
	const PHY = Chara.HurtType.PHY
	const REAL = Chara.HurtType.REAL
	const NORMAL = Chara.AtkType.NORMAL
	const SKILL = Chara.AtkType.SKILL
	const EFF = Chara.AtkType.EFF
	var Utils = globalData.infoDs["g_aFFXIVUtils"]
	var target = null
	func _init():
		attInit()
	func _set_config(buffId, config, negetive = false):
		id = buffId
		isNegetive = negetive
		life = _get(config, "dur", null)
		target = _get(config, "cha", null)
		if target != null:
			target.addBuff(self)
		casCha = _get(config, "cas", null)
	func _get(config, name, default = null):
		if config.has(name):
			return config[name]
		else:
			return default
	func _conflict(buffId):
		var bf = target.hasBuff(buffId)
		if bf != null and bf != self:
			bf.isDel = true

# 护盾基类
class BassShield extends BaseBuff:
	var shieldValue = 0
	func _updateShield():
		var bf = target.hasBuff(self.id)
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

# 减伤基类
class ReduceDamage extends BaseBuff:
	var reduce_type = null
	var reduce_pw = 0
	func _connect():
		masCha.connect("onHurt", self, "run")
	func run(atkInfo:AtkInfo):
		if reduce_type == null:
			atkInfo.hurtVal *= 1 - reduce_pw
		elif reduce_type == atkInfo.hurtType:
			atkInfo.hurtVal *= 1 - reduce_pw


# 深恶痛绝
class b_Abhor extends BaseBuff:
	func _init(config):
		_set_config("b_Abhor", config)
		att.mgiDefL = 0.10


# 暗黑布道
class b_DarkMissionary extends ReduceDamage:
	func _init(config):
		_set_config("b_DarkMissionary", config)
		reduce_type = MGI
		reduce_pw = 0.10

	func _upS():
		life = clamp(life, 0, 6)

# 至黑之夜
class b_TheBlackestNight extends BassShield:
	func _init(config):
		_set_config("b_TheBlackestNight", config)
		self.shieldValue = _get(config, "HD", 0)
	func _connect():
		._connect()
		Utils.draw_efftext("至黑之夜", masCha.position, "#872a8b")

# 活死人，无敌，但是还是会死
class b_LivingDeath extends BaseBuff:
	func _init(config):
		_set_config("b_LivingDeath", config)

	func _connect():
		masCha.connect("onHurt", self, "run")
		Utils.draw_efftext("活死人", masCha.position, "#d0d0d0")

	func run(atkInfo:AtkInfo):
		atkInfo.hurtVal = 0

	func _del():
		if life < 0:
			masCha.att.hp = -1

# 攻其不备
class b_TrickAttack extends BaseBuff:
	func _init(config):
		_set_config("b_TrickAttack", config)

	func _connect():
		masCha.connect("onHurt", self, "run")
		Utils.draw_efftext("受伤加重", masCha.position, "#59DFD7", false)

	func run(atkInfo:AtkInfo):
		atkInfo.hurtVal *= 1.20
	
	func _upS():
		life = clamp(life, 0, 10)

# 强甲破点突，削弱双抗
class b_ArmorCrush extends BaseBuff:
	func _init(config):
		_set_config("b_ArmorCrush", config)
		att.defL -= _get(config, "PW", 0)
		att.mgiDefL -= _get(config, "PW", 0)

	func _connect():
		Utils.draw_efftext("强甲破点突", masCha.position, "#59DFD7", false)

	func _upS():
		life = clamp(life, 0, 7)

# 战栗，提高最大生命值和治疗量
class b_Shiver extends BaseBuff:
	func _init(config):
		_set_config("b_Shiver", config)
		att.maxHpL = 0.20
		att.reHp = 0.20

	func _connect():
		Utils.draw_efftext("战栗", masCha.position, "#3cff00")

# 原初的解放，提高暴击率
class b_InnerRelease extends BaseBuff:
	func _init(config):
		_set_config("b_InnerRelease", config)
		att.cri = 1

	func _connect():
		Utils.draw_efftext("原初的解放", masCha.position, "#ff0000")


# 超火流星，无敌
class b_Superbolide	extends BaseBuff:
	func _init(config):
		_set_config("b_Superbolide", config)

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		atkInfo.hurtVal = 0

	func _upS():
		life = clamp(life, 0, 10)

# 光之心，减少魔法伤害
class b_HeartOfLight extends ReduceDamage:
	func _init(config):
		_set_config("b_HeartOfLight", config)
		reduce_type = MGI
		reduce_pw = 0.10

	func _connect():
		._connect()
		Utils.draw_efftext("光之心", masCha.position, "#59DFD7")

	func _upS():
		life = clamp(life, 0, 10)

# 舞伴，攻击力提高
class b_DancingPartner extends BaseBuff:
	func _init(config):
		_set_config("b_DancingPartner", config)
		att.atkL = 0.10
		att.mgiAtkL = 0.10

	func _connect():
		Utils.draw_efftext("舞伴", masCha.position, "#F7BC79")

# 伶俐，攻击力提高
class b_DanceStep	extends BaseBuff:
	func _init(config):
		_set_config("b_DanceStep", config)
		att.atkL = 0.10
		att.mgiAtkL = 0.10

	func _upS():
		life = clamp(life, 0, 10)

class b_Devilment extends BaseBuff:
	func _init(config):
		_set_config("b_Devilment", config)
		att.atkL = 0.20
		att.mgiAtkL = 0.20

	func _upS():
		life = clamp(life, 0, 8)

# 再生，持续恢复
class b_Regen extends BaseBuff:
	var hot = 0
	func _init(config):
		_set_config("b_Regen", config)
		hot = _get(config, "hot", 0)

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 18)

# 黑魔纹，冷却缩减
class b_LeyLines extends BaseBuff:
	func _init(config):
		_set_config("b_LeyLines", config)
		att.cd = 0.15

	func _connect():
		Utils.draw_efftext("黑魔纹", masCha.position, "#cb2dff")

	func _upS():
		life = clamp(life, 0, 30)

# 天语
class b_Enochian extends BaseBuff:
	var step
	func _init(config):
		_set_config("b_Enochian", config)
		step = _get(config, "lv", 1)

	func _connect():
		masCha.connect("onAtkChara", self, "run")

	func run(atkInfo):
		if atkInfo.atkType != EFF:
			atkInfo.hurtVal *= 1.1 + (0.05 * (step - 1))

# 倍增,提高法强
class b_Manafication extends BaseBuff:
	func _init(config):
		_set_config("b_Manafication", config)
		att.mgiAtkL = 0.10

	func _upS():
		life = clamp(life, 0, 10)

# 鼓舞，护盾。可以吸收一定数值的伤害
class b_Adloquium	extends BassShield:
	func _init(config):
		_set_config("b_Adloquium", config)
		_conflict("b_Night")
		self.shieldValue = _get(config, "HD", 0)
		_updateShield()

	func _connect():
		._connect()
		Utils.draw_efftext("鼓舞", masCha.position, "#1a8a00")

	func _upS():
		life = clamp(life, 0, 10)

# 野战治疗阵，减伤，持续恢复
class b_SacredSoil extends ReduceDamage:
	var hot = 0
	func _init(config):
		_set_config("b_SacredSoil", config)
		reduce_pw = 0.10
		hot = _get(config, "hot", 0)

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 10)

# 仙光的低语
class b_Whispering extends BaseBuff:
	var hot = 0
	func _init(config):
		_set_config("b_Whispering", config)
		hot = _get(config, "hot", 0)

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 10)

# 连环计
class b_ChainStratagem extends BaseBuff:
	func _init(config):
		_set_config("b_ChainStratagem", config)

	func _connect():
		masCha.connect("onHurt", self, "run")
		Utils.draw_efftext("连环计", masCha.position, "#3aa1e9", false)

	func run(atkInfo:AtkInfo):
		if sys.rndPer(10):
			atkInfo.hurtVal *= 2
			atkInfo.isCri = true

# 龙神迸发，提高法强
class b_Dreadwyrm	extends BaseBuff:
	func _init(config):
		_set_config("b_Dreadwyrm", config)
		att.mgiAtkL = 0.20

	func _connect():
		Utils.draw_efftext("附体", masCha.position, "#21f2ff")

	func _upS():
		life = clamp(life, 0, 8)

# 剧毒菌，持续伤害
class b_Bio	extends BaseBuff:
	func _init(config):
		_set_config("b_Bio", config, true)

	func _connect():
		Utils.draw_efftext("剧毒菌", masCha.position, "#DEE254", false)

	func _upS():
		casCha.hurtChara(masCha, casCha.att.mgiAtk * 0.05, MGI, SKILL)
		life = clamp(life, 0, 10)

# 瘴暍，持续伤害
class b_Miasma extends BaseBuff:
	func _init(config):
		_set_config("b_Miasma", config, true)

	func _connect():
		Utils.draw_efftext("瘴暍", masCha.position, "#59DFD7", false)

	func _upS():
		casCha.hurtChara(masCha, casCha.att.mgiAtk * 0.05, MGI, SKILL)
		life = clamp(life, 0, 10)

# 螺旋气流，持续伤害
class b_Slipstream extends BaseBuff:
	func _init(config):
		_set_config("b_Slipstream", config, true)

	func _connect():
		Utils.draw_efftext("螺旋气流", masCha.position, "#58ff83", false)

	func _upS():
		casCha.hurtChara(masCha, casCha.att.mgiAtk * 0.05, MGI, SKILL)
		life = clamp(life, 0, 10)

# 贤者的叙事谣，提高非特效伤害
class b_Ballad extends BaseBuff:
	func _init(config):
		_set_config("b_Ballad", config)

	func _connect():
		masCha.connect("onAtkChara", self, "run")

	func _upS():
		life = clamp(life, 0, 8)

	func run(atkInfo:AtkInfo):
		if atkInfo.atkType != Chara.AtkType.EFF:
			atkInfo.hurtVal *= 1.08

# 大地神的抒情恋歌
class b_Paean	extends BaseBuff:
	func _init(config):
		_set_config("b_Paean", config)
		att.reHp = 0.20

	func _connect():
		Utils.draw_effect("ePcrD_1_1_10", masCha.position, Vector2(0, -30), 15, 0.5)

	func _upS():
		life = clamp(life, 0, 10)

# 行吟，策动，桑巴，减伤
class b_Troubadour extends ReduceDamage:
	func _init(config):
		_set_config("b_Troubadour", config)
		_conflict("b_Troubadour")
		reduce_pw = 0.10

# 魔人曲。魔法易伤
class b_RequiemOfTheDevil extends BaseBuff:
	func _init(config):
		_set_config("b_RequiemOfTheDevil", config)
		_conflict("b_RequiemOfTheDevil")

	func _connect():
		masCha.connect("onHurt", self, "run")

	func run(atkInfo:AtkInfo):
		if atkInfo.hurtType == MGI:
			atkInfo.hurtVal *= 1.1

# 钢铁意志，提高防御
class b_SteelBelief	extends BaseBuff:
	func _init(config):
		_set_config("b_SteelBelief", config)
		att.defL = 0.10

# 安魂祈祷
class b_Requiescat extends BaseBuff:
	func _init(config):
		_set_config("b_Requiescat", config)
		att.mgiAtk = 50

	func _connect():
		Utils.draw_efftext("安魂祈祷", masCha.position, "#0090ff")

	func _upS():
		life = clamp(life, 0, 15)

# 圣光幕帘，护盾。可以吸收一定数值的伤害
class b_DivineVeil extends BassShield:
	func _init(config):
		_set_config("b_DivineVeil", config)
		self.shieldValue = _get(config, "HD", 0)

	func _connect():
		._connect()
		Utils.draw_efftext("圣光幕帘", masCha.position, "#a6d8ff")

	func _upS():
		life = clamp(life, 0, 10)

class b_Mantra extends BaseBuff:
	func _init(config):
		_set_config("b_Mantra", config)
		att.reHp = 0.10

	func _connect():
		Utils.draw_efftext("真言", masCha.position, "#ffd0a6")

	func _upS():
		life = clamp(life, 0, 10)

# 野火Buff
class b_Wildfire extends BaseBuff:
	func _init(config):
		_set_config("b_Wildfire", config)

	func _connect():
		Utils.draw_efftext("野火", masCha.position, "#ff5f5f", false)

	func _upS():
		life = clamp(life, 0, 7)

# 过载
class b_Overload extends BaseBuff:
	func _init(config):
		_set_config("b_Overload", config)
		att.atkL = 0.20

	func _connect():
		Utils.draw_efftext("过载", masCha.position, "#ff5f5f")

	func _upS():
		life = clamp(life, 0, 8)

# 太阳神之衡
class b_Balance	extends BaseBuff:
	func _init(config):
		_set_config("b_Balance", config)
		att.atkL = 0.20
		att.mgiAtkL = 0.20

	func _upS():
		life = clamp(life, 0, 20)

# 放浪神之箭
class b_Arrow	extends BaseBuff:
	func _init(config):
		_set_config("b_Arrow", config)
		att.spd = 0.20

	func _upS():
		life = clamp(life, 0, 20)

# 战争神之枪
class b_Spear	extends BaseBuff:
	func _init(config):
		_set_config("b_Spear", config)
		att.cri = 0.20

	func _upS():
		life = clamp(life, 0, 20)

# 世界树之干
class b_Bole extends BaseBuff:
	func _init(config):
		_set_config("b_Bole", config)
		att.defL = 0.20

	func _upS():
		life = clamp(life, 0, 20)

# 河流神之瓶
class b_Ewer extends BaseBuff:
	func _init(config):
		_set_config("b_Ewer", config)
		att.cd = 0.20

	func _upS():
		life = clamp(life, 0, 20)

# 建筑神之塔
class b_Spire	extends BaseBuff:
	func _init(config):
		_set_config("b_Spire", config)
		att.mgiDefL = 0.20

	func _upS():
		life = clamp(life, 0, 20)

# 吉星
class b_LuckyStar	extends BaseBuff:
	var hot = 0
	func _init(config):
		_set_config("b_LuckyStar", config)
		hot = _get(config, "hot", 0)

	func _upS():
		masCha.plusHp(hot)
		life = clamp(life, 0, 8)

# 黑夜领域，护盾。可以吸收一定数值的伤害
class b_Night	extends BassShield:
	func _init(config):
		_set_config("b_Night", config)
		_conflict("b_Adloquium")
		self.shieldValue = _get(config, "HD", 0)
		_updateShield()

	func _connect():
		._connect()
		Utils.draw_efftext("黑夜领域", masCha.position, "#d05fff")

	func _upS():
		life = clamp(life, 0, 10)

# 命运之轮，减少伤害
class b_Collective extends ReduceDamage:
	func _init(config):
		_set_config("b_Collective", config)
		reduce_pw = 0.10

	func _connect():
		._connect()
		Utils.draw_efftext("命运之轮", masCha.position, "#00fcff")

	func _upS():
		life = clamp(life, 0, 18)

class b_Litany extends BaseBuff:
	func _init(config):
		_set_config("b_Litany", config)
		_conflict("b_Litany")
		att.cri += 0.10
	
	func _connect():
		Utils.draw_efftext("战斗连祷", masCha.position, "#99bfff")


# 红莲龙血
class b_LifeOfTheDragon	extends BaseBuff:
	func _init(config):
		_set_config("b_LifeOfTheDragon", config)
		att.atkL = 0.15

	func _connect():
		Utils.draw_efftext("红莲龙血", masCha.position, "#ff0000")

	func _upS():
		life = clamp(life, 0, 15)

# 易伤
class b_VulnerableSmall	extends BaseBuff:
	func _init(config):
		_set_config("b_VulnerableSmall", config)

	func _connect():
		masCha.connect("onHurt", self, "run")
		Utils.draw_efftext("易伤", masCha.position, "#59DFD7", false)

	func run(atkInfo):
		atkInfo.hurtVal *= 1.3

# 物理耐性下降·大
class b_VulnerableLarge	extends BaseBuff:
	func _init(config):
		_set_config("b_VulnerableLarge", config)

	func _connect():
		masCha.connect("onHurt", self, "run")
		Utils.draw_efftext("物理耐性下降·大", masCha.position, "#59DFD7", false)

	func run(atkInfo):
		if atkInfo.atkType == NORMAL:
			atkInfo.hurtVal *= 99

# 水耐性下降·大
class b_waterDown	extends BaseBuff:
	func _init(config):
		_set_config("b_waterDown", config)

	func _connect():
		masCha.connect("onHurt", self, "run")
		Utils.draw_efftext("水耐性下降·大", masCha.position, "#00a8ff", false)

	func run(atkInfo):
		if atkInfo.hurtType == Chara.HurtType.MGI and atkInfo.atkType == Chara.AtkType.SKILL:
			atkInfo.hurtVal *= 99


# 分摊特效
class b_Share	extends BaseBuff:
	func _init(config):
		_set_config("b_Share", config)

	func _connect():
		eff = Utils.draw_effect("share", masCha.position, Vector2(0, -20), 8, 3, true)

	func _del():
		eff.queue_free()

	func _process(a):
		eff.position = masCha.position



# 点名特效
class b_RollCall extends BaseBuff:
	func _init(config):
		_set_config("b_RollCall", config)

	func _connect():
		eff = Utils.draw_effect_v2({
			"name": "dianming",
			"pos": masCha.position,
			"dev": Vector2(0, -100),
			"fps": 4,
			"top": true,
			"rep": true
		})

	func _del():
		eff.queue_free()

	func _process(a):
		eff.position = masCha.position

# 击飞旋转角色，至少2秒，且为0.8的整数倍
class RotateCha	extends BaseBuff:
	var exit = false
	var n = 0
	func _init(config):
		_set_config("b_RotateCha", config)
		n = config.dur * 10
		rotateCha()
	func _connect():
		sys.main.connect("tree_exited", self, "gameExit")
	func gameExit():
		exit = true
	func rotateCha():
		# 比较蠢的旋转动画
		target.get_node("ui").visible = false
		target.img.set_pivot_offset(target.img.rect_size / 2)
		for i in range(n):
			yield(sys.get_tree().create_timer(0.1), "timeout")
			if target and !exit and !isDel:
				if i < 10:
					target.normalSpr.position += Vector2(0, -15)
				elif i > n - 13:
					target.normalSpr.position += Vector2(0, 15)
				target.img.set_rotation_degrees(45 * i)
			else:
				return
	func _del():
		target.get_node("ui").visible = true
		target.normalSpr.position = Vector2(0, 0)
		target.img.set_rotation_degrees(0)
	func _upS():
		if life < 1:
			target.get_node("ui").visible = true

# 关闭自动攻击 有上限
class b_StaticTime extends BaseBuff:
	func _init(config):
		_set_config("b_StaticTime", config)
	func _connect():
		masCha.aiOn = false
	func _del():
		if !masCha.hasBuff("b_StaticTimeUnlock"):
			masCha.aiOn = true
	func _upS():
		life = clamp(life, 0, 2)

# 关闭自动攻击 无上限
class b_StaticTimeUnlock extends BaseBuff:
	func _init(config):
		_set_config("b_StaticTimeUnlock", config)
	func _connect():
		masCha.aiOn = false
	func _del():
		masCha.aiOn = true
	func _upS():
		masCha.aiOn = false

# 冻结CD
class b_FrozenCdSkill	extends BaseBuff:
	func _init(config):
		_set_config("b_FrozenCdSkill", config)
		att.cd = -config.cha.att.cd - 1
