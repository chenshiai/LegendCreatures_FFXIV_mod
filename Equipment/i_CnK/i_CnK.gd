extends "../BaseFlower/BaseFlower.gd"
func init():
    name = "慈悲/慈爱"
    type = config.EQUITYPE_EQUI
    attInit()
    att.mgiAtk = 22
    att.atk = 22
    att.spd = 0.22
    att.cri = 0.22
    info ="[color=#C0C0C0]蓝睡莲-花语：纯洁[/color]\n无视所有负面效果"
func _connect():
    sys.main.connect("onBattleStart",self,"check")
    masCha.connect("onAddBuff",self,"run")

func run(buff):
    if buff.isNegetive :
        buff.isDel = true
        if agony == 1:
            masCha.plusHp(masCha.att.maxHp * 0.002)
        if heartbroke == 1:
            masCha.plusHp(masCha.att.maxHp * 0.002)
        if rebirth == 1:
            masCha.plusHp(masCha.att.maxHp * 0.002)
        if pure == 1:
            masCha.plusHp(masCha.att.maxHp * 0.004)
        if greed == 1:
            masCha.plusHp(masCha.att.maxHp * 0.002)
        if stink == 1:
            masCha.plusHp(masCha.att.maxHp * 0.001)
        if fade == 1:
            masCha.plusHp(masCha.att.maxHp * 0.002)
        if gental == 1:
            masCha.plusHp(masCha.att.maxHp * 0.002)
        if beauty == 1:
            masCha.plusHp(masCha.att.mgiAtk * 0.05)
        if heritage == 1:
            masCha.plusHp(masCha.att.maxHp * 0.002)

func check():
    info ="[color=#C0C0C0]蓝睡莲-花语：纯洁[/color]\n无视所有负面效果"
    for i in masCha.items:
        if i.name == "哀嚎耳环":
            agony = 1
            info += "\n悲叹：被附加负面效果时恢复0.2%最大生命值"          
        else:
            agony = 0
        if i.name == "情变":
            heartbroke = 1
            info += "\n失情：被附加负面效果时恢复0.2%最大生命值"          
        else:
            heartbroke = 0
        if i.name == "绝境突矛":
            rebirth = 1
            info += "\n重生：被附加负面效果时恢复0.2%最大生命值"          
        else:
            rebirth = 0
        if i.name == "慈悲/慈爱":
            pure = 1
            info += "\n纯洁：被附加负面效果时恢复0.4%最大生命值"          
        else:
            pure = 0
        if i.name == "贪欲大剑":
            greed = 1
            info += "\n贪婪：被附加负面效果时恢复0.2%最大生命值"          
        else:
            greed = 0
        if i.name == "不可思议天狗面":
            stink = 1
            info += "\n表里不一：被附加负面效果时恢复0.1%最大生命值"          
        else:
            stink = 0
        if i.name == "虚无三尖枪":
            fade = 1
            info += "\n消逝：被附加负面效果时恢复0.2%最大生命值"          
        else:
            fade = 0
        if i.name == "温和拳刃":
            gental = 1
            info += "\n温柔：被附加负面效果时恢复0.2%最大生命值"          
        else:
            gental = 0
        if i.name == "自由之心":
            beauty = 1
            info += "\n美人：被附加负面效果时恢复5%魔攻最大生命值"          
        else:
            beauty = 0
        if i.name == "教育名册":
            heritage = 1
            info += "\n传承：被附加负面效果时恢复0.2%最大生命值"          
        else:
            heritage = 0