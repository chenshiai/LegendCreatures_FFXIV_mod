extends Talent

func init():
	name = "迷你塔塔露"

func _connect():
	sys.main.connect("onBattleEnd", self, "run")
	
func run():
	player.plusGold(10)

func get_info():
	return "战斗结束后给予玩家10金币\n此天赋不需要提升等级\n塔塔露：“渡渡鸟的大眼珠，软糊怪的血糊糊，食人魔的肠子，一二三四五”。"