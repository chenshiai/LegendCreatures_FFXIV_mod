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
			name = "忍者之证"
			info = "灵魂的水晶，刻有历代忍者的记忆和精神。[天地人]"

		"cFFXIVHumen_1":
			name = "战士之证"
			info = "灵魂的水晶，刻有历代战士的记忆和斗志。[原初的勇猛]"

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
			name = "舞者之证"
			info = "灵魂的水晶，刻有历代舞者的记忆和舞蹈。[扇舞·急]"

		"cFFXIVLarafel_1":
			name = "白魔法师之证"
			info = "灵魂的水晶，刻有历代白魔法师的记忆和圣迹。[神速咏唱]"

		"cFFXIVLarafel_2":
			SoulExample = Soul.BlackMage.new(masCha)
			sys.main.connect("onBattleStart", SoulExample, "enochian")

		"cFFXIVLarafel_3":
			name = "赤魔法师之证"
			info = "灵魂的水晶，刻有历代赤魔法师的记忆和心血。[赤治疗/赤复活]"

		"cFFXIVNeko_1":
			name = "学者之证"
			info = "灵魂的水晶，刻有历代学者的记忆和学识。[连环计]"

		"cFFXIVNeko_2":
			name = "召唤师之证"
			info = "灵魂的水晶，刻有历代召唤师的记忆和真理。[三重灾祸]"

		"cFFXIVNeko_3":
			SoulExample = Soul.Bard.new()
			SoulExample.setTeam(masCha.team)
			sys.main.connect("onBattleStart", SoulExample, "requiemOfTheDevil")

		"cFFXIVRuga_1":
			name = "骑士之证"
			info = "灵魂的水晶，刻有历代骑士的记忆和荣誉。[武装戍卫]"

		"cFFXIVRuga_2":
			name = "武僧之证"
			info = "灵魂的水晶，刻有历代武僧的记忆和气概。[义结金兰]"

		"cFFXIVRuga_3":
			name = "机工士之证"
			info = "与其他灵魂水晶不同，这颗水晶上尚未刻下历史的记忆。[后式自走人偶]"

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