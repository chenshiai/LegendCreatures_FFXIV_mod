extends Item
func init():
	name = "卢安娜的飓风"
	type = config.EQUITYPE_EQUI
	attInit()
	att.spd = 0.60
	att.cri = 0.25
	att.atkRan = 2
	info = "每次普通攻击会发射两支弩箭向附近两个目标造成30%物理攻击的物理伤害"
	#effId = "atk_gongJian"
	
func _connect():
	masCha.connect("onAtkChara",self,"run")
var n = 0;
#var eff = sys.newEff("animEff",Vector2(100,100))
func run(atkInfo:AtkInfo):
	
	if atkInfo.atkType == Chara.AtkType.NORMAL:
		n = 0
		for arr in masCha.getCellChas(masCha.cell,masCha.att.atkRan,1):
			if arr != atkInfo.hitCha:
				#eff._initFlyCha(arr,flySpd = 300)
				#var eff:Eff = masCha.newEff("atk_gongJian")
				# var eff = sys.newEff("animEff",masCha.position)
				# eff.setImgs("effImgs",15,false)
				# eff._initFlyCha(arr,300)
				#eff.position = atkInfo.hitCha.position
				#yield(sys.main.get_tree().create_timer(0.45),"timeout")
				n += 1
				if n < 3 : 
					masCha.hurtChara(arr,masCha.att.atk*0.3,Chara.HurtType.PHY,Chara.AtkType.EFF)
					#eff.queue_free()