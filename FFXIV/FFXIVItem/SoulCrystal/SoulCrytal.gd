extends Item
const Utils = globalData.infoDs["g_aFFXIVUtils"]# 全局工具
const TEXT = globalData.infoDs["g_bFFXIVText"]
const Soul = globalData.infoDs["g_FFXIVSoulSkill"]
const Epilogue = """【消耗品】装备的角色将获得对应的[灵魂技能]，使用后该装备会消失。
仅限《最终幻想14》的角色使用"""

const CharaList = ["cFFXIVAolong_1", "cFFXIVAolong_2", "cFFXIVAolong_3",
	"cFFXIVHumen_1", "cFFXIVHumen_2", "cFFXIVHumen_3",
	"cFFXIVLarafel_1", "cFFXIVLarafel_2", "cFFXIVLarafel_3",
	"cFFXIVNeko_1", "cFFXIVNeko_2", "cFFXIVNeko_3",
	"cFFXIVRuga_1", "cFFXIVRuga_2", "cFFXIVRuga_3",
	"cFFXIVSpirit_1", "cFFXIVSpirit_2", "cFFXIVSpirit_3", "c"]

var SoulExample = null # 当前使用者的灵魂实例

func init():
	attInit()
	id = "i_FFXIVSoulCrystal"
	name = "灵魂水晶"
	type = config.EQUITYPE_EQUI
	price = 100
	info = Epilogue

func _connect():
	if SoulExample != null:
		SoulExample.deleteCdSkill()

	for item in masCha.items:
		if item.id == "i_FFXIVSoulCrystal":
			setInfo(null)
			print("装备无效！灵魂水晶最多只有一件可以生效！")
			return

	for occupation in CharaList:
		if masCha.id.begins_with(occupation):
			setInfo(occupation)
			return

func setInfo(occupation):
	match occupation:
		"cFFXIVAolong_1":
			SoulExample = Soul.DarkKnight.new(masCha)

		"cFFXIVAolong_2":
			SoulExample = Soul.Samurai.new(masCha)

		"cFFXIVAolong_3":
			SoulExample = Soul.Ninja.new(masCha)

		"cFFXIVHumen_1":
			SoulExample = Soul.Warrior.new(masCha)

		"cFFXIVHumen_2":
			SoulExample = Soul.Gunbreaker.new(masCha)

		"cFFXIVHumen_3":
			SoulExample = Soul.Dancer.new(masCha)

		"cFFXIVLarafel_1":
			SoulExample = Soul.WhiteMage.new(masCha)

		"cFFXIVLarafel_2":
			SoulExample = Soul.BlackMage.new(masCha)

		"cFFXIVLarafel_3":
			SoulExample = Soul.RedMage.new(masCha)

		"cFFXIVNeko_1":
			SoulExample = Soul.Scholar.new(masCha)

		"cFFXIVNeko_2":
			SoulExample = Soul.Summoner.new(masCha)

		"cFFXIVNeko_3":
			SoulExample = Soul.Bard.new(masCha)

		"cFFXIVRuga_1":
			SoulExample = Soul.Paladin.new(masCha)

		"cFFXIVRuga_2":
			SoulExample = Soul.Monk.new(masCha)

		"cFFXIVRuga_3":
			SoulExample = Soul.Machinist.new(masCha)

		"cFFXIVSpirit_1", "cFFXIVSpirit_2":
			SoulExample = Soul.Astrologian.new(masCha)

		"cFFXIVSpirit_3":
			SoulExample = Soul.Dragoon.new(masCha)

		"c":
			setInitAtt()

	if SoulExample != null:
		setEquipmentInfo()

func setInitAtt():
	SoulExample = null
	name = "灵魂水晶"
	info = Epilogue
	att.maxHp = 0
	att.cd = 0
	att.atk = 0
	att.cri = 0
	att.mgiAtk = 0
	att.def = 0
	att.mgiDef = 0
	att.spd = 0
	att.mgiPen = 0
	att.pen = 0

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
	att.mgiPen = SoulExample.att.mgiPen
	att.pen = SoulExample.att.pen