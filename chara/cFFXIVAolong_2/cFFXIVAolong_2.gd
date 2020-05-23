extends Chara

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "武士"
	attCoe.atkRan = 1
	attCoe.maxHp = 3.3
	attCoe.atk = 4.2
	attCoe.mgiAtk = 2
	attCoe.def = 3
	attCoe.mgiDef = 2.8
	attAdd.atkR += 0.10
	attAdd.spd += 0.10
	lv = 2
	evos = ["cFFXIVAolong_2_1"]
	atkEff = "atk_dao"
	addSkillTxt("""[雪/月/花]：被动，每次攻击随机获得[雪][月][花]印记，攻击伤害增加10%，攻击力提升10%，攻速提升10%""")
	addSkillTxt("""[居合术]：每第8次攻击，发动一次[纷乱雪月花]
[纷乱雪月花]：对目标造成[120%][350%][720%]的物理伤害，印记种类越多伤害越高，可暴击""")

const HIGANBANE_PW = 1.20 # 一个印记威力
const FIVESWORD_PW = 3.50 # 两个印记威力
const SETSUGEKKA_PW = 7.20 # 三个印记纷乱雪月花威力

var snow = false # 雪
var moon = false # 月
var flower = false # 花
var atkCount = 0 # 当前攻击次数
var flash = 0 # 当前闪的数量
var beforIaijutsu = 0 # 上一次雪月花的威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	reset()

func _onAtkChara(atkInfo:AtkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == AtkType.NORMAL: 
		atkCount += 1
		if atkCount == 8:
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

func _castCdSkill(id):
	._castCdSkill(id)
		
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
	var pw = 1
	if sys.rndPer(att.cri * 100): pw = 2 + att.criR

	var eff = sys.newEff("animEff", position)
	var v2 = Vector2(0,-40)
	eff.normalSpr.position = v2
	eff.sprLookAt(aiCha.global_position)
	eff.setImgs(direc + "/effxueyuehua", 15, false)

	if aiCha != null:
		hurtChara(aiCha, att.atk * skill_pw * pw, Chara.HurtType.PHY, Chara.AtkType.SKILL)

# 重置所有状态
func reset():
	snow = false
	moon = false
	flower = false
	atkCount = 0
	flash = 0