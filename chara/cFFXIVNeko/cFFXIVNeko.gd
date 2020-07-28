extends "../BaseChara/FFXIVBaseChara.gd"


func _extInit():
	._extInit()
	chaName = "猫魅冒险者"
	evos = ["cFFXIVNeko_1", "cFFXIVNeko_2", "cFFXIVNeko_3"]
	atkEff = "atk_dao"
	addCdSkill("5",5)
	addSkillTxt("[光之加护]：每5秒，获得5层[狂怒][抵御]")
	addSkillTxt(TEXT.format("""[进化分支]
[{TTreatment}]学者
[{TAttack}]召唤师
[{TAttack}]吟游诗人"""))


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "5":
		addBuff(b_diYu.new(5))
		addBuff(b_kuangNu.new(5))