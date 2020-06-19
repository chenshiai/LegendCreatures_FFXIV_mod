extends "../cFFXIVSpirit_2/cFFXIVSpirit_2.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "东天之星-夜"
	lv = 3
	evos = []
	addSkillTxt(TEXT.format("""[小奥秘卡]：『{TPassive}』每次使用[抽卡]后，随机释放以下效果
[王冠之领主]：对当前目标造成[100%]法强的{TMgiHurt}
[王冠之贵妇]：为生命值最低的友方单位恢复[100%]法强的HP"""))

const LORDOFCROWNS_PW = 1
const LADYOFCROWNS_PW = 1

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DrawCard":
		yield(reTimer(0.5), "timeout")
		if sys.rndPer(50):
			var cha = null
			var m = 10000
			var chas = getAllChas(2)
			for i in chas:
				if i.att.hp / i.att.maxHp < m :
					cha = i
					m = i.att.hp / i.att.maxHp
			if cha != null:
				cha.plusHp(att.mgiAtk * LADYOFCROWNS_PW)
		else:
			var d:Eff = newEff("sk_feiDang",sprcPos)
			d._initFlyCha(aiCha)
			yield(d, "onReach")
			FFHurtChara(aiCha, att.mgiAtk * LORDOFCROWNS_PW, Chara.HurtType.MGI, Chara.AtkType.SKILL)
