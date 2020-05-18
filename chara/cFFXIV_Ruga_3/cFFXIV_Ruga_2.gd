extends Chara
#覆盖的初始化
func _info():
	pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
	._extInit()#保留继承的处理
	chaName = "武僧"
	attCoe.atkRan = 1
	attCoe.maxHp = 3
	attCoe.atk = 4
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 3
	attAdd.spd += 0.30
	attAdd.atkL += 0.15
	lv = 2
	evos = []
	addCdSkill("skill_FightGas", 7)#添加cd技能
	addSkillTxt("""[红莲体式]：被动，增加15%的攻击力
	[斗气]：被动，每次攻击有20%概率获得一层斗气，最大五层
	[阴阳斗气斩]：复唱时间7s，对攻击目标造成物理伤害，根据当前斗气层数提高伤害。威力：210，每层斗气提高10点威力""")

#进入战斗初始化，事件连接在这里初始化
var fightGas = 0
func _connect():
	._connect() #保留继承的处理

func _onBattleStart():
	._onBattleStart()
	fightGas = 0

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if sys.rndPer(20) && fightGas < 5:
		fightGas += 1

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_FightGas" && aiCha != null:
		hurtChara(aiCha, att.atk * (2.10 + 0.10 * fightGas), Chara.HurtType.PHY)
		fightGas = 0