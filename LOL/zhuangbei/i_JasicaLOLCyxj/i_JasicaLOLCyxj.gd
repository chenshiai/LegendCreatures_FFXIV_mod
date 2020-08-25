extends "../LOLItemBase/LOLItemBase.gd"


func _init():
	name = "饮血剑"
	att.atk = 80
	att.suck = 0.20
	info = TEXT.format("""护盾：0
生命偷取溢出的生命值会形成一个最多抵挡1500点伤害的护盾
每回合战斗开始，上一回合的护盾值衰减30%""")

var hp = 0
var d = 0
var infos = "护盾：%s\n生命偷取溢出的生命会变成护盾最多存储1500\n每回合战斗开始护盾值衰减30%%" 
func _onAtkChara(atkInfo):
	if masCha.att.hp > (masCha.att.maxHp - atkInfo.hurtVal*masCha.att.suck):
		hp = atkInfo.hurtVal*masCha.att.suck - (masCha.att.maxHp - masCha.att.hp)

func _onPlusHp(val):
	if hp > 0:
		var n = val - (masCha.att.maxHp - masCha.att.hp)
		if n > 0:
			d += hp
			if d > 1500:
				d = 1500
			hp = 0
			info = infos % d as int

func _onHurt(atkInfo):
	if d > 0:
		atkInfo.hurtVal = 0
		d -= atkInfo.atkVal
		if d < 0:
			d = 0
		info = infos % d as int
func _onBattleStart():
	if d > 0:
		d = d*0.7
		info = infos % d as int
