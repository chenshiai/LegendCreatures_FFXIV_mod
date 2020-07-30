var Utils = globalData.infoDs["g_aFFXIVUtils"] # 全局工具
const TEXT = globalData.infoDs["g_bFFXIVText"]

const TranslationList = ["FFXIV_Astrologian_1", "FFXIV_Astrologian_2", "FFXIV_DarkKnight", "FFXIV_Gunbreaker", "FFXIV_Bard", "FFXIV_BlackMage",
	"FFXIV_Dancer", "FFXIV_Dragoon", "FFXIV_Machinist", "FFXIV_Monk", "FFXIV_Ninja", "FFXIV_Paladin", "FFXIV_RedMage",
	"FFXIV_Samurai", "FFXIV_Scholar", "FFXIV_Summoner", "FFXIV_Warrior", "FFXIV_WhiteMage"]

func _init():
	call_deferred("loadTranslation")

func loadTranslation():
	for name in TranslationList:
		load("%s/g_FFXIVTranslation/%s.gd" % [Utils.Path, name]).new()


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