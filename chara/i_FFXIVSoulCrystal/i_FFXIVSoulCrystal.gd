extends Item
var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
var Soul = globalData.infoDs["g_FFXIVSoulSkill"]
var SoulExample = null # 当前使用者的灵魂实例

const Epilogue = "\n来自《最终幻想14》"
func init():
	attInit()
	id = "SoulCrystal"
	name = "蒙尘的水晶"
	type = config.EQUITYPE_EQUI
	price = 500
	info = "不知是做何用的水晶，刻有奇怪的印记。%s" % [Epilogue] 

const CharaList = ["cFFXIVAolong_1", "cFFXIVAolong_2", "cFFXIVAolong_3",
	"cFFXIVHumen_1", "cFFXIVHumen_2", "cFFXIVHumen_3",
	"cFFXIVLarafel_1", "cFFXIVLarafel_2", "cFFXIVLarafel_3",
	"cFFXIVNeko_1", "cFFXIVNeko_2", "cFFXIVNeko_3",
	"cFFXIVRuga_1", "cFFXIVRuga_2", "cFFXIVRuga_3",
	"cFFXIVSpirit_1", "cFFXIVSpirit_2", "cFFXIVSpirit_3"] 

func _connect():
	print(sys.main.get_node("ui/itemSll/itemGrid"))
	for item in masCha.items:
		if item.id == "SoulCrystal":
			setInfo(null)
			return

	for occupation in CharaList:
		if masCha.id.begins_with(occupation):
			setInfo(occupation)
			return

