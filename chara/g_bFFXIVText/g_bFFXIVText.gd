func format(text, config = {}):
  var Text = text.format(self.Config)
  return Text.format(config)

var Config = {
  "TItemSoul": "[color=#f6ff00][灵魂水晶][/color]",
  "TMgiHurt": "[color=%s]魔法伤害[/color]" % [COLOR.MGI],
  "TPhyHurt": "[color=%s]物理伤害[/color]" % [COLOR.PHY],
  "TRealHurt": "[color=%s]真实伤害[/color]" % [COLOR.REAL],
  "TPassive": "[color=%s]被动[/color]" % [COLOR.PASSIVE],
  "TProtect": "[color=%s]防护[/color]" % [COLOR.PROTECT],
  "TAttack": "[color=%s]进攻[/color]" % [COLOR.ATTACK],
  "TTreatment": "[color=%s]治疗[/color]" % [COLOR.TREATMENT],
}

const COLOR = {
  "PHY": "#ff7522",
  "MGI": "#00e4ff",
  "PASSIVE": "#e5e5e5",
  "REAL": "#ffffff",
  "PROTECT": "#00b4ff",
  "ATTACK": "#ff0909",
  "TREATMENT": "#43ff09"
}

const LimitBreakInfomation = {
  "title": "极限技说明",
  "content": """极限技（Limit Break，简称LB）是全队齐心协力积攒的，可以扭转战局的绝招。

  极限技目前可以分为三种效果：
  【防护】短时间内给队友减伤，根据极限技等级提高减伤效果；
  【进攻】对敌方单体造成极大伤害，根据极限技等级提高伤害；
  【治疗】为队友恢复体力，根据极限技等级提高回复。
  
  当前版本在天赋左边有三个对应的按钮，当极限槽攒满时即可使用。
  使用时会根据已攒满的极限槽数量释放相应等级的极限技，使用后会清空全部极限槽。"""
} 

const Retreat = {
  "title": "退避说明",
  "content": """选择玩家双防较高的两名单位作为[坦克]
点击[退避]按钮后，会转移所有敌人的仇恨到其中一个[坦克]身上。
若两名[坦克]都阵亡，[退避]将无法生效！
提示：被转移仇恨的目标头上会出现红色感叹号[!]"""
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
const testStr = "这是一段很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的测试文案"