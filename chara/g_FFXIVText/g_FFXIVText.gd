func format(text, config = {}):
  var Text = text.format(self.Config)
  return Text.format(config)

var Config = {
  "TItemSoul": "[color=#f6ff00][灵魂水晶][/color]",
  "TMgiHurt": "[color=%s]魔法伤害[/color]" % [COLOR.MGI],
  "TPhyHurt": "[color=%s]物理伤害[/color]" % [COLOR.PHY],
  "TRealHurt": "[color=%s]真实伤害[/color]" % [COLOR.REAL],
  "TPassive": "[color=%s]被动[/color]" % [COLOR.PASSIVE]
}

const COLOR = {
  "PHY": "#ff7522",
  "MGI": "#00e4ff",
  "PASSIVE": "#e5e5e5",
  "REAL": "#ffffff"
}

const BOSS_INNOCENCE = """[color=#ffffff]
决定第一世界命运的大决
也就是在格鲁格火山顶部的沃斯里宫殿——完璧王座的战斗
传进了异世界的诗人的耳朵里，他再次用夸张的修饰创造出了新的诗歌
这将会成为新世界的圣典吗？
总感觉像是看到了捏造神话的瞬间……[/color]
"""

const BOSS_OMEGA = """[color=#ffffff]
恭喜，你们合格了
你们确实地、明确地证明了自己是距离欧米茄最遥远的……
阿尔法级别的弱者[/color]
"""
