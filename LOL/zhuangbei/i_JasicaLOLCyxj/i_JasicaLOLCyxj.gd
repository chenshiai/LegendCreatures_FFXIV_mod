extends "../LOLItemBase/LOLItemBase.gd"

var HD = 0
var Infos = """{c_base}{c_skill}护盾：{0}{/c}
生命偷取溢出的生命值会形成一个最多抵挡1500点伤害的护盾
每回合战斗开始，上一回合的护盾值衰减30%{/c}"""

func _init():
	name = "饮血剑"
	att.atk = 80
	att.suck = 0.20
	info = TEXT.format(Infos, { 0: HD as int })

func _onAtkChara(atkInfo):
	if atkInfo.atkType == NORMAL:
		var suckVal = atkInfo.hurtVal * masCha.att.suck
		if (masCha.att.hp + suckVal) > masCha.att.maxHp:
			HD += (masCha.att.hp + suckVal) - masCha.att.maxHp

func _onHurt(atkInfo):
	if HD > 0:
		atkInfo.hurtVal = 0
		HD -= atkInfo.atkVal
		if HD < 0:
			HD = 0
		updataInfo()

func _onBattleEnd():
	if HD > 0:
		HD *= 0.7
		updataInfo()

func updataInfo():
	info = TEXT.format(Infos, { 0: HD as int })
