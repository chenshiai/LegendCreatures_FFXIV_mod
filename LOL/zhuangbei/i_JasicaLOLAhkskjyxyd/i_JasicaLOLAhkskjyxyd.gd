extends "../LOLItemBase/LOLItemBase.gd"


func _init():
	name = TEXT.format("{c_base}海克斯科技原型腰带{/c}")
	att.maxHp = 300
	att.mgiAtk = 60
	att.mgiSuck = 0.2
	att.cd = 0.1
	info = TEXT.format("{c_base}战斗开始后，第一次攻击将闪烁到敌人最后一排并对每个前排敌人造成{c_mgi}150(+25% x 法强){/c}的魔法伤害{/c}")
	

func _connect():
	masCha.connect("onAtkChara", self, "run")
	sys.main.connect("onBattleEnd", self, "run1")


var bl = true
var vs = [
	Vector2(0, 0), Vector2(1, 0), Vector2(-1, 0),
	Vector2(0, 1), Vector2(0, -1), Vector2(1, 1),
	Vector2(-1,1), Vector2(-1, -1), Vector2(1, -1)
]


func run1():
	bl = true


func run(atkInfo):
	if bl:
		bl = false
		var mv = masCha.cell
		if masCha.team == 1:
			mv.x = 9
		else:
			mv.x = 0

		var chas = Lol.get_area_chas("custom", Vector2(3, 0), Vector2(6, 5))
		for cha in chas:
			if cha.team != masCha.team:
				masCha.hurtChara(cha, 150 + masCha.att.mgiAtk * 0.25, MGI, EFF)

		for i in vs:
			var v = mv + i
			if masCha.matCha(v) == null && sys.main.isMatin(v):
				if masCha.setCell(v) :
					var pos = sys.main.map.map_to_world(masCha.cell)
					Lol.draw_shadow(masCha.img, masCha.position, pos, 40)
					masCha.position = pos
					masCha.aiCha = null
					break
