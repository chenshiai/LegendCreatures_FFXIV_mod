extends "../BaseChara/FFXIVBaseChara.gd"


func _extInit():
	._extInit()
	chaName = "鲁加冒险者"
	evos = ["cFFXIVRuga_1", "cFFXIVRuga_2", "cFFXIVRuga_3"]
	atkEff = "atk_dao"
	addCdSkill("5",5)
	addSkillTxt("[光之加护]：每5秒，获得5层[狂怒][抵御]")
	addSkillTxt(TEXT.format("""[进化分支]
[{TProtect}]骑士
[{TAttack}]武僧
[{TAttack}]机工士"""))


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "5":
		addBuff(b_diYu.new(5))
		addBuff(b_kuangNu.new(5))