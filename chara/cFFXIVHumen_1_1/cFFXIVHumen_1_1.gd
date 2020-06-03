extends "../cFFXIVHumen_1/cFFXIVHumen_1.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "纯爱之斧"
	lv = 3
	evos = []
	addCdSkill("skill_FellCleave", 4)
	addCdSkill("skill_InnerRelease", 16)
	addSkillTxt("[裂石飞环]：ÇÐ4s，下一次普通攻击对目标造成[390%]的物理伤害")
	addSkillTxt("[原初的解放]：ÇÐ16s，获得100%的暴击率提升，持续8s")

const FELLCLEAVE_PW = 3.90 # 裂石飞环威力
var fc = false # 是否准备就绪	

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	fc = false

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_FellCleave":
		fc = true

	if id == "skill_InnerRelease":
		addBuff(BUFF_LIST.b_InnerRelease.new(8))
		var eff = newEff("numHit", Vector2(-30, -60))
		eff.setText("原初的解放！", "#ff0000")

func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == Chara.AtkType.NORMAL && fc:
		var sk = getSkill("skill_FellCleave")
		if sk != null: sk.nowTime = 0
		fc = false
		atkInfo.isCri = true
		atkInfo.isAtk = false
		atkInfo.hurtVal *= FELLCLEAVE_PW