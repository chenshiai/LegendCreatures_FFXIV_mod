extends "../BaseFlower/BaseFlower.gd"
func init():
    name = "情变"
    type = config.EQUITYPE_EQUI
    attInit()
    att.mgiDef = -40
    att.atk = 88
    att.cri = 0.2
    info ="[color=#C0C0C0][逆]彭斯特蒙-花语：失情[/color]\n技能为目标附加3秒|心碎|"
func _connect():
    sys.main.connect("onBattleStart",self,"check")
    masCha.connect("onAtkChara",self,"run")

var stacktime = 0
func run(atkInfo:AtkInfo):
    if atkInfo.atkType == Chara.AtkType.SKILL: 
        atkInfo.hitCha.addBuff(ABuff.heartbreak.new(3))
        if heartbroke == 1:
            var debuf = [b_jieShuang,b_liuXue,b_shaoZhuo,b_shiMing,b_zhonDu,ABuff.para,ABuff.agony]  
            var debf = debuf[sys.rndRan(0,debuf.size()-1)]    
            atkInfo.atkCha.addBuff(debf.new(1))
        if pure == 1:
            masCha.plusHp(masCha.att.maxHp * 0.01) 
        if stink == 1:
            masCha.addBuff(ABuff.shrouded.new(1))
        if fade == 1:
            atkInfo.hitCha.addBuff(ABuff.parasite.new(4))    
        if gental == 1:
            atkInfo.hitCha.addBuff(ABuff.exhausted.new(4))    
        if beauty == 1:
            masCha.hurtChara(atkInfo.hitCha,masCha.att.mgiAtk * 0.2,Chara.HurtType.MGI,Chara.AtkType.EFF)            
    if atkInfo.atkType == Chara.AtkType.NORMAL: 
        if agony == 1:
            var debuf = [b_jieShuang,b_liuXue,b_shaoZhuo,b_shiMing,b_zhonDu,ABuff.para,ABuff.agony]  
            var debf = debuf[sys.rndRan(0,debuf.size()-1)]    
            atkInfo.atkCha.addBuff(debf.new(1)) 
        if rebirth == 1:
            var buf = [b_diYu,b_jiSu,b_kuangNu,b_moYu]
            var bf = buf[sys.rndRan(0,buf.size()-1)]    
            masCha.addBuff(bf.new(1))
        if greed == 1:
            masCha.hurtChara(masCha.aiCha,10/(masCha.att.spd * 0.01),Chara.HurtType.PHY,Chara.AtkType.EFF)
        if heritage == 1 && stacktime >= 1:
            att.mgiAtk += 1
            stacktime = 0

func check():
    info ="[color=#C0C0C0][逆]彭斯特蒙-花语：失情[/color]\n技能为目标附加3秒|心碎|"
    for i in masCha.items:
        if i.name == "哀嚎耳环":
            agony = 1
            info += "\n悲叹：普通攻击额外附加%s层随机负面状态" % (agony)
                
        else:
            agony = 0
        if i.name == "情变":
            heartbroke = 1
            info += "\n失情：技能额外为目标附加%s层随机负面状态" % (heartbroke)
                
        else:
            heartbroke = 0
        if i.name == "绝境突矛":
            rebirth = 1
            info += "\n重生：普通攻击额外给自己附加%s层随机正面状态" % (rebirth)
                
        else:
            rebirth = 0
        if i.name == "慈悲/慈爱":
            pure = 1
            info += "\n纯洁：技能为自己回复1%最大生命值"          
        else:
            pure = 0
        if i.name == "贪欲大剑":
            greed = 1
            info += "\n贪婪：普通攻击额外造成攻速越接近0越高的伤害"          
        else:
            greed = 0
        if i.name == "不可思议天狗面":
            stink = 1
            info += "\n表里不一：释放技能时获得1层|隐蔽|"          
        else:
            stink = 0
        if i.name == "虚无三尖枪":
            fade = 1
            info += "\n消逝：释放技能时给目标4层|寄生|"          
        else:
            fade = 0
        if i.name == "温和拳刃":
            gental = 1
            info += "\n温柔：释放技能时给目标4层|虚弱|"          
        else:
            gental = 0
        if i.name == "自由之心":
            beauty = 1
            info += "\n美人：技能造成20%魔攻的额外魔法伤害"          
        else:
            beauty = 0
        if i.name == "教育名册":
            heritage = 1
            info += "\n传承：放出两次技能增加1点魔攻"          
        else:
            heritage = 0