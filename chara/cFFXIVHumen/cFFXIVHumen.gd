extends "../BaseChara/FFXIVBaseChara.gd"


func _extInit():
	._extInit()
	chaName = "人族冒险者"
	evos = ["cFFXIVHumen_1", "cFFXIVHumen_2", "cFFXIVHumen_3"]
	atkEff = "atk_dao"
	addCdSkill("5",5)
	addSkillTxt("[光之加护]：每5秒，获得5层[狂怒][抵御]")
	addSkillTxt(TEXT.format("""[进化分支]
[{TProtect}]战士
[{TProtect}]绝枪战士
[{TAttack}]舞者"""))


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "5":
		addBuff(b_diYu.new(5))
		addBuff(b_kuangNu.new(5))