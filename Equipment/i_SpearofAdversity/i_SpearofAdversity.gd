extends "../BaseFlower/BaseFlower.gd"
func init():
    name = "绝境突矛"
    type = config.EQUITYPE_EQUI
    attInit()
    att.def = 25
    att.atk = 75
    att.maxHp = 320
    info ="[color=#C0C0C0]雪滴花-花语：希望[/color]\n第一次死亡时恢复50%生命值，受到10层|虚弱|"
func _connect():
    sys.main.connect("onBattleStart",self,"check")
    masCha.connect("onDeath",self,"run")
    att.spd = -masCha.att.spd * 0.2

var n = 0
func run(atkInfo):
    if n < 1:
        n += 1
        masCha.isDeath = false
        masCha.plusHp(masCha.att.maxHp * 0.5)
        yield(sys.get_tree().create_timer(0.2),"timeout")
        if agony == 1:
            masCha.addBuff(b_jiSu.new(10))
        if heartbroke == 1:
            masCha.addBuff(b_moYu.new(10))
        if rebirth == 1:
            masCha.addBuff(b_diYu.new(10))
        if pure == 1:
            masCha.plusHp(masCha.att.maxHp * 0.1)
        if greed == 1:
            masCha.attAdd.atk += 20    
        if stink == 1:
            masCha.addBuff(ABuff.shrouded.new(3))
        if fade == 1:
            masCha.addBuff(ABuff.parasite.new(20))
            masCha.addBuff(ABuff.invincible.new(2))
        if gental == 0:
            masCha.addBuff(ABuff.exhausted.new(10))
        if beauty == 1:
            masCha.attAdd.mgiAtk += 20  
        if heritage == 1:
            att.maxHp += 5
            att.def += 5
            att.mgiDef += 5


func check():
    n = 0
    info ="[color=#C0C0C0]雪滴花-花语：希望[/color]\n第一次死亡时恢复50%生命值，受到10层|虚弱|"
    for i in masCha.items:
        if i.name == "哀嚎耳环":
            agony = 1
            info += "\n悲叹：复活时额外附加十层[急速]"          
        else:
            agony = 0
        if i.name == "情变":
            heartbroke = 1
            info += "\n失情：复活时额外附加十层[魔御]"          
        else:
            heartbroke = 0
        if i.name == "绝境突矛":
            rebirth = 1
            info += "\n重生：复活时额外附加十层[抵御]"          
        else:
            rebirth = 0
        if i.name == "慈悲/慈爱":
            pure = 1
            info += "\n纯洁：复活时额外回复10%最大生命值"          
        else:
            pure = 0
        if i.name == "贪欲大剑":
            greed = 1
            info += "\n贪婪：复活时增加20攻击"          
        else:
            greed = 0
        if i.name == "不可思议天狗面":
            stink = 1
            info += "\n表里不一：复活时|隐蔽|3秒"          
        else:
            stink = 0
        if i.name == "虚无三尖枪":
            fade = 1
            info += "\n消逝：复活时给自己20层|寄生|和2秒|无敌|"          
        else:
            fade = 0
        if i.name == "温和拳刃":
            gental = 1
            info += "\n温柔：复活时不受到|虚弱|"          
        else:
            gental = 0
        if i.name == "自由之心":
            beauty = 1
            info += "\n美人：复活时增加20魔攻"          
        else:
            beauty = 0
        if i.name == "教育名册":
            heritage = 1
            info += "\n传承：复活增加5点双防和生命值"          
        else:
            heritage = 0