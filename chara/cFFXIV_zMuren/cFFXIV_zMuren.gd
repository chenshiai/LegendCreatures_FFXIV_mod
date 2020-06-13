extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
	chaName = "东方木人"
	attCoe.maxHp = 256
	attCoe.atk = 0
	attCoe.mgiAtk = 0
	attCoe.def = 0
	attCoe.mgiDef = 0
	lv = 4
	addSkillTxt("""（测试专用）产自多玛国的木人，坚硬耐磨，具有极优的抗打击能力。是广大光之战士的得力助手，利于磨练自身技艺
“我们多玛产的木人质量绝对保证！你就放心大胆的砍吧！” —— 飞燕""")

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	# var path = self.direc
	# var im = Image.new()
	# var imt = ImageTexture.new()
	# im.load(path + "cFFXIV_zTatalu/cha.png")
	# imt.create_from_image(im)
	# self.img.texture_normal = imt
	# self.img.texture_pressed = im
	# self.img.texture_hover = im
	# self.img.texture_disabled = im
	# self.img.texture_focused = im
	# self.img.texture_click_mask = im
	# self.img.texture_focused = im

	var chas = getAllChas(2)
	chas.sort_custom(Utils.Calculation, "sort_MaxMgiAtk")
	var mgiAtkMaxAlly = chas[0]
	print("魔攻最高：",mgiAtkMaxAlly.id)

	chas.sort_custom(Utils.Calculation, "sort_MaxAtk")
	var atkMaxAlly = chas[0]
	print("物攻最高：",atkMaxAlly.id)

	if mgiAtkMaxAlly != self:
		mgiAtkMaxAlly.addBuff(BUFF_LIST.b_DancingPartner.new())

	if atkMaxAlly != self and atkMaxAlly != mgiAtkMaxAlly:
		atkMaxAlly.addBuff(BUFF_LIST.b_DancingPartner.new())

	# addBuff(BUFF_LIST.b_DancingPartner.new())

	aiOn = null
	aiCha = null

func _onDeath(atkInfo):
	._onDeath(atkInfo)
	isDeath = false
	plusHp(att.maxHp * 1)
	