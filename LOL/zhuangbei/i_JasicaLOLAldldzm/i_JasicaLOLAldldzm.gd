extends Item
func init():
	name = "兰德里的折磨"
	type = config.EQUITYPE_EQUI
	
	attInit()
	att.mgiAtk = 80
	att.maxHp = 300
	att.cd = 0.1
	info = "技能与普攻叠加2层冰霜"
	info += "\n攻击带有15层冰霜的单位时清除15层冰霜并造成对方最大生命2%的真实伤害"
	info += "\n冰霜:减少目标10%物理防御、魔法防御、攻速，每层多减少1%攻速"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")

func run(atkInfo:AtkInfo):
	if atkInfo.atkType != Chara.AtkType.EFF && atkInfo.atkType != Chara.AtkType.MISS:
		atkInfo.hitCha.addBuff(b_bingshuang.new(2))
	var bf = atkInfo.hitCha.hasBuff("b_bingshuang")
	#print(atkInfo.hitCha.hasBuff("b_zhonDu").life)
	#print(atkInfo.atkCha.hasBuff("b_zhonDu").life)
	#print(masCha.att.cd)
	if bf != null && bf.life >= 15 :
		bf.life -= 15
		masCha.hurtChara(atkInfo.hitCha,atkInfo.hitCha.att.maxHp*0.02,Chara.HurtType.REAL,Chara.AtkType.EFF)

class b_bingshuang extends Buff:
	func _init(lv = 1):
		attInit()
		effId = "p_jieShuang"
		life = lv
		id = "b_bingshuang"
		name = "冰霜"
		isNegetive=true
	func init():
		pass
	func _connect():
		pass
	func _upS():
		att.penL = - 0.1
		att.defL = - 0.1
		att.spd = - (0.10 + life * 0.01)
		eff.amount = clamp(life,1,25)
	
