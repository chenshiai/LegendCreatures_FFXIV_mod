extends Talent
var path
var bgimg
var hpBar
var layer = 0
var bosst = 0

func init():
	name = "阿尔法战斗记录"

var bg = false
func _connect():
	player.connect("onAddTalent", self, "bgChange")
	sys.main.connect("onBattleStart", self, "run")

	path = chaData.infoDs["cFFXIV_zTatalu"].dir
	bgimg = sys.main.get_node("scene/bg/bg").get_texture()
	sys.main.connect("onBattleReady", self, "doit")

	hpBar= TextureProgress.new()

	var im = Image.new()
	im.load(path + "/img/hpbar_under.png")
	var imt = ImageTexture.new()
	imt.create_from_image(im)
	hpBar.texture_under = imt
	im.load(path + "/img/hpbar_progress.png")
	var imk= ImageTexture.new()
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

func bgChange(talent:Talent):
	if !bg && talent.name == "阿尔法战斗记录":
		var utils = globalData.infoDs["g_FFXIVUtils"]
		utils.backGroundChange("SpaceTimeSlit")
		bg = true

func get_info():
	return """体验时空狭缝中经过夸大的激昂战斗
所有敌方双攻提高%d%%，战斗后额外获得%d金币
场地变为[欧米茄时空狭缝 阿尔法幻境4]
有概率出现强大的BOSS单位""" % [(0.15 - lv * 0.01) * 100, 5 + lv]

func doit():
	# sys.main.get_node("scene/bg/bg").set_texture(bgimg)
	if hpBar.visible == true:
		hpBar.set_visible(false)

	layer = sys.main.guankaMsg.lvStep - 2
	if sys.rndPer(20):
		hpBar.set_visible(true)
		hpBar.value = 100
		clear(null)
		addenemy("cex___FFXIVOmegaF")

func clear(bosscha):
	var cha
	var n=0
	for i in range(0, 8):
		for j in range(0, 5):
			cha = sys.main.matCha(Vector2(i, j))
			if cha != null && cha.team != 1 && cha != bosscha:
				sys.main.delMatChara(cha)

func addenemy(id):
	bosst = 0
	var cha
	cha = sys.main.newChara(id, 2)
	sys.main.map.add_child(cha)
	sys.main.setMatCha(Vector2(6, 2), cha)
	cha.isDeath = true
	cha.revive(cha.att.maxHp)
	cha.connect("onHurtEnd",self, "hpdown")
	return cha

func hpdown(atkinfo):
	var cha = atkinfo.hitCha
	hpBar.value = cha.att.hp / cha.att.maxHp * 100

class Bf:
	extends Buff
	func _init(lv):
		attInit()
		id = "LightHard"
		isNegetive = false
		att.atkL += 0.15 - lv * 0.01
		att.mgiAtkL += 0.15 - lv * 0.01
		self.lv = lv