extends Item
const Lol = globalData.infoDs["g_JasicalLOLUtils"]
const TEXT = globalData.infoDs["g_JasicalLOLText"]

const MGI = Chara.HurtType.MGI # 魔法伤害
const PHY = Chara.HurtType.PHY # 物理伤害
const REAL = Chara.HurtType.REAL # 真实伤害


const NORMAL = Chara.AtkType.NORMAL # 普通攻击
const SKILL = Chara.AtkType.SKILL # 技能攻击
const EFF = Chara.AtkType.EFF # 特效攻击


func _init():
	attInit()
	type = config.EQUITYPE_EQUI

func _connect():
  pass