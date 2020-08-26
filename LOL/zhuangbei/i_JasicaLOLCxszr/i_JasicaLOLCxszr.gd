extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	id = "i_JasicaLOLCxszr"
	RepeatId = id
	name = "血色之刃"
	att.atk = 60
	att.suck = 0.15
	att.pen = 25
	info = TEXT.format("""{c_base}{c_skill}鲜血追击：{/c}每次攻击获得8层[急速]
每过5秒清除所有[急速]{/c}""")

var t = 0 #计时
func _upS():
	t += 1
	if t >= 5:
		masCha.delBuff(masCha.hasBuff("b_jiSu"))
		t = 0

func _onBattleStart():
	t = 0
		
func _onAtkChara(atkInfo:AtkInfo):
	masCha.addBuff(b_jiSu.new(8))