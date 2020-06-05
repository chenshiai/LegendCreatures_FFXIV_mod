extends Item

const Epilogue = "\n来自《最终幻想14》"
func init():
	name = "蒙尘的水晶"
	type = config.EQUITYPE_EQUI
	attInit()
	att.maxHp = 0
	att.cd = 0
	att.atk = 0
	att.cri = 0
	att.mgiAtk = 0
	att.def = 0
	att.mgiDef = 0
	price = 500
	info = "（此物品处于开发中，暂无实际效果）不知是做何用的水晶，刻有奇怪的印记。%s" % [Epilogue] 

const CharaList = ["cFFXIVAolong_1", "cFFXIVAolong_2", "cFFXIVAolong_3",
	"cFFXIVHumen_1", "cFFXIVHumen_2", "cFFXIVHumen_3",
	"cFFXIVLarafel_1", "cFFXIVLarafel_2", "cFFXIVLarafel_3",
	"cFFXIVNeko_1", "cFFXIVNeko_2", "cFFXIVNeko_3",
	"cFFXIVRuga_1", "cFFXIVRuga_2", "cFFXIVRuga_3",
	"cFFXIVSpirit_1", "cFFXIVSpirit_2", "cFFXIVSpirit_3"] 

func _connect():
	for occupation in CharaList:
		if masCha.id.begins_with(occupation):
			setInfo(occupation)
			return
	setInfo(null)

func setInfo(occupation):
	match occupation:
		"cFFXIVAolong_1":
			name = "暗黑骑士之证"
			info = "灵魂的水晶，刻有历代暗黑骑士的记忆和灵魂。"
		"cFFXIVAolong_2":
			name = "武士之证"
			info = "灵魂的水晶，刻有历代武士的记忆和大义。"
		"cFFXIVAolong_3":
			name = "忍者之证"
			info = "灵魂的水晶，刻有历代忍者的记忆和精神。"
		"cFFXIVHumen_1":
			name = "战士之证"
			info = "灵魂的水晶，刻有历代战士的记忆和。"
		"cFFXIVHumen_2":
			name = "绝枪战士之证"
			info = "灵魂的水晶，刻有历代绝枪战士的记忆和觉悟。"
		"cFFXIVHumen_3":
			name = "舞者之证"
			info = "灵魂的水晶，刻有历代舞者的记忆和舞蹈。"
		"cFFXIVLarafel_1":
			name = "白魔法师之证"
			info = "灵魂的水晶，刻有历代白魔法师的记忆和圣迹。"
		"cFFXIVLarafel_2":
			name = "黑魔法师之证"
			info = "灵魂的水晶，刻有历代黑魔法师的记忆和魔力。"
		"cFFXIVLarafel_3":
			name = "赤魔法师之证"
			info = "灵魂的水晶，刻有历代赤魔法师的记忆和心血。"
		"cFFXIVNeko_1":
			name = "学者之证"
			info = "灵魂的水晶，刻有历代学者的记忆和学识。"
		"cFFXIVNeko_2":
			name = "召唤师之证"
			info = "灵魂的水晶，刻有历代召唤师的记忆和真理。"
		"cFFXIVNeko_3":
			name = "吟游诗人之证"
			info = "灵魂的水晶，刻有历代吟游诗人的记忆和旋律。"
		"cFFXIVRuga_1":
			name = "骑士之证"
			info = "灵魂的水晶，刻有历代骑士的记忆和荣誉。"
		"cFFXIVRuga_2":
			name = "武僧之证"
			info = "灵魂的水晶，刻有历代武僧的记忆和气概。"
		"cFFXIVRuga_3":
			name = "机工士之证"
			info = "与其他灵魂水晶不同，这颗水晶上尚未刻下历史的记忆。"
		"cFFXIVSpirit_1":
			name = "占星术士之证"
			info = "灵魂的水晶，刻有历代占星术士的记忆和知识。"
		"cFFXIVSpirit_2":
			name = "占星术士之证"
			info = "灵魂的水晶，刻有历代占星术士的记忆和知识。"
		"cFFXIVSpirit_3":
			name = "龙骑士之证"
			info = "灵魂的水晶，刻有历代龙骑士的记忆和决心。"
		_:
			name = "蒙尘的水晶"
			info = "不知是做何用的水晶，刻有奇怪的印记。%s" % [Epilogue] 