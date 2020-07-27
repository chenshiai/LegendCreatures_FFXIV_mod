extends "../../2098858773/BossChara.gd"

var SKILL_TXT = """
{c_base}亚历山大绝境战 第四阶段{/c}"""

var pwConfig = {
	"1": "未知",
	"2": "未知",
	"3": "未知",
}

func _extInit():
	._extInit()
	chaName = "完美亚历山大"
	attCoe.atkRan = 5
	lv = 4
	addSkillTxt(TEXT.format(SKILL_TXT, pwConfig))
	addSkillTxt(TEXT.BOSS_LIVING_LIQUID)

# 必要的初始化
func _init():
	._init()
	set_path("cFFXIVBossTheEpicofAlexander_Hide")
	FFControl.HpBar.show()
	connect("onHurtEnd", FFControl.HpBar, "hpDown")
	connect("onAtkChara", FFControl.Limit, "limitBreak_up")
	Utils.background_change(Path, "/background/TheEpicOfAlexander4.png")
	FFControl.FFMusic.play(Path, "/music/Orchestral.oggstr")
	call_deferred("setPos")

func setPos():
	normalSpr.position = Vector2(-52, 5)
	sprcPos = Vector2(-52, 0)
	self.get_node("ui/hpBar").visible = false
	self.show_on_top = false


func _onBattleStart():
	._onBattleStart()

func _onBattleEnd():
	._onBattleEnd()


func _onCharaDel(cha):
	._onCharaDel(cha)

func _onHurt(atkInfo):
	._onHurt(atkInfo)

func _upS():
	._upS()
	setCell(Vector2(4, 2))
	position = sys.main.map.map_to_world(Vector2(4, 2))
