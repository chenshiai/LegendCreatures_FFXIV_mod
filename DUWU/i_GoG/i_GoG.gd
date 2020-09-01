extends "../BaseFlower/BaseFlower.gd"
func init():
    name = "贪欲大剑"
    type = config.EQUITYPE_EQUI
    attInit()
    att.atk = 120
    info ="[color=#C0C0C0][逆]鲁冰花-花语：贪婪[/color]\n每攻击五次打出一道直线穿透敌人的剑气，造成100%的物理伤害"
func _connect():
    sys.main.connect("onBattleStart",self,"check")
    masCha.connect("onAtkChara",self,"run")
    att.spd = -masCha.att.spd * 0.2

var atkt = 0
func run(atkInfo:AtkInfo):
    if atkInfo.atkType == Chara.AtkType.NORMAL:
        atkt += 1
        if atkt >= 5:
            if pure == 1:
                masCha.plusHp(masCha.att.maxHp * 0.02)
            if rebirth == 1:
                masCha.addBuff(b_jiSu.new(4))
            atkt -= 5
            var eff:Eff = masCha.newEff("sk_feiZhan",masCha.sprcPos)
            eff._initFlyPos(masCha.position + (atkInfo.hitCha.position - masCha.position).normalized() * 300,300)
            eff.connect("onInCell",self,"effInCell")
            if stink == 1:
                masCha.addBuff(ABuff.stink.new(3))
            if heritage == 1:
                att.atk += 1

func effInCell(cell):
    var cha = masCha.matCha(cell)
    if cha != null && cha.team != masCha.team :
        masCha.hurtChara(cha,masCha.att.atk * 1,Chara.HurtType.PHY,Chara.AtkType.EFF)
        if agony == 1:
            cha.addBuff(ABuff.agony.new(2))
        if heartbroke == 1:
            cha.addBuff(ABuff.heartbreak.new(1))
        if greed == 1:
            masCha.hurtChara(cha,100/(masCha.att.spd),Chara.HurtType.PHY,Chara.AtkType.EFF)
        if fade == 1:
            cha.addBuff(ABuff.parasite.new(2))     
        if gental == 1:
            cha.addBuff(ABuff.exhausted.new(2))   
        if beauty == 1:
            masCha.hurtChara(cha,masCha.att.mgiAtk * 0.1,Chara.HurtType.MGI,Chara.AtkType.EFF)  
            

func check():
    info ="[color=#C0C0C0][逆]鲁冰花-花语：贪婪[/color]\n每攻击五次打出一道直线穿透敌人的剑气，造成100%的物理伤害"
    for i in masCha.items:
        if i.name == "哀嚎耳环":
            agony = 1
            info += "\n悲叹：剑气附加2层|哀嚎|"          
        else:
            agony = 0
        if i.name == "情变":
            heartbroke = 1
            info += "\n失情：剑气附加1秒|心碎|"          
        else:
            heartbroke = 0
        if i.name == "绝境突矛":
            rebirth = 1
            info += "\n重生：为自己附加4层[急速]"          
        else:
            rebirth = 0
        if i.name == "慈悲/慈爱":
            pure = 1
            info += "\n纯洁：恢复自身2%最大生命值"          
        else:
            pure = 0
        if i.name == "贪欲大剑":
            greed = 1
            info += "\n贪婪：额外造成攻速越接近0越高的伤害"          
        else:
            greed = 0
        if i.name == "不可思议天狗面":
            stink = 1
            info += "\n恶臭：为自己附加3层|恶臭|"          
        else:
            stink = 0
        if i.name == "虚无三尖枪":
            fade = 1
            info += "\n消逝：剑气附加2层|寄生|"          
        else:
            fade = 0
        if i.name == "温和拳刃":
            gental = 1
            info += "\n温柔：剑气附加2层|虚弱|"          
        else:
            gental = 0
        if i.name == "自由之心":
            beauty = 1
            info += "\n美人：剑气造成10%魔攻的额外魔法伤害"          
        else:
            beauty = 0
        if i.name == "教育名册":
            heritage = 1
            info += "\n传承：放出剑气时增加1点攻击"          
        else:
            heritage = 0