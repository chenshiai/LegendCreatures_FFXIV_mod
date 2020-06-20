func format(text, config = {}):
  var Text = text.format(self.Config)
  return Text.format(config)

var Config = {
  "c_base": "[color=%s]" % [COLOR.BASE],
  "c_buff": "[color=%s]" % [COLOR.BUFF],
  "c_mgi": "[color=%s]" % [COLOR.C_MGI],
  "c_phy": "[color=%s]" % [COLOR.C_PHY],
  "c_pas": "[color=%s]" % [COLOR.PASSIVE],
  "c_Tmgi": "[color=%s]" % [COLOR.MGI],
  "c_Tphy": "[color=%s]" % [COLOR.PHY],
  "/c": "[/color]",
  "TItemSoul": "[color=#f6ff00][灵魂水晶][/color]",
  "TDeath": "[color=%s]死刑！！[/color]" % [COLOR.DEATH],
  "TMgiHurt": "[color=%s]魔法伤害[/color]" % [COLOR.MGI],
  "TPhyHurt": "[color=%s]物理伤害[/color]" % [COLOR.PHY],
  "TRealHurt": "[color=%s]真实伤害[/color]" % [COLOR.REAL],
  "TPassive": "[color=%s]『被动』[/color]" % [COLOR.PASSIVE],
  "TProtect": "[color=%s]防护[/color]" % [COLOR.PROTECT],
  "TAttack": "[color=%s]进攻[/color]" % [COLOR.ATTACK],
  "TTreatment": "[color=%s]治疗[/color]" % [COLOR.TREATMENT]
}

const COLOR = {
  "BASE": "#eeeeee",
  "BUFF": "#fff66e",
  "PHY": "#ff7522",
  "C_PHY": "#ffb386",
  "MGI": "#00e4ff",
  "C_MGI": "#83f2ff",
  "PASSIVE": "#a9a9a9",
  "REAL": "#ffffff",
  "PROTECT": "#79d8ff",
  "ATTACK": "#ff7e7e",
  "TREATMENT": "#9cff7d",
  "DEATH": "#ff7e7e"
}

const LimitBreakInfomation = {
  "title": "极限技说明",
  "content": """极限技（Limit Break，简称LB）是全队齐心协力积攒的，可以扭转战局的绝招。

  极限技目前可以分为三种效果：
  【防护】短时间内给队友减伤，根据极限技等级提高减伤效果；
  【进攻】对敌方单体造成极大伤害，根据极限技等级提高伤害；
  【治疗】为友方单位恢复生命值，根据极限技等级提高恢复量，三级时附加复活效果。
  
  当前版本在天赋左边有三个对应的按钮，当极限槽攒满时即可使用。
  使用时会根据已攒满的极限槽数量释放相应等级的极限技，使用后会清空全部极限槽。"""
} 

const Retreat = {
  "title": "退避说明",
  "content": """退避是用来转移敌人的仇恨的操作。
点击[退避]按钮后，会转移所有敌人的仇恨到一个人身上。
[退避]会优先选择己方场上防御能力最高的角色。
同一个角色不会连续被集火两次。
提示：被转移仇恨的目标头上会出现红色感叹号[!]"""
}

const T_RAID = """从此刻开始体验经过夸大的激昂战斗！
有概率出现强大的BOSS单位！！
BOSS战可以使用极限技能了！！！
玩家最大生命值提高%d点，所有敌方双攻提高%d%%。
战斗后恢复%d点生命，并额外获得%d金币。
来自《最终幻想14》"""

const T_TEAM = """根据当前上场人数提供额外加成。
轻锐小队：4-7人，己方单位基础面板提高%d%%。
满编小队：8人及以上，己方单位基础面板提高%d%%。
[注意]：最大人口数量将被固定为10
来自《最终幻想14》"""

const T_LIGHT = """战斗开始后，己方所有角色双抗提高 %d%%
“海德林的光之信徒啊！随着这黑暗的要塞一起消失吧！” ———— 拉哈布雷亚\n来自《最终幻想14》"""

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