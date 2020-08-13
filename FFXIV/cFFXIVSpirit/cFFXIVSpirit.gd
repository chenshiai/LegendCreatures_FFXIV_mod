extends "../BaseChara/FFXIVBaseChara.gd"


func _extInit():
	._extInit()
	chaName = "精灵冒险者"
	evos = ["cFFXIVSpirit_1", "cFFXIVSpirit_2", "cFFXIVSpirit_3"]
	atkEff = "atk_dao"
	addCdSkill("5",5)
	addSkillTxt("[光之加护]：每5秒，获得5层[狂怒][抵御]")
	addSkillTxt(TEXT.format("""[进化分支]
[{TTreatment}]占星术士
[{TAttack}]龙骑士"""))


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "5":
		addBuff(b_diYu.new(5))
		addBuff(b_kuangNu.new(5))