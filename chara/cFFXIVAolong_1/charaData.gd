static func getCharaData():
  var name_1 = "暗黑骑士"
  var name_2 = "深渊之暗"
  var name_3 = "希德勒格-传奇"

  var meterage = "暗黑值：%d / 700"

  var SKILL_TEXT = """[深恶痛绝]：{TPassive}战斗开始时，魔法防御提高10%，受到的伤害减少20%
[噬魂斩]：{TPassive}第三次普通攻击造成[110%]的伤害，并恢复自身5%的HP
[血溅]：冷却10s，对目标造成[290%]的{TPhyHurt}"""

  var SKILL_TEXT_1 = """[至黑之夜]：造成非特效伤害时会累计暗黑值，达到700点时，释放可以吸收最大生命值20%伤害的护盾
[暗黑布道]：冷却12s，使队伍全员受到的{TMgiHurt}减少10%，持续6s"""

  var SKILL_TEXT_2 = "[掠影示现]：{TPassive}令英雄的掠影变为实体与自身并肩作战，与本体同步攻击，造成本体的[30%]的伤害，自身最大生命值提高"

  return {
    "name_1": name_1,
    "name_2": name_2,
    "name_3": name_3,
    "meterage": meterage,
    "SKILL_TEXT": SKILL_TEXT,
    "SKILL_TEXT_1": SKILL_TEXT_1,
    "SKILL_TEXT_2": SKILL_TEXT_2
  }