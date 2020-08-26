class BaseBuff extends Buff:
	const MGI = Chara.HurtType.MGI
	const PHY = Chara.HurtType.PHY
	const REAL = Chara.HurtType.REAL
	const NORMAL = Chara.AtkType.NORMAL
	const SKILL = Chara.AtkType.SKILL
	const EFF = Chara.AtkType.EFF
	const MISS = Chara.AtkType.MISS
	var Utils = globalData.infoDs["g_LOLUtils"]
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
	func _conflict(buffId):
		var bf = target.hasBuff(buffId)
		if bf != null and bf != self:
			bf.isDel = true
	func _get(config, name, default = null):
		if config.has(name):
			return config[name]
		else:
			return default

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

# 兰德里的折磨 冰霜
class b_bingshuang extends BaseBuff:
	func _init(config):
		_set_config("b_bingshuang", config, true)
		att.penL = -0.1
		att.defL = -0.1
	func _upS():
		att.spd = -(0.10 + life * 0.01)
		life = clamp(life, 0, 15)

# 重伤
class b_zhongshang extends BaseBuff:
	func _init(config):
		_set_config("b_zhongshang", config, true)
		att.reHp = -0.4
	func _upS():
		life = clamp(life, 0, 3)

# 灭世者的魔法帽
class b_mieshizhe extends BaseBuff:
	func _init(config):
		_set_config("b_mieshizhe", config)
		_conflict("b_mieshizhe")
		att.mgiAtkL = 0.4

# 中亚沙漏 凝滞
class b_ningzhi extends BaseBuff:
	func _init(config):
		_set_config("b_ningzhi", config)
	func _connect():
		masCha.connect("onHurt", self, "run")
	func _upS():
		life = clamp(life, 0, 3)
	func run(atkInfo):
		atkInfo.hurtVal = 0


# 鬼索的狂暴之刃
class b_kuangbao extends BaseBuff:
	var atkNum = 0
	var buffLevel = 1
	func _init(config):
		_set_config("b_kuangbao", config)
		_update()
		_conflict("b_kuangbao")

	func _connect():
		masCha.connect("onAtkChara", self, "run")
	func _update():
		var bf = target.hasBuff(self.id)
		if bf != null and bf != self:
			self.buffLevel += bf.buffLevel
			if self.buffLevel > 6:
				self.buffLevel = 6
	func _upS():
		att.spd = 0.08 * buffLevel
		life = clamp(life, 0, 5)
	func run(atkInfo):
		if atkInfo.atkType == Chara.AtkType.NORMAL and buffLevel == 6:
			atkNum += 1
			if atkNum >= 3:
				atkNum = 0
				masCha.hurtChara(atkInfo.hitCha,50,Chara.HurtType.REAL,Chara.AtkType.EFF)


# 黑色切割者
class b_qiegezhe extends BaseBuff:
	var buffLevel = 1
	func _init(config):
		_set_config("b_qiegezhe", config)
		_update()
	func _update():
		var bf = target.hasBuff(self.id)
		if bf != null and bf != self:
			bf.buffLevel += 1
			if bf.buffLevel > 6:
				bf.buffLevel = 6
	func _upS():
		att.defL = -0.04 * buffLevel
		print(self, " 当前层数：", buffLevel)
		life = clamp(life, 0, 6)

# 挑战护手
class b_tiaozhanhushou extends BassShield:
	func _init(config):
		_set_config("b_tiaozhanhushou", config)
		self.shieldValue = _get(config, "HD", 0)
	func _upS():
		life = clamp(life, 0, 5)
		self.shieldValue -= self.shieldValue * 0.25

# 钢铁烈阳之匣
class b_xuedun extends BassShield:
	func _init(config):
		_set_config("b_xuedun", config)
		self.shieldValue = _get(config, "HD", 0)
	func _upS():
		life = clamp(life, 0, 5)

# 救赎 唯一buff
class b_jiushu extends BaseBuff:
	var	t = 0
	func _init(config):
		_set_config("b_jiushu", config)
		_conflict("b_jiushu")
	func _upS():
		t += 1
		if t >= 5:
			for cha in masCha.getAllChas(2):
				cha.plusHp(10+masCha.lv*20, false)
			for cha in masCha.getAllChas(1):
				masCha.hurtChara(cha,masCha.att.maxHp*0.02, REAL, EFF)
			t = 0

# 寒铁
class b_hantie extends BaseBuff:
	func _init(config):
		_set_config("b_hantie", config)
		_conflict("b_hantie")
		att.spd = -0.20
	func _upS():
		life = clamp(life, 0, 2)