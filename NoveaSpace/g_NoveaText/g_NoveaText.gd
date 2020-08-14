func _init():
	pass

func format(text, config = {}):
	var Text = text.format(self.Config)
	return Text.format(config)

var Config = {
	"c_base": "[color=%s]" % [COLOR.BASE], # 基础色
	"c_buff": "[color=%s]" % [COLOR.BUFF], # buff色
	"c_mgi": "[color=%s]" % [COLOR.MGI], # 魔法伤害数字色
	"c_phy": "[color=%s]" % [COLOR.PHY], # 物理伤害数字色
	"c_real": "[color=%s]" % [COLOR.REAL], # 真实伤害数字色
	"c_pas": "[color=%s]" % [COLOR.PASSIVE], # 被动技能字色
	"c_skill": "[color=%s]" % [COLOR.SKILL], # 技能名文本色
	"c_las": "[color=%s]" % [COLOR.LASER], # 镭射文本色
	"c_bul": "[color=%s]" % [COLOR.BULLET], # 实弹文本色
	"c_dark": "[color=%s]" % [COLOR.DARK], # 暗物质文本色
	"c_light": "[color=%s]" % [COLOR.LIGHT], # 光线文本色
	"c_ele": "[color=%s]" % [COLOR.ELECTRIC], # 电能文本色
	"s_vib": "[shake rate=7 level=7]", # 振动文本
	"/c": "[/color]",
	"/s": "[/shake]",
}

const COLOR = {
	"BASE": "#eeeeee",
	"BUFF": "#fff66e",
	"PHY": "#ffb386",
	"MGI": "#83f2ff",
	"REAL": "#ffffff",
	"PASSIVE": "#a9a9a9",
	"SKILL": "#48daff",
	"LASER": "#F14141",
	"BULLET": "#EED366",
	"DARK": "#a570c9",
	"LIGHT": "#fff1f2",
	"ELECTRIC": "#219DEF",
	"VIBRATE": "",
}
