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
	"c_balance": "[color=%s]" % [COLOR.BALANCE],
	"c_arrow": "[color=%s]" % [COLOR.ARROW],
	"c_spear": "[color=%s]" % [COLOR.SPEAR],
	"c_bole": "[color=%s]" % [COLOR.BOLE],
	"c_ewer": "[color=%s]" % [COLOR.EWER],
	"c_spire": "[color=%s]" % [COLOR.SPIRE],
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
	"DEATH": "#ff7e7e",
	"BALANCE": "#ff4848",
	"ARROW": "#86d1f4",
	"SPEAR": "#8693f4",
	"BOLE": "#80f87d",
	"EWER": "#229fff",
	"SPIRE": "#fcda72"
}

const Instructions = {
	"title": "控制面板说明",
	"content": """使用控制面板可以对战场情况进行微调，只对友方生效，且不包括召唤物。

【上下左右】所有单位向特定方向移动一格。
【分散】所有单位分散至场边，且互不相邻。
【平行】所有单位移动至场地上下两边。
【左/右集】所有单位在场地的 [左/右] 边集合。

【退避】优先选择己方场上防御能力最高的角色，使其吸引所有敌人的仇恨，不会被连续集火两次。

※使用极限技会消耗全部极限技槽，会根据极限槽等级来提升效果。
【防护】短时间内给队友减伤，减伤[20%/40%/80%]
【进攻】对敌方单体造成极大伤害，全队攻击总和[1倍/2倍/3倍]的真实伤害
【治疗】为友方单位恢复生命值，最大生命的[30%/60%/100%]，三级时附加复活效果。"""
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