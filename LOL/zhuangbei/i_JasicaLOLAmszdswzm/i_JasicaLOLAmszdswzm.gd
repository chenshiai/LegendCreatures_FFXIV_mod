extends "../LOLItemBase/LOLItemBase.gd"

func _init():
  name = "灭世者的死亡之帽"
  att.mgiAtk = 150
  info = TEXT.format("{c_base}{c_skill}唯一被动：{/c}战斗开始后，魔法强度提升40%{/c}")

func _onBattleStart():
  STATUS.b_mieshizhe.new({"cha": masCha})
        
