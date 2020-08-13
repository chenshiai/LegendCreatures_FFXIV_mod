func _init():
	pass

func format(text, config = {}):
	var Text = text.format(self.Config)
	return Text.format(config)

var Config = {
	"c_base": "[color=%s]" % [COLOR.BASE], # 基础色
	"c_buff": "[color=%s]" % [COLOR.BUFF], # buff色
	"c_mgi": "[color=%s]" % [COLOR.C_MGI], # 魔法伤害数字色
	"c_phy": "[color=%s]" % [COLOR.C_PHY], # 物理伤害数字色
	"c_pas": "[color=%s]" % [COLOR.PASSIVE], # 被动技能字色
	"c_Tmgi": "[color=%s]" % [COLOR.MGI], # 魔法伤害文本色
	"c_Tphy": "[color=%s]" % [COLOR.PHY], # 物理伤害文本色
	"c_skill": "[color=%s]" % [COLOR.SKILL], # 技能文本色
	"c_death": "[color=%s]" % [COLOR.DEATH],
	"/c": "[/color]",
}

const COLOR = {
	"BASE": "#eeeeee",
	"BUFF": "#fff66e",
	"PHY": "#ff7522",
	"C_PHY": "#ffb386",
	"MGI": "#00e4ff",
	"C_MGI": "#83f2ff",
	"PASSIVE": "#a9a9a9",
	"REAL": "#ffffff",
	"PROTECT": "#79d8ff",
	"ATTACK": "#ff7e7e",
	"TREATMENT": "#9cff7d",
	"DEATH": "#ff7e7e",
	"BALANCE": "#ff4848",
	"ARROW": "#86d1f4",
	"SPEAR": "#8693f4",
	"BOLE": "#80f87d",
	"EWER": "#229fff",
	"SPIRE": "#fcda72",
	"SKILL": "#48daff"
}
