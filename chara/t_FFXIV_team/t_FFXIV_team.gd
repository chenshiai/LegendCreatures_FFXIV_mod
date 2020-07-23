extends Talent
var TEXT = globalData.infoDs["g_bFFXIVText"]
var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var OCCUPATION = []
func init():
	name = "队伍编制"

func get_info():
	return TEXT.T_TEAM

func _connect():
	sys.main.connect("onBattleStart", self, "run")
	player.connect("onAddTalent", self, "population")
	player.connect("onPlusLv", self, "population")

func population(talent = null):
	player.renKou = 10


func run():
	OCCUPATION = []
	var count = 0
	for cha in sys.main.btChas:
		if cha.team == 1 and cha.has_method("get_OCCUPATION"):
			match cha.get_OCCUPATION():
				"Protect":
					addBuff("Protect")
				"CloseCombat":
					addBuff("CloseCombat")
				"Magic":
					addBuff("Magic")
				"LongRange":
					addBuff("LongRange")
				"Treatment":
					addBuff("Treatment")


func addBuff(className):
	if OCCUPATION.has(className):
		return
	OCCUPATION.append(className)
	for cha in sys.main.btChas:
		if cha.team == 1:
			cha.addBuff(self[className].new())


class Team extends Buff:
	var resolve = false
	func _init():
		attInit()
		isNegetive = false

	func _connect():
		sys.main.connect("onCharaDel", self, "run")
	
	func run(cha):
		if cha == masCha:
			resolve = true

# 防护职业 生命上限提高10% 双抗提高10%
class Protect extends Team:
	func _init():
		id = "FFXIV_protect_team"
		att.maxHpL = 0.1
		att.defL = 0.1
		att.mgiDefL = 0.1

	func _del():
		if resolve:
			masCha.addBuff(Protect.new())
			resolve = false


# 近战职业 生命上限提高5% 攻击力提高10%
class CloseCombat extends Team:
	func _init():
		id = "FFXIV_close_combat_team"
		att.maxHpL = 0.05
		att.atkL = 0.1

	func _del():
		if resolve:
			masCha.addBuff(CloseCombat.new())
			resolve = false


# 魔法职业 法强提高10% 双抗提高5%
class Magic extends Team:
	func _init():
		id = "FFXIV_magic_team"
		att.mgiAtkL = 0.1
		att.defL = 0.05
		att.mgiDefL = 0.05

	func _del():
		if resolve:
			masCha.addBuff(Magic.new())
			resolve = false


# 远程职业 攻击力提高10% 双抗提高5%
class LongRange extends Team:
	func _init():
		id = "FFXIV_long_range_team"
		att.atkL = 0.1
		att.defL = 0.05
		att.mgiDefL = 0.05

	func _del():
		if resolve:
			masCha.addBuff(LongRange.new())
			resolve = false


# 治疗职业 法强提高10% 生命上限提高5%
class Treatment extends Team:
	func _init():
		id = "FFXIV_treatment_team"
		att.mgiAtkL = 0.1
		att.maxHpL = 0.05

	func _del():
		if resolve:
			masCha.addBuff(Treatment.new())
			resolve = false