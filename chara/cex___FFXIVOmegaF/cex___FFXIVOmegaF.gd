extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

# var layer
# layer = sys.main.guankaMsg.lvStep - 2

var allAtt

func _extInit():
	._extInit()
	chaName = "欧米茄F"
	attCoe.atkRan = 1
	attCoe.maxHp = 1
	attCoe.atk = 1
	attCoe.mgiAtk = 1
	attCoe.def = 1
	attCoe.mgiDef = 1
	lv = 4
	evos = []
	atkEff = "atk_dao"
	addSkillTxt("""[阿尔法程序]：该单位属性根据敌方战力自适应调整，拥有特定的技能时间轴
[防火墙]：该单位免疫[烧灼]""")
	addSkillTxt("""[太阳射线]：死刑，对当前攻击目标造成[1600%]法强的小范围魔法伤害
[激光雨]：对全屏的敌人造成[300%]法强的魔法伤害
[优化爆炎]：对所有敌人造成一次[400%]法强的小范围魔法伤害""")
	addSkillTxt("[宇宙之光]：战斗时间超过 120s 后，进入狂暴")

const SOLARRAYS_PW = 16 # 死刑威力
const LASERRAIN_PW = 3 # 激光雨威力
const OPTIMIZEDFIREIII_PW = 4 # 爆炎威力
const BERSERKERTIME = 120 # 狂暴时间
const SKILLS = {
	"solarRays": [25, 55, 85, 115],
	"laserRain": [5, 20, 40, 60, 90, 110],
	"optimizedFireIII": [80]
}
var timeAxis = Utils.createTimeAxis(SKILLS) # 创建技能时间轴
var t = 0 # 战斗时间

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	t = 0
	allAtt = Utils.Calculation.getEnemyPower(self.time)
	var chas = getAllChas(1)
	attInfo.maxHp = (allAtt["atk"] + allAtt["mgiAtk"]) * 20
	attInfo.atk = (allAtt["def"] + allAtt["maxHp"] / 8) / chas.size()
	attInfo.mgiAtk = (allAtt["mgiDef"] + allAtt["maxHp"] / 8) / chas.size()
	attInfo.def = allAtt["atk"] / chas.size()
	attInfo.mgiDef = allAtt["mgiAtk"] / chas.size()
	upAtt()

func _onAddBuff(buff:Buff):
	if buff.id == "b_shaoZhuo" :
			buff.isDel = true

func solarRays():
	var chas = getCellChas(aiCha.cell, 1)
	Utils.createEffect("blastYellow", aiCha.position, Vector2(0, -50), 15)
	for i in chas:
		if i != self:
			hurtChara(i, att.mgiAtk * SOLARRAYS_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)

func laserRain():
	Utils.createEffect("lightBlue", Vector2(position.x, position.y - 1), Vector2(0, -10), 15, 10)
	var chas = getAllChas(1)
	for i in chas:
		if i != null:
			hurtChara(i, att.mgiAtk * LASERRAIN_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)
			
func optimizedFireIII():
	var chas = getAllChas(1)
	for i in chas:
		Utils.createEffect("light", i.position, Vector2(0, -50), 15)
		var cha = getCellChas(i.cell, 1)
		for j in cha:
			if j != self:
				hurtChara(j, att.mgiAtk * OPTIMIZEDFIREIII_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)

func _upS():
	t += 1
	if timeAxis.has(t):
		call_deferred(timeAxis[t])
	if t > BERSERKERTIME:
		laserRain()