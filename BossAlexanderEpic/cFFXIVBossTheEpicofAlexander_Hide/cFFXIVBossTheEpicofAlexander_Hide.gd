extends "../../2098858773/BossChara.gd"

var SKILL_TXT = """{c_base}亚历山大绝境战 最终阶段

{c_skill}[加罪罚]{/c}：{TDeath}对仇恨目标造成{c_mgi}[{1}]{/c}的小范围魔法伤害，连续使用三次
{c_skill}[诛罚]{/c}：{TDeath}对目标造成{c_phy}[{2}]{/c}的物理伤害，并附加[物理耐性下降·大]15s
{c_skill}[行动/静止命令]{/c}：[行动命令]秒杀所有静止的敌人，[静止命令]秒杀所有移动的敌人
{c_skill}[未来观测]{/c}：完美亚历山大对未来进行演算，计算如何将敌人置于死地
{c_skill}[至圣大审判]{/c}：场地上随机出现三次轰炸，造成{c_mgi}[{3}]{/c}的魔法伤害，并附加[易伤]15s
{c_skill}[连坐罪]{/c}：对随机目标造成{c_mgi}[{4}]{/c}的大范围魔法伤害
{c_skill}[时间牢狱]{/c}：连续落下时间牢狱，被命中的敌人时间将停止(停止攻击、CD)，若未命中敌人，则团灭所有敌人
{/c}"""

var pwConfig = {
	"1": "未知",
	"2": "未知",
	"3": "未知",
	"4": "未知",
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
	cell = Vector2(4, 2)
	position = sys.main.map.map_to_world(Vector2(4, 2))

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
