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
  chaName = "极限技"
  attCoe.atkRan = 1
  attCoe.maxHp = 1
  attCoe.atk = 0
  attCoe.mgiAtk = 0
  attCoe.def = 0
  attCoe.mgiDef = 0

func _upS():
  ._upS()
  