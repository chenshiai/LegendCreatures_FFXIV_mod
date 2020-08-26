extends "../LOLItemBase/LOLItemBase.gd"

func _init():
	name = "救赎"
	att.maxHp = 200
	att.cd = 0.1
	info = TEXT.format("""{c_base}{c_skill}唯一·救赎：{/c}为所有队友回复10(+自身等级 x 20)的生命
并所有敌人造成最大生命2%的真实伤害
冷却时间5s（不受冷却缩减影响）{/c}""")


func _onBattleStart():
	STATUS.b_jiushu.new({ "cha": masCha })


