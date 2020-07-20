var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
const TEXT = globalData.infoDs["g_bFFXIVText"]

func _init():
	call_deferred("loadTranslation")

func loadTranslation():
	load("%s/g_FFXIVTranslation/FFXIV_DarkKnight.gd" % [Utils.Path]).new()


func addTr(TextObject):
	var Chinese = Translation.new()
	Chinese.locale = "zh_CN"
	var English = Translation.new()
	English.locale = "en"
	var Japanese = Translation.new()
	Japanese.locale = "ja"

	for trans in [Chinese, English, Japanese]:
		var locale = trans.locale
		for key in TextObject.keys():
			trans.add_message(key, TEXT.format(TextObject[key][locale]))
		TranslationServer.add_translation(trans)