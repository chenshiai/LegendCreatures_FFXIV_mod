extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLMwzdbj"
	RepeatId = "i_JasicaLOLMwzdbj"
	name = "亡者的板甲"
	att.maxHp = 425
	att.def = 60
	info = TEXT.format("""{c_base}{c_skill}唯一被动——无畏：{/c}受伤时，积攒【气势】层数，最多15层。
{c_skill}唯一被动——碾压猛击：{/c}普攻时造成 气势层数 x 1%自身物理防御 的额外魔法伤害，同时消耗所有【气势】层数。

“只有一种方法能让你从我这里拿到这件盔甲......” - 被遗忘的名字{/c}""")
	
var	num = 0 # 气势层数累计

func _onAtkChara(atkInfo):
	if atkInfo.atkType == NORMAL and !Repeat:
		masCha.hurtChara(atkInfo.hitCha, masCha.att.def*0.1*num, MGI, EFF)
		num = 0

func _onHurt(atkInfo):
	if !Repeat:
		num += 1