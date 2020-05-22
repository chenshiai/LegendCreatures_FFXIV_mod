extends "../cFFXIVSpirit_3/cFFXIVSpirit_3.gd"
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "红血之龙"
	lv = 3
	evos = []
	attAdd.atkR += 0.15
	addCdSkill("skill_Stardiver", 25)
	addSkillTxt("[红莲龙血]：被动，获得15%的攻击力加成")
	addSkillTxt("[坠星冲]：冷却时间25s，高高跃起，向地面猛冲，对周围1格的敌人造成[600%]的物理伤害，并附加10层[烧灼]")

func _connect():
	._connect() #保留继承的处理

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Stardiver": stardiver()

func stardiver():
	_process(self.cell)
	var eff:Eff = newEff("sk_yunShi")
	eff.position = aiCha.position
	eff.scale *= 2
	yield(reTimer(0.5), "timeout")

# 垂直上升
func _process(delta):
	normalSpr.position += delta * Vector2(0, -300)
