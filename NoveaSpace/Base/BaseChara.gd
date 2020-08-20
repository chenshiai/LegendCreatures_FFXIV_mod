# Novea 角色模板文件
# 版本号 0.0.2 2020/08/16
extends Chara
var baseId = ""
const Novea = globalData.infoDs["gNoveaUtils"]
const TEXT = globalData.infoDs["gNoveaText"]
var BaseElement = load("%s%s" % [Novea.Path, "/Base/BaseElement.gd"])

const MGI = Chara.HurtType.MGI # 魔法伤害
const PHY = Chara.HurtType.PHY # 物理伤害
const REAL = Chara.HurtType.REAL # 真实伤害


const NORMAL = Chara.AtkType.NORMAL # 普通攻击
const SKILL = Chara.AtkType.SKILL # 技能攻击
const EFF = Chara.AtkType.EFF # 特效攻击
const LASER = Novea.AtkType.LASER # 镭射攻击
const BULLET = Novea.AtkType.BULLET # 实弹攻击
const DARK = Novea.AtkType.DARK # 暗物质攻击
const LIGHT = Novea.AtkType.LIGHT # 光线攻击
const ELECTRIC = Novea.AtkType.ELECTRIC # 电能攻击
const VIBRATE = Novea.AtkType.VIBRATE # 振动攻击


var SKILL_CRI = false # 技能是否可以暴击
var LASER_CRI = false # 镭射是否可以暴击
var BULLET_CRI = false # 实弹是否可以暴击
var DARK_CRI = false # 暗物质是否可以暴击
var LIGHT_CRI = false # 光线是否可以暴击
var ELECTRIC_CRI = false # 电能是否可以暴击
var VIBRATE_CRI = false # 振动是否可以暴击


var normalAtkEff = null setget set_normalAtkEff, get_normalAtkEff
var normalAtkType = null setget set_normalAtkType, get_normalAtkType
var normalHurtType = null setget set_normalHurtType, get_normalHurtType
var normalAtkSpd = null setget set_normalAtkSpd, get_normalAtkSpd
var normalAtkVal = null setget set_normalAtkVal, get_normalAtkVal


func _onAtkInfo(atkInfo: AtkInfo):
	._onAtkInfo(atkInfo)
	if atkInfo.atkCha == self:
		match atkInfo.atkType:
			SKILL:
				if !SKILL_CRI:
					return
			LASER:
				if !LASER_CRI:
					return
			BULLET:
				if !BULLET_CRI:
					return
			DARK:
				if !DARK_CRI:
					return
			LIGHT:
				if !LIGHT_CRI:
					return
			ELECTRIC:
				if !ELECTRIC_CRI:
					return
			VIBRATE:
				if !VIBRATE_CRI:
					return
			NORMAL:
				atkInfo.canCri = true
			_:
				return
		atkInfo.canCri = true


func NSHurt(target, atkVal, hurtType, atkType):
	if target != null and !target.isDeath:
		self.hurtChara(target, atkVal, hurtType, atkType)


func normalAtkChara(cha):
	var eff = newEff(self.normalAtkEff, sprcPos)
	eff._initFlyCha(cha, self.normalAtkSpd)
	_onNormalAtk(cha)
	atkInfo.rate = 1
	atkInfo.isCri = false
	atkInfo.canCri = false
	atkInfo.atkVal = self.normalAtkVal
	atkInfo.hurtType = self.normalHurtType
	atkInfo.atkType = self.normalAtkType
	yield(eff, "onReach")
	atkRun(cha)


func set_normalAtkEff(value):
	normalAtkEff = value

func get_normalAtkEff():
	if normalAtkEff:
		return normalAtkEff
	return self.atkEff


func set_normalHurtType(value):
	if value >= 0:
		normalHurtType = value

func get_normalHurtType():
	if normalHurtType:
		return normalHurtType
	return PHY


func set_normalAtkType(value):
	if value >= 0:
		normalAtkType = value
	
func get_normalAtkType():
	if normalAtkType:
		return normalAtkType
	return NORMAL


func set_normalAtkSpd(value):
	if value >= 0:
		normalAtkSpd = value

func get_normalAtkSpd():
	if normalAtkSpd:
		return normalAtkSpd
	return 500


func set_normalAtkVal(value):
	normalAtkVal = value

func get_normalAtkVal():
	if normalAtkVal:
		return att[normalAtkVal]
	return att.atk