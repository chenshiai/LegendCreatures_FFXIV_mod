extends Item
const MGI = Chara.HurtType.MGI # 魔法伤害
const PHY = Chara.HurtType.PHY # 物理伤害
const REAL = Chara.HurtType.REAL # 真实伤害

const NORMAL = Chara.AtkType.NORMAL # 普通攻击
const SKILL = Chara.AtkType.SKILL # 技能攻击
const EFF = Chara.AtkType.EFF # 特效攻击
const MISS = Chara.AtkType.MISS # miss攻击

func _init():
	attInit()
	type = config.EQUITYPE_EQUI

func _connect():
	masCha.connect("onHurt", self, "_onHurt")
	masCha.connect("onPlusHp",self,"_onPlusHp")
	masCha.connect("onAddItem", self, "_onAddItem")
	masCha.connect("onDelItem", self, "_onDelItem")
	masCha.connect("onAtkChara", self, "_onAtkChara")
	masCha.connect("onCastCdSkill", self, "_onCastCdSkill")
	sys.main.connect("onBattleEnd", self, "_onBattleEnd")
	sys.main.connect("onBattleStart", self, "_onBattleStart")
	# 还可以连接更多的事件，只要用的到的都可以连接，连接后记得在下面声明一下空函数
	_updataInfo()

func _onBattleStart():
	pass
func _onBattleEnd():
	pass
func _onAtkChara(atkInfo):
	pass
func _onCastCdSkill(id):
	pass
func _onHurt(atkInfo):
	pass
func _onPlusHp(val):
	pass

# 变更装备的时候更新文案
func _onAddItem(item):
	_updataInfo()
	pass

func _onDelItem(item):
	_updataInfo()
	pass

# ---------------- 下面是定制部分 ---------------
const ABuff = globalData.infoDs["g_EBuffList"]
const TEXT = globalData.infoDs["g_text"]

const EquipChannelDire = {
	"哀嚎耳环": "Agony",
	"情变": "Heartbroke",
	"绝境突矛": "Rebirth",
	"慈悲/慈爱": "Pure",
	"贪欲大剑": "Greed",
	"不可思议天狗面": "Stink",
	"虚无三尖枪": "Fade",
	"温和拳刃": "Gental",
	"自由之心": "Beauty",
	"教育名册": "Heritage",
}
var EquipChannelText = {
	"Agony": "\n悲叹：",
	"Heartbroke": "\n失情：",
	"Rebirth": "\n重生：",
	"Pure": "\n纯洁：",
	"Greed": "\n贪婪：",
	"Stink": "\n表里不一：",
	"Fade": "\n消逝：",
	"Gental": "\n温柔：",
	"Beauty": "\n美人：",
	"Heritage": "\n传承：",
}
var EquipmentInfo = "" # 装备的基础文本说明

func _set_equip_channel(sp):
	for key in sp.keys():
		EquipChannelText[key] += sp[key]
	# "\n悲叹：" += "普通攻击额外附加1层|哀嚎|"
	# "\n失情：" += "技能额外为目标附加1层|哀嚎|"
	# "\n重生：" += "技能驱散自己所有|哀嚎|"

# 在需要的时候调用此函数，来更新文案
func _updataInfo():
	var str = EquipmentInfo
	var EquipChannel = []

	for item in masCha.items:
		EquipChannel.append(EquipChannelDire[item.name])
	# EquipChannel == ["Agony", "Heartbroke", "Rebirth"]

	for channel in EquipChannel:
		str += EquipChannelText[channel]
	# str += "\n悲叹：普通攻击额外附加1层|哀嚎|"
	# str += "\n失情：技能额外为目标附加1层|哀嚎|"
	# str += "\n重生：技能驱散自己所有|哀嚎|"
	info = TEXT.format(str)
