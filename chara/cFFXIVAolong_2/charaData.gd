static func getCharaData():
  var name_1 = "武士"
  var name_2 = "无双之士"
  var name_3 = "无双斋-传奇"

  var meterage = ""

  var SKILL_TEXT = """[雪/月/花]：{TPassive}攻击力提升10%，攻速提升10%，技能可以产生暴击。每次攻击随机获得[雪][月][花]印记
[居合术]：每第6次攻击后的第7次攻击将发动[纷乱雪月花]
[纷乱雪月花]：对目标造成[250%][360%][800%]的{TPhyHurt}，印记种类越多伤害越高"""

  var SKILL_TEXT_1 = """[燕回返]：冷却14s，发动上一次使用的居合术，并且使伤害提高50%"""

  var SKILL_TEXT_2 = "[照破]：{TPassive}释放[居合术]后累计一层剑压，达到三层后对目标造成[400%]的{TPhyHurt}"

  return {
    "name_1": name_1,
    "name_2": name_2,
    "name_3": name_3,
    "meterage": meterage,
    "SKILL_TEXT": SKILL_TEXT,
    "SKILL_TEXT_1": SKILL_TEXT_1,
    "SKILL_TEXT_2": SKILL_TEXT_2
  }