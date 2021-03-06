extends "../BaseItem.gd"

const STEP = ["", "·天极", "·魂晶", "·魂灵", "·新星", "·镇魂"]
const EXP_MAX = 20 # 每升一级需要的经验值
const EXP_BAR = "■■■■■■■■■■■■■■■■■■■■□□□□□□□□□□□□□□□□□□□□"

var GROW_START = false # 携带者是否在战斗中
var exp_now = 0 # 当前积累的经验值
var fixed = 2 # 还剩多少次战斗固定随机词条
var Level = 0 # 当前武器的等级
var ItemName = "" # 当前武器的名字
var randAtt = [] # 随机词条数组

var Skill_info = ""
var Infomation = TEXT.format("""说明：
传说中的上古武器之一，携带此装备战斗可以使武器属性成长
上古武器拥有两条{c_base}固定词条{/c}和两条{c_base}随机词条{/c}
{c_base}随机词条{/c}需要装备在角色身上才会显示
携带者不战斗，则战斗结束会刷新随机词条
携带者{c_base}连续完成两次战斗{/c}既可锁定随机词条
来自《最终幻想14》""")

signal randomAtt
signal updateAtt

func _getEpilogue(over = false):
	var Exp_progress = EXP_BAR.substr(20 - exp_now, 20) # 当前进度显示
	if over:
		Exp_progress = "该装备的成长已到达最后阶段"
	else:
		Exp_progress = "当前进度\n%s" % Exp_progress

	var Epilogue = """{skill_info}
{progress}
{infomation}""".format({
		"skill_info": Skill_info,
		"progress": "%s" % [Exp_progress],
		"infomation": Infomation
	})
	return Epilogue


func _onBattleStart():
	if sys.main.btChas.has(masCha):
		GROW_START = true

func _onBattleEnd():
	if !GROW_START and fixed != 0:
		fixed = 2
		emit_signal("randomAtt")
	elif fixed > 0:
		fixed -= 1
	GROW_START = false

func _onCharaDel(cha):
	if Level == 5:
		exp_now = 20
	if GROW_START and Level < 5 and cha.team == 2:
		match cha.lv:
			1:
				exp_now += 1
			2:
				exp_now += 2
			3:
				exp_now += 3
			4:
				exp_now += 4

		if exp_now >= EXP_MAX:
			Level += 1
			exp_now -= EXP_MAX
			name = ItemName % [STEP[Level]]
			emit_signal("updateAtt")

		if Level == 5:
			info = _getEpilogue(true)
		else:
			info = _getEpilogue()

func _randomAtt(ban1, ban2):
	var AllAtt = [
		{
			"attr": "maxHp",
			"range": [150, 300],
			"up": [20, 50]
		},
		{
			"attr": "atk",
			"range": [20, 50],
			"up": [5, 15]
		},
		{
			"attr": "def",
			"range": [15, 40],
			"up": [5, 15]
		},
		{
			"attr": "atkRan",
			"range": [1, 2],
			"up": [0, 0]
		},
		{
			"attr": "mgiAtk",
			"range": [15, 60],
			"up": [5, 15]
		},
		{
			"attr": "mgiDef",
			"range": [20, 50],
			"up": [5, 15],
		},
		{
			"attr": "pen",
			"range": [10, 30],
			"up": [1, 3],
		},
		{
			"attr": "mgiPen",
			"range": [10, 30],
			"up": [1, 3],
		},
		{
			"attr": "defL",
			"range": [0.1, 0.2],
			"up": [0.01, 0.03],
		},
		{
			"attr": "penL",
			"range": [0.1, 0.2],
			"up": [0.01, 0.03],
		},
		{
			"attr": "criR",
			"range": [0.1, 0.3],
			"up": [0.01, 0.03],
		},
		{
			"attr": "cri",
			"range": [0.05, 0.1],
			"up": [0.01, 0.03],
		},
		{
			"attr": "suck",
			"range": [0.05, 0.1],
			"up": [0.01, 0.03],
		},
		{
			"attr": "mgiSuck",
			"range": [0.05, 0.1],
			"up": [0.01, 0.03],
		},
		{
			"attr": "reHp",
			"range": [0.1, 0.2],
			"up": [0.01, 0.03],
		},
		{
			"attr": "spd",
			"range": [0.15, 0.3],
			"up": [0.01, 0.03],
		},
		{
			"attr": "cd",
			"range": [0.05, 0.1],
			"up": [0.01, 0.03],
		},
		{
			"attr": "dod",
			"range": [0.1, 0.2],
			"up": [0.01, 0.03],
		},
		{
			"attr": "maxHpL",
			"range": [0.05, 0.1],
			"up": [0.01, 0.03],
		},
		{
			"attr": "atkL",
			"range": [0.05, 0.2],
			"up": [0.01, 0.03],
		},
		{
			"attr": "mgiAtkL",
			"range": [0.05, 0.2],
			"up": [0.01, 0.03],
		},
		{
			"attr": "mgiDefL",
			"range": [0.1, 0.2],
			"up": [0.01, 0.03],
		},
		{
			"attr": "mgiPenL",
			"range": [0.1, 0.2],
			"up": [0.01, 0.03],
		},
	]
	# 将上一次的随机词条清除
	for item in randAtt:
		att[item.attr] = 0
	randAtt = []

	# 找出已有的词条
	for item in AllAtt:
		if item.attr == ban1 or item.attr == ban2:
			randAtt.append(item)

	# 删除已有的词条(不在上面删除是因为，遍历的同时删除会导致下标错误)
	for item in randAtt:
		AllAtt.erase(item)
	randAtt = []

	# 随机选取两条不重复词条
	for n in range(2):
		var att1 = sys.rndListItem(AllAtt)
		randAtt.append(att1)
		AllAtt.erase(att1)

	# 将随机词条附加到att上
	for item in randAtt:
		att[item.attr] = rand_range(item.range[0], item.range[1])