func setInfo(occupation):
	match occupation:
		"cFFXIVAolong_1":
			SoulExample = Soul.DarkKnight.new()
			sys.main.connect("onBattleStart", SoulExample, "skillInit")
			masCha.connect("onHurt", SoulExample, "livingDeath")
			masCha.connect("onPlusHp", SoulExample, "relieve")

		"cFFXIVAolong_2":
			SoulExample = Soul.Samurai.new()
			var hasSkill = false
			for skill in masCha.skills:
				if skill.id == "skill_Shinten":
					hasSkill = true
			if !hasSkill:
				masCha.addCdSkill("skill_Shinten", 8)
			SoulExample.setMasCha(masCha)
			masCha.connect("onCastCdSkill", SoulExample, "shinten")

		"cFFXIVAolong_3":
			SoulExample = Soul.Ninja.new()
			var hasSkill = false
			for skill in masCha.skills:
				if skill.id == "skill_Dream":
					hasSkill = true
			if !hasSkill:
				masCha.addCdSkill("skill_Dream", 19)
			SoulExample.setMasCha(masCha)
			masCha.connect("onCastCdSkill", SoulExample, "dream")

		"cFFXIVHumen_1":
			SoulExample = Soul.Warrior.new()
			SoulExample.setMasCha(masCha)
			var hasSkill = false
			for skill in masCha.skills:
				if skill.id == "skill_Equilibrium":
					hasSkill = true
			if !hasSkill:
				masCha.addCdSkill("skill_Equilibrium", 15)
			masCha.connect("onCastCdSkill", SoulExample, "heartOfLight")

		"cFFXIVHumen_2":
			SoulExample = Soul.Gunbreaker.new()
			var hasSkill = false
			for skill in masCha.skills:
				if skill.id == "skill_HeartOfLight":
					hasSkill = true
			if !hasSkill:
				masCha.addCdSkill("skill_HeartOfLight", 20)
			SoulExample.setTeam(masCha.team)
			masCha.connect("onCastCdSkill", SoulExample, "heartOfLight")

		"cFFXIVHumen_3":
			SoulExample = Soul.Dancer.new()
			SoulExample.setMasCha(masCha)
			SoulExample.setTeam(masCha.team)
			sys.main.connect("onAtkChara", SoulExample, "fanDance")

		"cFFXIVLarafel_1":
			SoulExample = Soul.WhiteMage.new()

		"cFFXIVLarafel_2":
			SoulExample = Soul.BlackMage.new()
			SoulExample.setMasCha(masCha)
			sys.main.connect("onBattleStart", SoulExample, "enochian")

		"cFFXIVLarafel_3":
			SoulExample = Soul.RedMage.new()
			var hasSkill = false
			for skill in masCha.skills:
				if skill.id == "skill_Vercure":
					hasSkill = true
			if !hasSkill:
				masCha.addCdSkill("skill_Vercure", 16)
			SoulExample.setTeam(masCha.team)
			SoulExample.setMasCha(masCha)
			masCha.connect("onCastCdSkill", SoulExample, "vercure")

		"cFFXIVNeko_1":
			SoulExample = Soul.Scholar.new()
			var hasSkill = false
			for skill in masCha.skills:
				if skill.id == "skill_ChainStratagem":
					hasSkill = true
			if !hasSkill:
				masCha.addCdSkill("skill_ChainStratagem", 15)
			SoulExample.setMasCha(masCha)
			masCha.connect("onCastCdSkill", SoulExample, "chainStratagem")

		"cFFXIVNeko_2":
			SoulExample = Soul.Summoner.new()
			var hasSkill = false
			for skill in masCha.skills:
				if skill.id == "skill__TriDisaster":
					hasSkill = true
			if !hasSkill:
				masCha.addCdSkill("skill__TriDisaster", 15)
			SoulExample.setMasCha(masCha)
			masCha.connect("onCastCdSkill", SoulExample, "triDisaster")

		"cFFXIVNeko_3":
			SoulExample = Soul.Bard.new()
			SoulExample.setTeam(masCha.team)
			sys.main.connect("onBattleStart", SoulExample, "requiemOfTheDevil")

		"cFFXIVRuga_1":
			SoulExample = Soul.Paladin.new()
			var hasSkill = false
			for skill in masCha.skills:
				if skill.id == "skill_Requiescat":
					hasSkill = true
			if !hasSkill:
				masCha.addCdSkill("skill_Requiescat", 27)
			SoulExample.setMasCha(masCha)
			masCha.connect("onCastCdSkill", SoulExample, "requiescat")

		"cFFXIVRuga_2":
			SoulExample = Soul.Monk.new()
			var hasSkill = false
			for skill in masCha.skills:
				if skill.id == "skill_Mantra":
					hasSkill = true
			if !hasSkill:
				masCha.addCdSkill("skill_Mantra", 30)
			SoulExample.setTeam(masCha.team)
			masCha.connect("onCastCdSkill", SoulExample, "mantra")

		"cFFXIVRuga_3":
			SoulExample = Soul.Machinist.new()
			SoulExample.setMasCha(masCha)
			SoulExample.setTeam(masCha.team)
			masCha.connect("onAtkChara", SoulExample, "fireGun")

		"cFFXIVSpirit_1", "cFFXIVSpirit_2":
			SoulExample = Soul.Astrologian.new()
			var hasSkill = false
			for skill in masCha.skills:
				if skill.id == "skill_Collective":
					hasSkill = true
			if !hasSkill:
				masCha.addCdSkill("skill_Collective", 36)
			SoulExample.setTeam(masCha.team)
			SoulExample.setMasCha(masCha)
			masCha.connect("onCastCdSkill", SoulExample, "collective")

		"cFFXIVSpirit_3":
			SoulExample = Soul.Dragoon.new()
			SoulExample.setMasCha(masCha)
			sys.main.connect("onBattleStart", SoulExample, "skillInit")
			masCha.connect("onCastCdSkill", SoulExample, "lifeOfTheDragon")
		_:
			setInitAtt()
	if SoulExample != null:
		setEquipmentInfo()

func setInitAtt():
	name = "蒙尘的水晶"
	info = "不知是做何用的水晶，刻有奇怪的印记。%s" % [Epilogue]
	att.maxHp = 0
	att.cd = 0
	att.atk = 0
	att.cri = 0
	att.mgiAtk = 0
	att.def = 0
	att.mgiDef = 0
	att.spd = 0
	SoulExample = null
			
func setEquipmentInfo():
	name = SoulExample.name
	info = SoulExample.info
	att.maxHp = SoulExample.att.maxHp
	att.cd = SoulExample.att.cd
	att.atk = SoulExample.att.atk
	att.cri = SoulExample.att.cri
	att.mgiAtk = SoulExample.att.mgiAtk
	att.def = SoulExample.att.def
	att.mgiDef = SoulExample.att.mgiDef
	att.spd = SoulExample.att.spd