extends "./g_FFXIVTranslation.gd"
const baseName = "FFXIVLarafel_1"
const name_1 = {
	"zh_CN": "",
	"en": "",
	"ja": ""
}
const name_2 = {
	"zh_CN": "",
	"en": "",
	"ja": ""
}
const name_3 = {
	"zh_CN": "",
	"en": "",
	"ja": ""
}

const SKILL_CN = """"""
const SKILL_EN = """"""
const SKILL_JA = """"""

const SKILL_1_CN = """"""
const SKILL_1_EN = """"""
const SKILL_1_JA = """"""

const SKILL_2_CN = ""
const SKILL_2_EN = ""
const SKILL_2_JA = ""

const skill_text = {
		"zh_CN": SKILL_CN,
		"en": SKILL_EN,
		"ja": SKILL_JA
	}

const skill_text_1 = {
	"zh_CN": SKILL_1_CN,
	"en": SKILL_1_EN,
	"ja": SKILL_1_JA
}

const skill_text_2 = {
	"zh_CN": SKILL_2_CN,
	"en": SKILL_2_EN,
	"ja": SKILL_2_JA
}


func _init():
	addTr({
		"%s-name_1" % [baseName]: name_1,
		"%s-name_2" % [baseName]: name_2,
		"%s-name_3" % [baseName]: name_3,
		"%s-skill_text" % [baseName]: skill_text,
		"%s-skill_text_1" % [baseName]: skill_text_1,
		"%s-skill_text_2" % [baseName]: skill_text_2,
	})