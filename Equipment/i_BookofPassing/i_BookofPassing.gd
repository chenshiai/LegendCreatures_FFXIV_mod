extends "../BaseFlower/BaseFlower.gd"
func init():
    name = "教育名册"
    type = config.EQUITYPE_EQUI
    attInit()
    att.atk = 0
    att.mgiAtk = 0
    att.maxHp = 0
    att.def = 0
    att.mgiDef = 0
    att.suck = 0.01
    att.mgiSuck = 0.01
    att.reHp = 0.01
    att.spd = 0.01
    att.criR = 0.01
    info ="[color=#C0C0C0]矢车菊-花语：传承[/color]\n该装备会成长，成长的属性根据不同的花骑士装备有变化"
func _connect():
    sys.main.connect("onBattleStart",self,"check")
    masCha.connect("onAtkChara",self,"attack")
    masCha.connect("onHurt",self,"def")
    masCha.connect("onPlusHp",self,"heal")
    masCha.connect("onDeath",self,"death")

var stacked = 1
var stackee = 1
var counter = 0
var counter0 = 0
var counter1 = 0
var counter2 = 0
var counter3 = 0
var counter4 = 0
func attack(atkInfo:AtkInfo):
    if atkInfo.atkType == Chara.AtkType.NORMAL:
        counter += 1
        counter0 += 1
        if counter >= (stacked/50 + 1):
            if agony == 1:
                att.atk += 2
                att.mgiAtk += 2
                stacked += 1
            if greed == 1:
                att.atk += 3
                stacked += 1
            counter = 0
        if heritage == 1 && counter0 >= (stackee/20 + 1):
            att.atk += 1
            att.mgiAtk += 1
            att.maxHp += 1
            att.def += 1
            att.mgiDef += 1
            stackee += 1
            counter0 = 0
    if atkInfo.atkType == Chara.AtkType.SKILL:
        counter1 += 1
        if counter1 >= (stacked/50 + 1):
            if heartbroke == 1:
                att.atk += 1
                att.spd += 0.0025
                stacked += 1
            if beauty == 1:
                att.mgiAtk += 2
                stacked += 1
            counter1 = 0  
    if atkInfo.isCri:    
        counter4 += 1
        if gental == 0 && counter4 >= (stacked/50 + 1):
            att.criR = 0.001
            stacked += 1
            counter4 = 0 

func def(atkInfo:AtkInfo):
    counter3 += 1
    if counter3 >= (stacked/50 + 1):
        if stink == 1:
            att.suck += 0.0001
            att.mgiSuck += 0.0001
            stacked += 1
        if fade == 1:
            att.def += 1
            att.mgiDef += 1
            stacked += 1
        counter3 = 0

func death(atkInfo):
    if rebirth == 1:
        att.maxHp += 20
        att.def = 10
        att.mgiDef = 10
        stacked += 1

func heal(val):
    counter2 += 1
    counter0 += 1
    if pure == 1 && counter >= (stacked/50 + 1):
        att.reHp += 0.01
        stacked += 1
        counter2 = 0
    if heritage == 1 && counter0 >= (stackee/30 + 1):
        att.atk += 1
        att.mgiAtk += 1
        att.maxHp += 1
        att.def += 1
        att.mgiDef += 1
        stackee += 1
        counter0 = 0    

func check():
    info ="[color=#C0C0C0]矢车菊-花语：传承[/color]\n该装备会成长，成长的属性根据不同的花骑士装备有变化"
    for i in masCha.items:
        if i.name == "哀嚎耳环":
            agony = 1
            info += "\n悲叹：一定次数普通攻击后增加2点双攻，次数会随着装备成长增加"  
        else:
            agony = 0
        if i.name == "情变":
            heartbroke = 1
            info += "\n失情：一定次数释放技能后增加1点攻击，0.25%攻速，次数会随着装备成长增加"    
        else:
            heartbroke = 0
        if i.name == "绝境突矛":
            rebirth = 1
            info += "\n重生：死亡时增加20点生命，10点双防"          
        else:
            rebirth = 0
        if i.name == "慈悲/慈爱":
            pure = 1
            info += "\n纯洁：回复生命一定次数后增加1%回复，次数会随着装备成长增加"          
        else:
            pure = 0
        if i.name == "贪欲大剑":
            greed = 1
            info += "\n贪婪：一定次数普通攻击后增加3点攻击，次数会随着装备成长增加"          
        else:
            greed = 0
        if i.name == "不可思议天狗面":
            stink = 1
            info += "\n表里不一：被攻击一定次数增加0.01%双吸，次数会随着装备成长增加"          
        else:
            stink = 0
        if i.name == "虚无三尖枪":
            fade = 1
            info += "\n消逝：一定次数普通攻击后增加2点双防，次数会随着装备成长增加"          
        else:
            fade = 0
        if i.name == "温和拳刃":
            gental = 1
            info += "\n温柔：一定次数暴击后增加暴击倍率，次数会随着装备成长增加"          
        else:
            gental = 0
        if i.name == "自由之心":
            beauty = 1
            info += "\n美人：一定次数释放技能后增加3点魔攻，次数会随着装备成长增加"          
        else:
            beauty = 0
        if i.name == "教育名册":
            heritage = 1
            info += "\n传承：一定次数攻击或者被治疗后后增加1点四维和生命值，次数会随着装备成长增加"          
        else:
            heritage = 0

