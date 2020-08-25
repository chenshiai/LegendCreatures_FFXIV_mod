extends "../BaseFlower/BaseFlower.gd"
func init():
    name = "自由之心"
    type = config.EQUITYPE_EQUI
    attInit()
    att.mgiAtk = 85
    att.cd = 0.25
    info ="[color=#C0C0C0]夜来香-花语：美人[/color]\n技能有15%概率为目标附加2层|魅惑|"
func _connect():
    sys.main.connect("onBattleStart",self,"check")
    masCha.connect("onAtkChara",self,"run")

func run(atkInfo:AtkInfo):
    if atkInfo.atkType == Chara.AtkType.SKILL: 
        if sys.rndPer(15):
            if agony == 1:
                atkInfo.hitCha.addBuff(ABuff.agony.new(7))
            if heartbroke == 1:
                atkInfo.hitCha.addBuff(ABuff.agony.new(1))
            if rebirth == 1:
                var bf:Buff = masCha.hasBuff(ABuff.charmed)
                if bf != null:
                    bf.isDel = true
            if pure == 1:
                masCha.plusHp(masCha.att.maxHp * 0.07)
            if greed == 1:
                masCha.hurtChara(masCha.aiCha,10/(masCha.att.spd * 0.01),Chara.HurtType.PHY,Chara.AtkType.EFF)
            if stink == 1:
                masCha.addBuff(ABuff.shrouded.new(3))
            if fade == 1:
                atkInfo.hitCha.addBuff(ABuff.parasite.new(7)) 
            if beauty == 1:
                atkInfo.hitCha.addBuff(ABuff.charmed.new(3)) 
            if heritage == 1:
                att.mgiAtk += 7
        if atkInfo.isCri:
            if gental == 1:  
                atkInfo.hitCha.addBuff(ABuff.charmed.new(3)) 


func check():
    info ="[color=#C0C0C0]夜来香-花语：美人[/color]\n技能有15%概率为目标附加2层|魅惑|"
    for i in masCha.items:
        if i.name == "哀嚎耳环":
            agony = 1
            info += "\n悲叹：同时附加7层|哀嚎|"          
        else:
            agony = 0
        if i.name == "情变":
            heartbroke = 1
            info += "\n失情：同时附加3层|心碎|"          
        else:
            heartbroke = 0
        if i.name == "绝境突矛":
            rebirth = 1
            info += "\n重生：技能驱散自己所有|魅惑|"          
        else:
            rebirth = 0
        if i.name == "慈悲/慈爱":
            pure = 1
            info += "\n纯洁：同时为自己回复7%最大生命值"          
        else:
            pure = 0
        if i.name == "贪欲大剑":
            greed = 1
            info += "\n贪婪：额外造成攻速越接近0越高的伤害"          
        else:
            greed = 0
        if i.name == "不可思议天狗面":
            stink = 1
            info += "\n表里不一：同时获得3层|隐蔽|"          
        else:
            stink = 0
        if i.name == "虚无三尖枪":
            fade = 1
            info += "\n消逝：同时附加7层|寄生|"          
        else:
            fade = 0
        if i.name == "温和拳刃":
            gental = 1
            info += "\n温柔：此技能如果暴击，1.5倍|魅惑|时长"          
        else:
            gental = 0
        if i.name == "自由之心":
            beauty = 1
            info += "\n美人：额外附加一层|魅惑|"          
        else:
            beauty = 0
        if i.name == "教育名册":
            heritage = 1
            info += "\n传承：附加|魅惑|时获得7法强"          
        else:
            heritage = 0


