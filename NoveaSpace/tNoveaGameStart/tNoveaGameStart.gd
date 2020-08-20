extends Talent
var Novea = globalData.infoDs["gNoveaUtils"]
var TEXT = globalData.infoDs["gNoveaText"]


func init():
	name = "诺维亚，起航！！"


func _connect():
  pass


func get_info():
	return "学习此天赋，玩家立即获得一艘飞船，并开启星空探索之旅。\n来自《Novea》"