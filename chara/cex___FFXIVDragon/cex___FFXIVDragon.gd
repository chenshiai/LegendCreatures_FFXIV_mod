extends "./BossChara.gd"
const BERSERKERTIME = 300 # 狂暴时间



var SKILL_TXT = TEXT.format("""{c_base}
第一阶段：
[大地之怒]：开战时使用且只使用一次。神龙的威严不可触犯，对所有敌人造成[未知]的魔法伤害。
[死亡轮回]：{TDeath}对当前仇恨目标连续造成四次[未知]的范围魔法伤害，可多人分摊伤害。
[吹雪]：对所有敌人造成[未知]的魔法伤害，会在场地上留下水坑，水坑中的角色会获得[雷耐性下降·大][火耐性上升·大]。
[闪电]：对所有敌人释放闪电，造成[未知]的小范围雷属性魔法伤害。
[超新星]：对所有敌人释放火炎攻击，造成[未知]的火属性魔法伤害。
[召唤冰柱]：场地随机一边出现两根冰柱，对直线上的敌人造成[未知]的魔法伤害，并附加[易伤]。

第二阶段：
[召唤小龙]：在场地上召唤4只小龙，1只大龙。
[原恒星]：对所有敌人造成[未知]的魔法伤害，场上每有一只小龙存活，该技能伤害提升20%。

第三阶段：
[万亿斩击]：{TDeath}对当前仇恨目标造成[未知]的物理伤害，并附加[物理耐性下降·大]
{/c}""")

func _extInit():
	._extInit()
	chaName = "神龙"
	lv = 4
	addSkillTxt(SKILL_TXT)
	addSkillTxt("""[原恒星]：""")
	addSkillTxt(TEXT.BOSS_OMEGA)

var mustardBomb_pw = 4 # 死刑威力
var atomicRay_pw = 0.75 # 原子射线威力
var triangleAttack_pw = 22 # 三角攻击威力

func _init():
	var SkillAxis = {
		"atomicRay": [2, 20, 40, 60, 110]
	}
	call_deferred("setTimeAxis", SkillAxis)

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	aiOn = false
	normalSpr.position = Vector2(0, -50)
	sprcPos = Vector2(-50, -30)
	for cha in sys.main.btChas:
		if cha.team == 1:
			cha.addBuff(b_longAtk.new())
	
func _onBattleEnd():
	._onBattleEnd()
	skillStrs[1] = SKILL_TXT
	atomicRay_pw = 0.75
	mustardBomb_pw = 4

func _onAddBuff(buff:Buff):
	if buff.id == "b_liuXue" :
			buff.isDel = true

# 技能-原子射线
func atomicRay():
	Utils.draw_effect("lightBlue", Vector2(position.x, position.y - 1), Vector2(0, -10), 15, 10)
	var chas = getAllChas(1)
	for i in chas:
		if i != null:
			hurtChara(i, att.mgiAtk * atomicRay_pw, Chara.HurtType.MGI, Chara.AtkType.SKILL)

func _upS():
	._upS()
	aiCha = null
	if battleDuration > BERSERKERTIME and (battleDuration % 5 == 0):
		atomicRay()
		atomicRay_pw += 0.6

class b_longAtk:
	extends Buff
	func _init():
		attInit()
		id = "b_longAtk"
		att.atkRan = 1