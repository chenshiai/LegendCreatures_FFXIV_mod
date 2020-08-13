extends "../cFFXIVHumen_1/cFFXIVHumen_1.gd"

const FELLCLEAVE_PW = 3.50 # 裂石飞环威力
var fc = false # 是否准备就绪

func _extInit():
	._extInit()
	chaName = FFData.name_2
	lv = 3
	evos = []
	addCdSkill("skill_FellCleave", 4)
	addCdSkill("skill_InnerRelease", 16)
	addSkillTxt(TEXT.format(FFData.SKILL_TEXT_1))


func _onBattleStart():
	._onBattleStart()
	fc = false


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_FellCleave":
		fc = true

	if id == "skill_InnerRelease":
		BUFF_LIST.b_InnerRelease.new({"cha": self, "dur": 8})


func _onAtkChara(atkInfo):
	._onAtkChara(atkInfo)
	if atkInfo.atkType == NORMAL and fc:
		var sk = getSkill("skill_FellCleave")
		if sk != null: sk.nowTime = 0
		fc = false
		atkInfo.isCri = true
		atkInfo.isAtk = false
		atkInfo.hurtVal *= FELLCLEAVE_PW