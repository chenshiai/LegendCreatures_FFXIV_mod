extends "../BaseFlower/BaseFlower.gd"
func init():
    name = "温和拳刃"
    type = config.EQUITYPE_EQUI
    attInit()
    att.atk = 40
    att.cri = 0.2
    att.criR = 0.1
    info ="[color=#C0C0C0]夜香灯笼草-花语：温柔[/color]\n当暴击时，为目标附加2层|虚弱|"
func _connect():
    sys.main.connect("onBattleStart",self,"check")
    masCha.connect("onAtkChara",self,"run")
    att.spd = +masCha.att.spd * 0.2

var stacktime = 0
func run(atkInfo:AtkInfo):
    if atkInfo.atkType == Chara.AtkType.NORMAL && atkInfo.isCri: 
        if gental == 1:
            atkInfo.hitCha.addBuff(ABuff.exhausted.new(3))
        if agony == 1:
            atkInfo.hitCha.addBuff(ABuff.agony.new(2))
        if pure == 1:
            masCha.plusHp(masCha.att.maxHp * 0.01)
        if greed == 1:
            masCha.hurtChara(masCha.aiCha,10/(masCha.att.spd * 0.01),Chara.HurtType.PHY,Chara.AtkType.EFF)
        if fade == 1:
            atkInfo.hitCha.addBuff(ABuff.parasite.new(3))        
        if rebirth == 1:
            var bf:Buff = masCha.hasBuff(ABuff.exhausted)
            if bf != null:
                bf.isDel = true
        if beauty == 1:
            masCha.hurtChara(masCha.aiCha,masCha.att.mgiAtk * 0.2,Chara.HurtType.MGI,Chara.AtkType.EFF)
        if heritage == 1 && stacktime >= 1:
            att.atk += 1
            stacktime = 0
        else:
            stacktime += 1        
    if atkInfo.atkType == Chara.AtkType.SKILL && atkInfo.isCri: 
        if heartbroke == 1:
            atkInfo.hitCha.addBuff(ABuff.heartbreak.new(3))
        if stink == 1:
            masCha.addBuff(ABuff.shrouded.new(3))

func check():
    info ="[color=#C0C0C0]夜香灯笼草-花语：温柔[/color]\n当暴击时，为目标附加2层|虚弱|"
    for i in masCha.items:
        if i.name == "哀嚎耳环":
            agony = 1
            info += "\n悲叹：暴击额外附加2层|哀嚎|"          
        else:
            agony = 0
        if i.name == "情变":
            heartbroke = 1
            info += "\n失情：技能暴击额外为目标附加3层|心碎|"          
        else:
            heartbroke = 0
        if i.name == "绝境突矛":
            rebirth = 1
            info += "\n重生：暴击攻击驱散自己所有|虚弱|"          
        else:
            rebirth = 0
        if i.name == "慈悲/慈爱":
            pure = 1
            info += "\n纯洁：暴击攻击为自己回复1%最大生命值"          
        else:
            pure = 0
        if i.name == "贪欲大剑":
            greed = 1
            info += "\n贪婪：暴击攻击额外造成攻速越接近0越高的伤害"          
        else:
            greed = 0
        if i.name == "不可思议天狗面":
            stink = 1
            info += "\n表里不一：技能暴击时获得3层|隐蔽|"          
        else:
            stink = 0
        if i.name == "虚无三尖枪":
            fade = 1
            info += "\n消逝：暴击攻击额外附加3层|寄生|"          
        else:
            fade = 0
        if i.name == "温和拳刃":
            gental = 1
            info += "\n温柔：暴击额外附加1层|虚弱|"          
        else:
            gental = 0
        if i.name == "自由之心":
            beauty = 1
            info += "\n美人：暴击造成20%魔攻的额外魔法伤害"          
        else:
            beauty = 0
        if i.name == "教育名册":
            heritage = 1
            info += "\n传承：暴击3次增加1点攻击"          
        else:
            heritage = 0
