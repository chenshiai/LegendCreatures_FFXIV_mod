extends "../cFFXIVBossTheEpicofAlexander_Hide/BossChara.gd"
var Summoner = null

var SKILL_TXT = """{c_base}亚历山大绝境战 第一阶段
[离别之手]：
	当与[有生命活水]距离较近（小于等于2）时，变为拳头，10s后造成全屏[极大]伤害；
	当与[有生命活水]距离较远（大于2）时，变为布，10s后造成全屏[极大]伤害；{/c}"""

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

func parting():
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
	if att.hp <= 0:
		return
	self.img.set_pivot_offset(self.img.rect_size / 2)
	self.img.set_rotation_degrees(120 * self.dire * -1)
	self.normalSpr.position = Vector2(0, 35)
	var eff = Utils.draw_effect("lightBlue", position, Vector2(0, -10), 15, 10)
	eff.show_on_top = false

	if cellRan(Summoner.cell) <= 2 and status == "near":
		for cha in getAllChas(1):
			cha.att.hp = -1
			FFHurtChara(cha, 1, Chara.HurtType.REAL, Chara.AtkType.EFF)
	elif cellRan(Summoner.cell) >2 and status == "far":
		for cha in getAllChas(1):
			cha.att.hp = -1
			FFHurtChara(cha, 1, Chara.HurtType.REAL, Chara.AtkType.EFF)

	yield(reTimer(1), "timeout")
	if att.hp <= 0:
		return
	self.img.set_rotation_degrees(0)
	self.normalSpr.position = Vector2(0, 0)
	self.img.texture_normal = originImg
	yield(reTimer(1), "timeout")
	self.att.hp = -1
	hurtChara(self, 0)

func _upS():
	aiOn = false