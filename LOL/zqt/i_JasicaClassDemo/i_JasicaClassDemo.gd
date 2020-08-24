extends "class_hudun.gd"

func init():
	.init()
	name = "测试装备振奋铠甲"

	att.maxHp = 550
	att.mgiDef = 65
	att.cd = 0.1
	att.defR = 0.15
	info = "受到技能攻击时回复最大生命的1%"
	#effId = "sk_yunShi"

func _connect():
	masCha.connect("onHurtEnd",self,"run")
func run(atkInfo):
	masCha.addBuff(jab_hudun.new(5,false,1000))#给个状态（持续5秒，不是永久，1000护盾）
	masCha.hasBuff("jab_hudun").d = 1000 #设置护盾
	masCha.hasBuff("jab_hudun").life = 10 #设置buff时间
	masCha.hasBuff("jab_hudun").type = true #设置永久buff
	print("测试信息:是否永久:%s" % masCha.hasBuff("jab_hudun").type)
	print("测试信息:剩余时间:%s" % masCha.hasBuff("jab_hudun").life)
	print("测试信息:护盾值:%s" % masCha.hasBuff("jab_hudun").d)
	if atkInfo.atkType == Chara.AtkType.SKILL:
		masCha.plusHp(masCha.att.maxHp*0.01)

