func _init():
	config.bfDir["易伤"] = "debuff，不可驱散，携带者受到的伤害增加30%。"
	config.bfDir["物理耐性下降·大"] = "debuff，不可驱散，携带者受到普通攻击的伤害提高99倍。"

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
	"title": "最终幻想14-控制面板说明",
	"content": """使用控制面板可以对战场情况进行微调，只对友方生效，且不包括召唤物。
【上下左右】所有单位向特定方向移动一格。[color=#9cff7d]【W/A/S/D】[/color]
【分散】所有单位分散至场边，且互不相邻。[color=#9cff7d]【R】[/color]
【平行】所有单位移动至场地上下两边。[color=#9cff7d]【T】[/color]
【左/右集】所有单位在场地的 [左/右] 边集合。[color=#9cff7d]【Q/E】[/color]

【退避】优先选择己方场上防御能力最高的角色，使其吸引所有敌人的仇恨，不会被连续集火两次。[color=#9cff7d]【V】[/color]

[color=#ff7e7e]※使用极限技会消耗全部极限技槽[/color]
极限技效果会根据极限槽等级来提升，仅讨伐战、歼灭战有效。
【防护】短时间内给队友减伤，减伤[20%/40%/80%]。[color=#9cff7d]【C】[/color]
【进攻】对敌方单体造成极大伤害，全队攻击总和[1倍/2倍/3倍]的真实伤害。[color=#9cff7d]【X】[/color]
【治疗】为友方单位恢复最大生命的[30%/60%/100%]，三级时附加复活效果。[color=#9cff7d]【Z】[/color]

【讨伐设置】
可以在创意工坊中的《最终幻想14合集》中订阅更多Boss战DLC
在讨伐设置中勾选的讨伐战、歼灭战，将在玩家通关27层后的每一层，随机一个出现。
如若不想挑战，可以把选项全部取消掉。"""
} 

const UpdateInfo = {
	"title": "最终幻想14-更新记录",
	"content": """[color=#64a6b7]【Ver 2.7.1】2020-06-29[/color]
【灵魂水晶】召唤师之证：
每15s对目标附加10层[中毒][流血] -> 每15s对目标及周围一格的敌人附加[瘴暍][剧毒菌]

【神龙幻想歼灭战】
经过反馈，有第二阶段小怪出现数目不完全，导致无法打断大招【原恒星】读条的BUG。
该BUG现已修复。
同时延长了第三阶段的狂暴时间30s，但期间会额外穿插两个小技能和一个死刑。

[color=#64a6b7]【Ver 2.7.0】[/color]
[color=#f6ff00]推出全新的控制器面板，改造游戏玩法。[/color]
Boss讨伐战现在变为可选的模式！并且出场时自带背景音乐！！
原先欧米茄系列Boss的机制比较老旧，F/M正在回炉重造中，电音蟑螂先留着

新增DLC Boss战：
《神龙幻想歼灭战》
任何神话传说中都不存在的神
落入了通过人之手而诞生的超越者手中
超越者操纵着这个可怜的神祇，向弑神的英雄发起了挑战
如果这只是世人创作出来的神话
那么就算再由世人之手添加几分夸张也不应该算是冒渎
边聆听异国的诗人演奏的庄严旋律，光之战士开始了神龙之战的追忆。
"""
} 

const Insurance = {
	"title": "挑战失败",
	"content": """你的小队已经全灭！
BOSS的挑战失败了，无法获得任何奖励。
海德林保住了你。
但是她还能再保护你多久呢......"""
}

const Reward = {
	"title": "挑战成功！",
	"content": """干的漂亮！
BOSS的挑战成功了，光之战士朝着更强的方向又前进了一步。
获得了一颗灵魂水晶！"""
}

const T_RAID = """从此刻开始体验经过夸大的激昂战斗！
可以挑战强大的BOSS单位！！
BOSS战可以使用极限技能！！！
玩家最大生命值提高%d点，所有敌方双攻提高%d%%。
战斗后恢复%d点生命，并额外获得%d金币。
来自《最终幻想14》"""

const T_TEAM = """根据当前上场人数提供额外加成。
轻锐小队：4-7人，己方单位基础面板提高10%。
满编小队：8人及以上，己方单位基础面板提高20%。
[注意]：最大人口数量将被固定为10
来自《最终幻想14》"""

const T_LIGHT = """战斗开始后，己方所有角色双抗提高15%
“海德林的光之信徒啊！随着这黑暗的要塞一起消失吧！” ———— 拉哈布雷亚\n来自《最终幻想14》"""

const BOSS_DEFAULT = "{c_base}[自适应]：该单位属性根据敌方战力自适应调整，拥有特定的技能时间轴。{/c}"

const BOSS_INNOCENCE = """[color=#ffffff]
决定第一世界命运的大决战
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

const BOSS_DRAGON = """[color=#ffffff]
任何神话传说中都不存在的神
落入了通过人之手而诞生的超越者手中
超越者操纵着这个可怜的神祇，向弑神的英雄发起了挑战
如果这只是世人创作出来的神话
那么就算再由世人之手添加几分夸张也不应该算是冒渎
边聆听异国的诗人演奏的庄严旋律，光之战士开始了神龙之战的追忆。[/color]
"""

const testStr = "这是一段很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的测试文案"