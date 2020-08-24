extends Item
func init():
	name = "卢登的回声"
	type = config.EQUITYPE_EQUI
	attInit()
	att.mgiAtk = 100
	att.cd = 0.1
	info = "每次攻击减少技能剩余CD的1%"
	info += "\n技能命中对敌人周围1格最多2个敌人单位造成100+5%魔法攻击的魔法伤害(5秒CD)"
	
func _connect():
	masCha.connect("onCastCdSkill",self,"run1")
	masCha.connect("onAtkChara",self,"run")

var t = 0;
func _upS():
	t += 1+1*masCha.att.cd
	#print(t)
var bl = false
var n = 0
func run(atkInfo:AtkInfo):
	for i in masCha.skills:
		i.nowTime+=i.nowTime*0.01
	if bl && atkInfo.atkType == Chara.AtkType.NORMAL:
		#print(atkInfo.hitCha.cell)
		for arr in masCha.getCellChas(atkInfo.hitCha.cell,1,1):
			#print(arr)
			if n < 2:
				masCha.hurtChara(arr,masCha.att.mgiAtk*0.05+100,Chara.HurtType.MGI,Chara.AtkType.EFF )
			n += 1
			bl = false
		n = 0
func run1(id):
	if t >= 5:
		bl = true
		t = 0