extends Talent
var path
var bgimg
var hpBar
var layer = 0
var utils = globalData.infoDs["g_FFXIVUtils"]
var probability = 10 # boss出现概率

func init():
	name = "零式战斗记录"

func _connect():
	sys.main.connect("onBattleReady", self, "come")
	sys.main.connect("onBattleStart", self, "run")
	sys.main.connect("onBattleEnd", self, "reward")

	path = chaData.infoDs["cFFXIV_zTatalu"].dir
	bgimg = sys.main.get_node("scene/bg/bg").get_texture()

	hpBar= TextureProgress.new()

	var im = Image.new()
	im.load(path + "/img/hpbar_under.png")

	var imt = ImageTexture.new()
	imt.create_from_image(im)
	hpBar.texture_under = imt

	var imk= ImageTexture.new()
	im.load(path + "/img/hpbar_progress.png")
	imk.create_from_image(im)

	hpBar.value = 100
	hpBar.texture_progress = imk
	hpBar.visible = false
	hpBar.grow_vertical = 0
	hpBar.anchor_top = 1
	hpBar.anchor_bottom = 1
	hpBar.margin_left = 50
	hpBar.margin_bottom = -17
	sys.main.get_node("kuang/NinePatchRect3").add_child(hpBar)

func run():
	for i in sys.main.btChas:
		if i.team == 2:
			i.addBuff(Bf.new(lv))

func reward():
	player.plusGold(25 + lv * 15)
	sys.main.get_node("scene/bg/bg").set_texture(bgimg)
	if hpBar.visible == true:
		hpBar.set_visible(false)

func get_info():
	return """从此刻开始体验经过夸大的激昂战斗
所有敌方双攻提高%d%%，战斗后额外获得%d金币
升级此天赋会增加游戏难度！！！
有概率出现强大的BOSS单位""" % [(0.1 + lv * 0.01) * 100, 25 + lv * 15]

func come():
	layer = sys.main.guankaMsg.lvStep - 2
	if sys.rndPer(probability):
		utils.backGroundChange("SpaceTimeSlit")
		hpBar.set_visible(true)
		hpBar.value = 100
		probability = 10
		clear(null)
		var n = sys.rndRan(0, 1)
		if n == 0:
			addenemy("cex___FFXIVOmegaF")
		elif n == 1:
			addenemy("cex___FFXIVOmegaF")

	else:
		probability += 1

func clear(bosscha):
	for i in range(0,8):
		for j in range(0,5):
			cha = sys.main.matCha(Vector2(i, j))
			if cha != null && cha.team != 1 && cha != bosscha:
				sys.main.delMatChara(cha)

func addenemy(id):
	var cha
	cha = sys.main.newChara(id, 2)
	sys.main.map.add_child(cha)
	sys.main.setMatCha(Vector2(6, 2), cha)
	cha.isDeath = true
	cha.revive(cha.att.maxHp)
	cha.connect("onHurtEnd", self, "hpdown")
	return cha

func hpdown(atkinfo):
	var cha = atkinfo.hitCha
	hpBar.value = cha.att.hp / cha.att.maxHp * 100

class Bf:
	extends Buff
	func _init(lv):
		attInit()
		self.lv = lv
		isNegetive = false
		att.atkL += 0.1 + lv * 0.01
		att.mgiAtkL += 0.1 + lv * 0.01