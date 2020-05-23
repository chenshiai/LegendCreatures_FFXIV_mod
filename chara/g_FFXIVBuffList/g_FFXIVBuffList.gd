func _init():
  pass

func _connect():
  pass

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
    if life <= 1: life = 0

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
    if life <= 1: life = 0

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
    if life <= 1: life = 0

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
    if life <= 1: life = 0

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
    if life <= 1: life = 0

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
    if life <= 1: life = 0

# 吉星
class b_LuckyStar:
  extends Buff
  var hot setget set_hot, get_hot

  func get_hot():
    return hot
  func set_hot(val):
    hot = val

  func _init(dur = 1, val = 0):
    attInit()
    id = "b_LuckyStar"
    isNegetive = false
    hot = val
    life = dur

  func _upS():
    masCha.plusHp(hot)
    life = clamp(life, 0, 5)
    if life <= 1: life = 0

# 黑夜领域，护盾。可以吸收一定数值的伤害
class b_Night:
	extends Buff
	var total setget set_total, get_total

	func get_total():
		return total
	func set_total(val):
		total = val

	func _init(dur = 1, val = 0):
		attInit()
		id = "b_Night"
		total = val
		isNegetive = false
		life = dur

	func _connect():
		._connect()
		masCha.connect("onHurt", self, "onHurt")

	func _upS():
		life = clamp(life, 0, 5)
		if life <= 1: life = 0

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