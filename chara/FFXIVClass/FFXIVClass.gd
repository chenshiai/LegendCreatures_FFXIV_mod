extends "./BaseClass.gd"

var Chant
var Keyboard
var FFControl
var FFMusic
var BossHpBar
var LimitBreak

func Classload(gdname):
  return load("%s/FFXIVClass/%s/%s.gd" % [Utils.Path, gdname, gdname])

# 在这里统一导出FFXIVClass
func _init():
  Chant = Classload("Chant")
  Keyboard = Classload("Keyboard")
  FFControl = Classload("Control")
  FFMusic = Classload("musicControl")
  BossHpBar = Classload("BossHpBar")
  LimitBreak = Classload("LimitBreak")