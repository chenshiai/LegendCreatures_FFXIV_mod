func _ready():
  pass

func _init():
  print("最终幻想14配置加载中······")
  pass

func _connect():
  pass

func createCommonBuff():
  return b_test.new() 

class b_test:
  extends Buff
  func _init():
    attInit()
    id = "b_test"
    att.atk = 1000