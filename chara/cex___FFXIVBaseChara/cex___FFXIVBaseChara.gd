extends Chara
const BUFF_LIST = globalData.infoDs["g_FFXIVBuffList"]
const Utils = globalData.infoDs["g_aFFXIVUtils"]
const OCCUPATION = ["protect", "attack", "treatment"]

func _info():
  pass

func _ready():
  pass

func _connect():
  ._connect()

func _extInit():
  ._extInit()
  chaName = "基础角色"
  attCoe.atkRan = 1
  attCoe.maxHp = 1
  attCoe.atk = 1
  attCoe.mgiAtk = 1
  attCoe.def = 1
  attCoe.mgiDef = 1

func _upS():
  ._upS()
  