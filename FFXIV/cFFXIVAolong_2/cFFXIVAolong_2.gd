extends "../BaseChara/FFXIVBaseChara.gd"
var FFData = preload("./charaData.gd").getCharaData()

const HIGANBANE_PW = 2.50 # 一个印记威力
const FIVESWORD_PW = 3.60 # 两个印记威力
const SETSUGEKKA_PW = 8.00 # 三个印记纷乱雪月花威力

var snow = false # 雪
var moon = false # 月
var flower = false # 花
var atkCount = 0 # 当前攻击次数
var flash = 0 # 当前闪的数量
var beforIaijutsu = 0 # 上一次雪月花的威力

signal swordPpressure


func _init():
	logoImgName = "Samurai"
	OCCUPATION = "CloseCombat"


func _extInit():
	._extInit()
	SKILL_CRI = true
	chaName = FFData.name_1
	attCoe.atkRan = 1
	attCoe.maxHp = 4
	attCoe.atk = 4.2
	attCoe.def = 3
	attCoe.mgiDef = 2.8
	attAdd.atkL += 0.10
	attAdd.spd += 0.10
	attAdd.cri -= 0.1
	lv = 2
	evos = ["cFFXIVAolong_2_1"]
	atkEff = "atk_dao"
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT))


func _onBattleEnd():
	._onBattleEnd()
	reset()


func normalAtkChara(cha):
	.normalAtkChara(cha)
	atkCount += 1
	if atkCount == 7:
		atkCount = 0
		iaijutsu()
	else:
		var n = sys.rndRan(0, 2)
		if n == 0 :
			getFlash("snow")
		elif n == 1:
			getFlash("moon")
		else:
			getFlash("flower")


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
	yield(reTimer(0.3), "timeout")
	reset()


# 获得对应的印记
func getFlash(name):
	match name:
		"snow":
			if !snow :
				snow = true
				flash += 1
				Utils.draw_efftext("雪", position, "#55ffc1")
		"moon":
			if !moon :
				moon = true
				flash += 1
				Utils.draw_efftext("月", position, "#5599ff")
		"flower":
			if !flower :
				flower = true
				flash += 1
				Utils.draw_efftext("花", position, "#ff558d")


# 纷乱雪月花
func setsugekka(skill_pw):
	emit_signal("swordPpressure")
	Utils.draw_shadow(img, position, aiCha.position)
	normalSpr.position = (aiCha.position - position) / 3 * self.dire
	yield(reTimer(0.3), "timeout")
	Utils.draw_effect("slash2", aiCha.position, Vector2(0,-30), 10, 1.3)
	FFHurtChara(aiCha, att.atk * skill_pw, PHY, SKILL)
	normalSpr.position = Vector2(0, 0)


# 重置所有状态
func reset():
	snow = false
	moon = false
	flower = false
	atkCount = 0
	flash = 0
	normalSpr.position = Vector2(0, 0)
