extends "../LOLItemBase/LOLItemBase.gd"

var skillInfo = """{c_base}提供单位100%的基础攻击力
{c_skill}救主灵刃：{/c}5秒内受到15%最大生命值以上伤害时，获得40%最大生命值的护盾(冷却时间：20秒)
护盾会在5s内持续衰减{/c}"""

const cd = 20
var nowTime = 0
var open = true


var aTime = 0 # 伤害累积时间
var aHurt = 0 # 累积伤害
var aOpen = false # 累积开关

func _init():
	name = "斯特拉克的挑战护手"
	att.maxHp = 450
	info = TEXT.format(skillInfo)

func _connect():
	._connect()
	att.atk = (masCha.attCoe.atk * 8.5 * masCha.lv) as int


func _onBattleStart():
	nowTime = 0
	open = true
	aTime = 0 # 伤害累积时间
	aHurt = 0 # 累积伤害
	aOpen = false # 累积开关

func _upS():
	# 技能冷却计时器
	if !open:
		print("进入冷却")
		nowTime += masCha.att.cd + 1
		if nowTime >= cd:
			open = true

	# 伤害累积计时器
	if aOpen:
		aTime += 1
		nowTime = 0
		print("开启累计")
		# 伤害累积开启5秒后自动关闭累积
		if aTime >= 5:
			aTime = 0
			aHurt = 0
			aOpen = false

func _onHurt(atkInfo:AtkInfo):
	# 如果伤害累积未开始，则开始累积计时器
	if !aOpen and open:
		aOpen = true
	else:
		aHurt += atkInfo.hurtVal
		if aHurt >= masCha.att.maxHp * 0.15 and open:
			aOpen = false # 关闭伤害累积计时器
			open = false # 关闭技能冷却计时器
			print("触发护盾")
			STATUS.b_tiaozhanhushou.new({
				"cha": masCha,
				"dur": 5,
				"HD": masCha.att.maxHp * 0.40,
			})
