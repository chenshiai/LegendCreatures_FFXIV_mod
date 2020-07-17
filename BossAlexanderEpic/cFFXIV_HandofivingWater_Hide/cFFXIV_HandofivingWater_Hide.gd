extends "../../2098858773/BossChara.gd"

var Summoner = null

var SKILL_TXT = """{c_base}亚历山大绝境战 第一阶段
{c_skill}[离别之手]{/c}：
	当与[有生命活水]持续靠近时（距离小于等于2），变为拳头，10s后造成全屏[极大]伤害；
	当与[有生命活水]持续远离时（距离大于2），变为布，10s后造成全屏[极大]伤害；{/c}"""

var stone
var cloth
var originImg

func _extInit():
	._extInit()
	chaName = "活水之手"
	lv = 4
	attCoe.atkRan = 1
	addSkillTxt(TEXT.format(SKILL_TXT))
	addSkillTxt(TEXT.BOSS_LIVING_LIQUID)

func _init():
	._init()
	set_path("cFFXIVBossTheEpicofAlexander_Hide")
	closeReward()
	sys.main.btChas.append(self)

func parting():
	aiOn = false
	stone = Utils.load_texture(self.direc, "cFFXIV_HandofivingWater_Hide/cha3.png")
	cloth = Utils.load_texture(self.direc, "cFFXIV_HandofivingWater_Hide/cha2.png")
	originImg = img.texture_normal
	var status = null
	if cellRan(Summoner.cell) <= 2:
		status = "near"
		self.img.texture_normal = stone
	elif cellRan(Summoner.cell) > 2:
		status = "far"
		self.img.texture_normal = cloth

	Chant.chantStart("离别之手", 10)
	yield(reTimer(10), "timeout")
	if att.hp <= 0 or self.isDeath or Summoner.isDeath:
		return
	self.img.set_pivot_offset(self.img.rect_size / 2)
	self.img.set_rotation_degrees(120 * self.dire * -1)
	self.normalSpr.position = Vector2(0, 35)
	var eff = Utils.draw_effect("lightBlue", position, Vector2(0, -10), 15, 10)
	eff.show_on_top = false

	if cellRan(Summoner.cell) <= 2 and status == "near" and STAGE == "p1":
		Summoner.Ace()
	elif cellRan(Summoner.cell) >2 and status == "far" and STAGE == "p1":
		Summoner.Ace()

	if att.hp <= 0 or self.isDeath or Summoner.isDeath:
		return
	self.img.set_rotation_degrees(0)
	self.normalSpr.position = Vector2(0, 0)
	self.img.texture_normal = originImg
	yield(reTimer(1), "timeout")
	self.att.hp = -1
	hurtChara(self, 100)

func hurtself(val):
	FFHurtChara(self, val, Chara.HurtType.REAL, Chara.AtkType.EFF)
	
func _onHurt(atkInfo):
	._onHurt(atkInfo)
	if atkInfo.atkCha != self and atkInfo.atkCha != Summoner:
		atkInfo.atkCha.aiCha = Summoner
