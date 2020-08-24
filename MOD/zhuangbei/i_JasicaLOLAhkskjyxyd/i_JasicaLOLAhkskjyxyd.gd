extends Item
func init():
	name = "海克斯科技原型腰带"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 300
	att.mgiAtk = 60
	att.mgiSuck = 0.2
	att.cd = 0.1
	info = "闪烁到敌人最后一排并对每个前排敌人造成150+25%*法强的魔法伤害"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")
	sys.main.connect("onBattleEnd",self,"run1")
	#bl = true

var bl = true
func run1():
	bl = true
func run(atkInfo):
	if bl:
		bl = false
		var mv = Vector2(masCha.cell.x ,masCha.cell.y)
		if masCha.team == 1:mv.x = 7
		else:mv.x = 0
		var vs = [Vector2(0,0),Vector2(1,0),Vector2(-1,0),Vector2(0,1),Vector2(0,-1),Vector2(1,1),Vector2(-1,1),Vector2(-1,-1),Vector2(1,-1)]
		var dk1 = [Vector2(4,0)]
		var dk2
		for i in range(5):
			var cha = masCha.matCha(Vector2(4,i))
			if cha !=null:
				#print("海克斯科技原型腰带:%s" % cha)
				masCha.hurtChara(cha,150+masCha.att.mgiAtk*0.25,Chara.HurtType.MGI,Chara.AtkType.EFF )
			#masCha.hurtChara(atkInfo.hitCha,masCha.att.mgiPen*2,Chara.HurtType.REAL,Chara.AtkType.EFF )

		for i in vs:
			var v = mv+i
			if masCha.matCha(v) == null && sys.main.isMatin(v):
				if masCha.setCell(v) :
					var pos = sys.main.map.map_to_world(masCha.cell)
					#ying(pos)
					masCha.position = pos
					masCha.aiCha = null
					break
		#if atkInfo.atkType == Chara.AtkType.SKILL:
		#	masCha.hurtChara(atkInfo.hitCha,masCha.att.mgiPen*2,Chara.HurtType.REAL,Chara.AtkType.EFF )
func ying(pos):
	var l:Vector2 = pos - masCha.position
	var s = 25
	var rs = preload("res://core/ying.tscn")
	var n = l.length()/s
	for i in range(n):
		var spr = rs.instance()
		sys.main.map.add_child(spr)
		spr.texture = masCha.img.texture_normal
		spr.position = masCha.position + s * (i+1) * l.normalized() - Vector2(masCha.img.texture_normal.get_width()/2,masCha.img.texture_normal.get_height())
		spr.init(255/n * i + 100)