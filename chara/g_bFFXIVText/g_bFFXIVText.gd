func _init():
	config.bfDir["易伤"] = "debuff，不可驱散，携带者受到的伤害增加30%。"
	config.bfDir["物理耐性下降·大"] = "debuff，不可驱散，携带者受到普通攻击的伤害提高99倍。"
	config.bfDir["瘴暍"] = "debuff，可驱散，携带者每秒受到释放者法强5%的魔法伤害。"
	config.bfDir["剧毒菌"] = "debuff，可驱散，携带者每秒受到释放者法强5%的魔法伤害。"
	config.bfDir["螺旋气流"] = "debuff，可驱散，携带者每秒受到释放者法强5%的魔法伤害。"

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
	"c_pro": "[color=%s]" % [COLOR.PROTECT],
	"c_atk": "[color=%s]" % [COLOR.ATTACK],
	"c_tre": "[color=%s]" % [COLOR.TREATMENT],
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

const BOSS_LIVING_LIQUID = """[color=#ffffff]
Our world's is a fantasy， no more than a test.
——我们的世界是一个空想，不只是测试的产物。[/color]
"""

var UpdateInfo = {
	"title": "最终幻想14-更新记录",
	"content": format("""[color=#64a6b7]【Ver 2.8.1】2020-07-05[/color]
实装上古武器
【无锋剑柯塔纳】【神圣盾】【释法来】【勇悍斧】【穿心枪盖博尔格】
【月神之弓】【酒神杖】【星辰杖】【绿瞳列传】【万辞全书】【吉光】
获取方式：
学习天赋 Rain作战记录 后，战斗结束有概率获得随机一件上古武器

[color=#64a6b7]【Ver 2.8.0】2020-07-04[/color]
{c_pro}【战士】{/c}{c_pas}战士不再需要较长时间的热身了{/c}
[战栗] 冷却时间 20s -> 10s，回复量 最大生命值的20% -> 10%

{c_pro}【暗黑骑士】{/c}{c_pas}至黑之夜是个强力的护盾{/c}
[至黑之夜] 释放所需要的暗黑值 1000 -> 700，同时暗黑值的获取量降低

{c_pro}【绝枪战士】{/c}{c_pas}绝枪战士的出现可能让人非常头疼，特别是在电脑方{/c}
[血壤] 移除
[续剑] 新增：普通攻击附带35%攻击力的魔法伤害
[超火流星] 玩家方发动几率为100%，电脑方发动几率为40%，持续时间 10s -> 8s
[爆破领域] 冷却时间 15s -> 10s

{c_atk}【武士】{/c}{c_pas}修复了武士打不出雪月花的BUG{/c}
[纷乱雪月花] 伤害系数 [150%/350%/720%] -> [250%/360%/800%]
[燕回返] 伤害提升50%

{c_atk}【忍者】{/c}
过去忍者的技能机制表现并不出色，现已完全重做

{c_atk}【舞者】{/c}{c_pas}为了让更多的人欣赏舞者的舞姿{/c}
[标准舞步]作用范围 3格 -> 4格
[防守之桑巴] 新增，战斗开始时对所有队友附加[防守之桑巴]效果，使受到的伤害减少10%

{c_atk}【召唤师】{/c}{c_pas}召唤兽是以太构成的，怎么可能被打死呢{/c}
[伊芙利特之灵][迦楼罗之灵][泰坦之灵] 重做

{c_atk}【吟游诗人】{/c}{c_pas}远敏的特殊职能之一{/c}
[贤者的叙事谣] 攻击伤害加成 8% -> 5% 冷却时间 13s -> 16s
[行吟] 新增，战斗开始时对所有队友附加[行吟]效果，使受到的伤害减少10%
[光阴神的礼赞凯歌] 移除
[大地神的抒情恋歌] 新增，对生命值比例最低的队友释放，使其受到的治疗效果提高20%
[辉煌箭] 不再是提高普通攻击的伤害，而是单独作为技能释放
[绝峰箭] 从3级角色迁移到4级角色，攻击系数 200% -> 400%
[和平颂歌] 移除

{c_atk}【机工士】{/c}{c_pas}机工士的表现可能没什么特点，对他进行了关照{/c}
[枪管加热] 移除
[野火] 现在野火期间即使不进行攻击，也有 200% 的基础伤害系数，开局就可以释放一次
[策动] 新增，战斗开始时对所有队友附加[策动]效果，使受到的伤害减少10%
[整备] 新增，增加30%的暴击率，且技能可以产生暴击

{c_atk}【赤魔法师】{/c}{c_pas}这么久的BUG，真是抱歉{/c}
[抗争之力] 技能实际效果与技能说明不符，现已修改文案
修复了 升级到传奇后无法继续使用[赤核爆/赤神圣] 的BUG

{c_atk}【龙骑士】{/c}{c_pas}龙骑现在可以更好的刺杀对应的目标{/c}
[坠星冲] 现在技能释放完毕后，自身的仇恨目标会变为攻击目标。
[战斗连祷] 新增，战斗开始后使所有队友暴击率提高10%，不可叠加

{c_tre}【白魔法师】{/c}{c_pas}首席治疗师依旧{/c}
[医济] 治疗系数 60% -> 50%
[崩石] 更名为 [闪耀] 伤害系数 90% -> 100%

{c_tre}【学者】{/c}{c_pas}在大多数情况下，学者的光辉盖住了白魔法师，{/c}
[鼓舞激励之策] 治疗系数 110% -> 60%
[士高气昂之策] 治疗系数 100% -> 50%
[仙光的拥抱] 移除
[死炎法] 新增。对目标造成90%法强的魔法伤害，冷却4s
实装 小仙女

{c_tre}【占星术士】{/c}{c_pas}请专注卡牌分类{/c}
[阳星相位-白昼学派] 冷却时间18s -> 16s，持续恢复效果治疗系数 15% -> 10%，持续时间 8s -> 5s
[煞星] 新增。对目标造成70%法强的魔法伤害，冷却4s
[星位合图] 法强提升 20% -> 10%

【灵魂水晶】黑魔法师之证：
[天语] 伤害增加系数 [5%/10%/15%] -> [15%/20%/25%]


[color=#64a6b7]【Ver 2.7.1】2020-06-29[/color]
【灵魂水晶】召唤师之证：
每15s对目标附加10层[中毒][流血] -> 每15s对目标及周围一格的敌人附加[瘴暍][剧毒菌]

【神龙幻想歼灭战】
经过反馈，有第二阶段小怪出现数目不完全，导致无法打断大招【原恒星】读条的BUG。
该BUG现已修复。
同时延长了第三阶段的狂暴时间30s，但期间会额外穿插两个小技能和一个死刑。
""")
}