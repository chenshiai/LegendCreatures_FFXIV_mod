extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "舞者"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = []
	atkEff = "atk_dao"
	addCdSkill("skill_DanceStep", 35)#添加cd技能
	addSkillTxt("""[闭式舞姿]：被动，战斗开始时，选择一名物理攻击与一名魔法攻击最高的队友作为舞伴，提高他们与自己的攻击力5%，可以叠加
[标准舞步]：复唱时间35s，对三格内的敌人造成物理伤害，同时舞伴与自己的攻击力再提升10%，持续10s，威力：700""")

const DANCESTEP_PW = 7 # 标准舞步威力
var atkMaxAily = null
var mgiAtkMaxAily = null


#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DanceStep": danceStep()

func danceStep():
	var chas = getCellChas(cell, att.atkRan)
	for i in chas:
		if i != null: 
			hurtChara(i, att.atktk * DANCESTEP_PW, HurtType.PHY)