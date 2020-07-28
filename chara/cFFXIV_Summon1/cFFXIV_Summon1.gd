extends "../BaseChara/FFXIVSummon.gd"

func _info():
	pass
func _extInit():
	._extInit()#保留继承的处理
	chaName = "伊弗利特之灵"
	isDeath = true
	addSkillTxt("火神之灵，与召唤师攻击同一目标，根据召唤师等级解锁技能")
	addSkillTxt(TEXT.format("""lv2·[燃火强袭]：冷却4s，对目标造成召唤师[30%]法强的物理伤害
lv3·[烈焰碎击]：冷却10s，对目标周围一格的敌人造成召唤师[50%]法强的魔法伤害
lv4·[地狱之火炎]：冷却24s，对目标周围一格的敌人造成召唤师[150%]法强的魔法伤害，并附加10层[烧灼]"""))

const Crimson_pw = 0.30
const Flaming_pw = 0.50
const Inferno_pw = 1.50

func _connect():
	._connect() 

func skill_lv1():
	if !Summoner.aiCha or Summoner.isDeath:
		return
	normalSpr.position += Vector2(10, -10)
	Summoner.FFHurtChara(Summoner.aiCha, Summoner.att.mgiAtk * Crimson_pw, PHY, SKILL)
	yield(reTimer(0.1), "timeout")
	normalSpr.position -= Vector2(10, -10)

func skill_lv2():
	if !Summoner.aiCha or Summoner.isDeath:
		return
	var cell = Summoner.aiCha.cell
	var chas = getCellChas(cell, 1)
	Utils.draw_efftext("烈焰碎击", Summoner.position, "#ff5858")
	for i in chas:
		if i != null:
			Summoner.FFHurtChara(i, Summoner.att.mgiAtk * Flaming_pw, MGI, SKILL)

func skill_lv3():
	if !Summoner.aiCha or Summoner.isDeath:
		return
	var cell = Summoner.aiCha.cell
	var chas = getCellChas(cell, 1)
	Utils.draw_efftext("地狱之火炎", Summoner.position, "#ff5858")
	for i in chas:
		if i != null:
			Summoner.FFHurtChara(i, Summoner.att.mgiAtk * Inferno_pw, MGI, SKILL)
			i.addBuff(b_shaoZhuo.new(10))
