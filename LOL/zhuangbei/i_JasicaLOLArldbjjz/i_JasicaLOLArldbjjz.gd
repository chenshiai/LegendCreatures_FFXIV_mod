extends Item
func init():
	name = "瑞莱的冰晶节杖"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 120
	att.maxHp = 300
	att.cd = 0.1
	info = "每次攻击赋予目标5层[结霜]"
	info += "\n技能命中对敌人造成[结霜]*魔法攻击3%的魔法伤害"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")
var t = 0;
func _upS():
	t += 1+1*masCha.att.cd
	#print(t)
var bl = false
var n = 0
func run(atkInfo:AtkInfo):
	if atkInfo.atkType == Chara.AtkType.SKILL or atkInfo.atkType == Chara.AtkType.NORMAL:
		atkInfo.hitCha.addBuff(b_jieShuang.new(5))
	if atkInfo.atkType == Chara.AtkType.SKILL:
		masCha.hurtChara(atkInfo.hitCha,masCha.att.mgiAtk*0.03*atkInfo.hitCha.hasBuff("b_jieShuang").life,Chara.HurtType.MGI,Chara.AtkType.EFF )
