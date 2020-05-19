extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "机工士"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	lv = 2
	evos = []
	atkEff = "atk_dang"
	addCdSkill("skill_Autoturret", 3)
	addCdSkill("skill_Wildfire", 14)
	addSkillTxt("""[车式浮空炮塔]：复唱时间3s，机工士自带的浮空炮塔进行援护射击，与机工士同时攻击同一个目标，威力：80
[超载]：被动，浮空炮攻击5次以后进入超载状态，同时机工士攻击力提升20%，持续8s。结束后进入冷却阶段，降低10%的攻击力，持续5s
[野火]：复唱时间14s，对攻击目标附加野火状态，持续5s，时间结束后爆炸造成物理伤害，机工士的每次普通攻击都会使野火威力提升150""")

#进入战斗初始化，事件连接在这里初始化
func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_Autoturret": autoturret()
	if id == "skill_Wildfire": wildfire()