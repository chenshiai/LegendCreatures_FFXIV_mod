extends "../cex___FFXIVBaseChara/cex___FFXIVBaseChara.gd"

func _info():
	pass

func _extInit():
	._extInit()
	OCCUPATION = "MagicDPS"
	chaName = "占星术士-昼"
	attCoe.atkRan = 3
	attCoe.maxHp = 3
	attCoe.atk = 2
	attCoe.mgiAtk = 4
	attCoe.def = 2.9
	attCoe.mgiDef = 3.2
	lv = 2
	evos = ["cFFXIVSpirit_1_1"]
	atkEff = "atk_dang"
	addCdSkill("skill_DrawCard", 20)
	addSkillTxt(TEXT.format("""[抽卡]：冷却20s，随机抽取一张卡施加效果给全部队友，持续20s。此技能开局释放一次，不记入CD
{c_balance}太阳神之衡{/c}[双攻提升20%]；{c_arrow}放浪神之箭{/c}[攻击速度20%]；{c_spear}战争神之枪{/c}[暴击增加20%]；
{c_bole}世界树之干{/c}[物防提升20%]；{c_ewer}河流神之瓶{/c}[冷却缩减20%]；{c_spire}建筑神之塔{/c}[魔防提升20%]。"""))
	addCdSkill("skill_StarPhase", 18)
	addSkillTxt(TEXT.format("""[阳星相位]：冷却18s，恢复全场友军[60%]法强的HP
[白昼学派]：{TPassive}阳星相位会给目标施加持续恢复效果，每秒恢复[15%]法强的HP，持续8秒"""))

const STARPHASE_PW = 0.60 # 阳星威力

func _connect():
	._connect()

func _onBattleStart():
	._onBattleStart()
	drawCard()

func _castCdSkill(id):
	._castCdSkill(id)
	if id == "skill_DrawCard" :
		drawCard()
	if id == "skill_StarPhase":
		starPhase(self.lv)

func drawCard():
	var n = sys.rndRan(0, 5)
	var bf = null
	if n == 0:
		Utils.draw_effect("Arcana_01", position, Vector2(0, -240), 14, 0.5)
		bf = BUFF_LIST.b_Balance.new(20)
	elif n == 1:
		Utils.draw_effect("Arcana_02", position, Vector2(0, -240), 14, 0.5)
		bf = BUFF_LIST.b_Arrow.new(20)
	elif n == 2:
		Utils.draw_effect("Arcana_03", position, Vector2(0, -240), 14, 0.5)
		bf = BUFF_LIST.b_Spear.new(20)
	elif n == 3:
		Utils.draw_effect("Arcana_04", position, Vector2(0, -240), 14, 0.5)
		bf = BUFF_LIST.b_Bole.new(20)
	elif n == 4:
		Utils.draw_effect("Arcana_05", position, Vector2(0, -240), 14, 0.5)
		bf = BUFF_LIST.b_Ewer.new(20)
	elif n == 5:
		Utils.draw_effect("Arcana_06", position, Vector2(0, -240), 14, 0.5)
		bf = BUFF_LIST.b_Spire.new(20)

	var chas = getAllChas(2)
	for cha in chas:
		if cha != null and bf != null:
			cha.addBuff(bf)

# 阳星相位		
func starPhase(lv):
	var allys = getAllChas(2)
	allys.shuffle()
	for cha in allys:
		if cha != null:
			cha.plusHp(att.mgiAtk * STARPHASE_PW)
			BUFF_LIST.b_LuckyStar.new(8, att.mgiAtk * 0.15, cha)
			if lv == 4:
				BUFF_LIST.b_Night.new(10, att.mgiAtk * STARPHASE_PW * 1.25, cha)
				Utils.draw_effect("ePcr_mgiPZ", cha.position, Vector2(0,-30), 14)
			yield(reTimer(0.1), "timeout")
			