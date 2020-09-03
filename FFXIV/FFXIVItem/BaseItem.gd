extends Item
const Utils = globalData.infoDs["g_aFFXIVUtils"]
const TEXT = globalData.infoDs["g_bFFXIVText"]
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
	sys.main.connect("onBattleStart", self, "_onBattleStart")
	sys.main.connect("onBattleEnd", self, "_onBattleEnd")
	sys.main.connect("onCharaDel", self, "_onCharaDel")


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
	pass
func _onCharaDel(cha):
	pass
