# Novea 角色模板文件
# 版本号 0.0.1 2020/08/14
extends Chara
const Novea = globalData.infoDs["g_NoveaUtils"]
const MGI = Chara.HurtType.MGI # 魔法伤害
const PHY = Chara.HurtType.PHY # 物理伤害
const REAL = Chara.HurtType.REAL # 真实伤害


const NORMAL = Chara.AtkType.NORMAL # 普通攻击
const SKILL = Chara.AtkType.SKILL # 技能攻击
const EFF = Chara.AtkType.EFF # 特效攻击

var baseId = ""
var SKILL_CRI = false


func _extInit():
	._extInit()
	chaName = "基础角色"
	attCoe.atkRan = 1
	attCoe.maxHp = 1
	attCoe.atk = 1
	attCoe.mgiAtk = 1
	attCoe.def = 1
	attCoe.mgiDef = 1
	lv = 1


func _onAtkInfo(atkInfo: AtkInfo):
	._onAtkInfo(atkInfo)
	if atkInfo.atkCha == self and atkInfo.atkType == SKILL and SKILL_CRI:
		atkInfo.canCri = true


func NSHurt(target, atkVal, hurtType, atkType):
	if target != null and !target.isDeath:
		self.hurtChara(target, atkVal, hurtType, atkType)

