extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

const HIGANBANE_PW = 1.50 # 一个印记威力
const FIVESWORD_PW = 3.50 # 两个印记威力
const SETSUGEKKA_PW = 7.20 # 三个印记纷乱雪月花威力

var snow = false # 雪
var moon = false # 月
var flower = false # 花
var atkCount = 0 # 当前攻击次数
var flash = 0 # 当前闪的数量
var beforIaijutsu = 0 # 上一次雪月花的威力

var SKILL_TXT_1 = TEXT.format("""[居合术]：每第6次攻击，发动一次[纷乱雪月花]
[纷乱雪月花]：对目标造成[150%][350%][720%]的{TPhyHurt}，印记种类越多伤害越高，可暴击！""")

func _extInit():
	._extInit()
	OCCUPATION = "MeleeDPS"
	chaName = "武士"
	attCoe.atkRan = 1
	attCoe.maxHp = 4
	attCoe.atk = 4.2
	attCoe.def = 3
	attCoe.mgiDef = 2.8
	attAdd.atkL += 0.10
	attAdd.spd += 0.10
	lv = 2
	evos = ["cFFXIVAolong_2_1"]
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format("[雪/月/花]：『{TPassive}』每2次攻击随机获得[雪][月][花]印记，攻击力提升10%，攻速提升10%"))
	addSkillTxt(SKILL_TXT_1)

func _connect():
	._connect()

func _onBattleEnd():
	._onBattleEnd()
	reset()

func normalAtkChara(cha):
	.normalAtkChara(cha)
	atkCount += 1
	if atkCount == 6:
		atkCount = 0
		iaijutsu()
	elif atkCount % 2 == 0:
		var n = sys.rndRan(0, 2)
		if n == 0 :
			getFlash("snow")
		elif n == 1:
			getFlash("moon")
		else:
			getFlash("flower")

func _castCdSkill(id):
	._castCdSkill(id)
		
func _onAtkInfo(atkInfo: AtkInfo):
	._onAtkInfo(atkInfo)
	if atkInfo.atkCha == self and atkInfo.atkType == Chara.AtkType.SKILL:
		atkInfo.canCri = true

func iaijutsu():
	if flash == 1:
		setsugekka(HIGANBANE_PW)
		beforIaijutsu = HIGANBANE_PW
	elif flash == 2:
		setsugekka(FIVESWORD_PW)
		beforIaijutsu = FIVESWORD_PW
	elif flash == 3:
		setsugekka(SETSUGEKKA_PW)
		beforIaijutsu = SETSUGEKKA_PW
	reset()

# 获得对应的印记
func getFlash(name):
	match name:
		"snow":
			if !snow :
				snow = true
				flash += 1
		"moon":
			if !moon :
				moon = true
				flash += 1
		"flower":
			if !flower :
				flower = true
				flash += 1

# 纷乱雪月花
func setsugekka(skill_pw):
	Utils.createShadow(img, position, aiCha.position)
	normalSpr.position = Vector2(0, -600)
	yield(reTimer(0.3), "timeout")
	Utils.createEffect("slash2", aiCha.position, Vector2(0,-30), 10, 1.3)
	FFHurtChara(aiCha, att.atk * skill_pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)
	normalSpr.position = Vector2(0, 0)

# 重置所有状态
func reset():
	snow = false
	moon = false
	flower = false
	atkCount = 0
	flash = 0
	normalSpr.position = Vector2(0, 0)
