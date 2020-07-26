extends "../../2098858773/BossChara.gd"

func _extInit():
	._extInit()
	chaName = "完美亚历山大"
	attCoe.atkRan = 5
	lv = 4

# 必要的初始化
func _init():
	._init()
	set_path("cFFXIVBossTheEpicofAlexander_Hide")
	Utils.background_change(Path, "/background/TheEpicOfAlexander4.png")
	FFControl.FFMusic.play(Path, "/music/Orchestral.oggstr")
	HpBarConnect()
	self.show_on_top = false
	call_deferred("setPos")

func setPos():
	normalSpr.position = Vector2(-52, 5)
	sprcPos = Vector2(-52, 0)
	self.get_node("ui/hpBar").visible = false

func _connect():
	._connect()

func _castCdSkill(id):
	._castCdSkill(id)


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

func HpBarConnect():
	FFControl.HpBar.show()
	connect("onHurtEnd", FFControl.HpBar, "hpDown")
	connect("onAtkChara", FFControl.Limit, "limitBreak_up")