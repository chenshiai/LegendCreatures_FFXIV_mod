extends Item
const Lol = globalData.infoDs["g_LOLUtils"]
const TEXT = globalData.infoDs["g_LOLText"]
const STATUS = globalData.infoDs["g_LOLStatusList"]

const MGI = Chara.HurtType.MGI # 魔法伤害
const PHY = Chara.HurtType.PHY # 物理伤害
const REAL = Chara.HurtType.REAL # 真实伤害


const NORMAL = Chara.AtkType.NORMAL # 普通攻击
const SKILL = Chara.AtkType.SKILL # 技能攻击
const EFF = Chara.AtkType.EFF # 特效攻击
const MISS = Chara.AtkType.MISS # miss攻击

var Repeat = false # 是否有冲突装备
var HasRepeatSkill
var RepeatId = "" # 冲突装备Id
var ItemSkill = {} # 装备唯一技能字典

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
	_set_repeat()


func _set_repeat():
	for item in masCha.items:
		if item != self:
			itemskills = Lol.getVal(item, "ItemSkill", {})
			if item.id == RepeatId:
				Repeat = true
				return
			for skill in self.ItemSkill.keys():
				if itemskills[skill]:
					item.ItemSkill[skill] = false
	Repeat = false


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
func _onAddItem(item):
	pass
func _onDelItem(item):
	_set_repeat()