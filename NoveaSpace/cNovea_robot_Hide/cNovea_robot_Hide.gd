extends "../Base/BaseChara.gd"


func _extInit():
	._extInit()
	id = "cNovea_robot_Hide"
	chaName = "伊娃机器人"
	attCoe.atkRan = 3
	attCoe.maxHp = 2
	attCoe.atk = 10
	attAdd.spd = 2
	lv = 4
	addSkillTxt(TEXT.format("""
{c_las}[镭射]{/c}
{c_bul}[实弹]{/c}
{c_dark}[暗物质]{/c}
{c_light}[光线]{/c}
{c_ele}[电能]{/c}
{c_vib}{s}[振动]{/c}{/s}
"""))

func _init():
	pass


func _onHurt(atkInfo):
	._onHurt(atkInfo)
	atkInfo.hurtVal = 0

func _onDeath(atkInfo):
	._onDeath(atkInfo)
	isDeath = false
	plusHp(att.maxHp * 1)
