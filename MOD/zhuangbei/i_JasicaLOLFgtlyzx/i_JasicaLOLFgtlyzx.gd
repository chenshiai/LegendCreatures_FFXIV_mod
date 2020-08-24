extends Item
func init():
	name = "钢铁烈阳之匣"
	type = config.EQUITYPE_EQUI
	attInit()
	att.def = 30
	att.mgiDef = 60
	info = "绝对唯一·血盾:战斗开始时为2格队友添加一个120+25%最大生命的护盾持续5秒(血量最高的)"
	#effId = "sk_yunShi"
	
func _connect():
	sys.main.connect("onBattleStart",self,"run")
var jaVal = globalData.infoDs["g_JasicaTool_val"].jaToolVal
#print(globalData)
# jaVal.set("i_JasicaLOLFgtlyzx_n",{1:0,2:0})#触发了几次
# jaVal.set("i_JasicaLOLFgtlyzx_hp",{1:0,2:0})#最大生命
# jaVal.set("i_JasicaLOLFgtlyzx_cell",{1:Vector2(0,0),2:Vector2(0,0)})#触发位置
func _upS():
	var n = jaVal.get("i_JasicaLOLFgtlyzx_n")
	var hp = jaVal.get("i_JasicaLOLFgtlyzx_hp")
	var cell = jaVal.get("i_JasicaLOLFgtlyzx_cell")
	# var team = masCha.get_team()
	if n[masCha.get_team()] == 0:
		#print("钢铁烈阳之匣:效果触发了")
		var a = hp[team]
		var team = masCha.get_team()
		print("钢铁烈阳之匣: %s" % a)
		for arr in masCha.getCellChas(cell[team],1,2):
			arr.addBuff(w_xuedun.new(10))
			arr.hasBuff("w_xuedun").d = (120 + hp[team] * 0.25) as int
			#print(arr.addBuff(w_xuedun))
		n[masCha.get_team()] = 1
		jaVal.set("i_JasicaLOLFgtlyzx_n",n)#触发了几次
var team
func run():
	jaVal.set("i_JasicaLOLFgtlyzx_n",{1:0,2:0})#触发了几次
	jaVal.set("i_JasicaLOLFgtlyzx_hp",{1:0,2:0})#最大生命
	jaVal.set("i_JasicaLOLFgtlyzx_cell",{1:Vector2(0,0),2:Vector2(0,0)})#触发位置
	team = masCha.get_team()
	var hp = jaVal.get("i_JasicaLOLFgtlyzx_hp")
	var cell = jaVal.get("i_JasicaLOLFgtlyzx_cell")
	if masCha.att.maxHp > hp[team]:
		#print(masCha.att.maxHp)
		hp[team] = masCha.att.maxHp
		cell[team] = masCha.cell
		jaVal.set("i_JasicaLOLFgtlyzx_hp",hp)#最大生命
		jaVal.set("i_JasicaLOLFgtlyzx_cell",cell)#触发位置
	

	

class w_xuedun extends Buff:
	var d setget set_d, get_d
	func set_d(val):
		d = val
	func get_d():
		return d
	func _init(lv = 1):
		attInit()
		d = 0
		effId = "p_diYu"
		life = lv
		id = "w_xuedun"
		#isNegetive=true
	func init():
		pass
	func _connect():
		masCha.connect("onHurt",self,"onHurt")#护盾免伤计算
	func _upS():
		eff.amount = clamp(life,1,10)
	func onHurt(atkInfo:AtkInfo):
		#print("钢铁烈阳之匣:%s" % d)
		#print(hd)
		if d > 0:
			atkInfo.hurtVal = 0
			d -= atkInfo.atkVal
			if d < 0:
				d = 0