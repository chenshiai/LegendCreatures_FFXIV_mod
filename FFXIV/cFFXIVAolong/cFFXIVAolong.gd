extends "../BaseChara/FFXIVBaseChara.gd"


func _extInit():
	._extInit()
	chaName = "敖龙冒险者"
	evos = ["cFFXIVAolong_1", "cFFXIVAolong_2", "cFFXIVAolong_3"]
	atkEff = "atk_dao"
	addCdSkill("5",5)
	addSkillTxt("[光之加护]：每5秒，获得5层[狂怒][抵御]")
	addSkillTxt(TEXT.format("""[进化分支]：
[{TProtect}]暗黑骑士
[{TAttack}]武士
[{TAttack}]忍者"""))


func _castCdSkill(id):
	._castCdSkill(id)
	if id == "5":
		addBuff(b_diYu.new(5))
		addBuff(b_kuangNu.new(5))