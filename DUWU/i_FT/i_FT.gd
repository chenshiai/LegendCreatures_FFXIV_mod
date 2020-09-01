extends "../BaseFlower/BaseFlower.gd"
func init():
    name = "虚无三尖枪"
    type = config.EQUITYPE_EQUI
    attInit()
    att.atk = 33
    att.def = 53
    att.mgiDef = 33
    att.dod = 0.03
    info ="[color=#C0C0C0]银莲花-花语：消逝[/color]\n普通攻击对周围一格的敌人造成自身血量越低越高的物理伤害"
func _connect():
    sys.main.connect("onBattleStart",self,"check")
    masCha.connect("onAtkChara",self,"run")
    att.spd = -masCha.att.spd * 0.07

var lost = 0
var atttime = 0
var stacktime = 0
func _upS():
    ._upS()
    lost = 0.1 / (masCha.att.hp / masCha.att.maxHp)

func run(atkInfo:AtkInfo):
    if atkInfo.atkType == Chara.AtkType.NORMAL: 
        atttime += 1
        if stink == 1 && atttime >= 3:
            masCha.addBuff(ABuff.shrouded.new(1))
            atttime = 0
        if pure == 1:
            masCha.plusHp(masCha.att.maxHp * 0.001)
        var chas = masCha.getCellChas(atkInfo.hitCha.cell,1,1)
        for i in chas:
            if i != atkInfo.hitCha && i != self:
                if rebirth == 1:
                    masCha.hurtChara(i,masCha.att.atk*lost*1.1,Chara.HurtType.PHY,Chara.AtkType.EFF)
                else:
                    masCha.hurtChara(i,masCha.att.atk*lost,Chara.HurtType.PHY,Chara.AtkType.EFF)
                if agony == 1:
                    i.addBuff(ABuff.agony.new(1))
                if heartbroke == 1:
                    i.addBuff(ABuff.heartbreak.new(1))    
                if greed == 1:
                    masCha.hurtChara(i,10/(masCha.att.spd),Chara.HurtType.PHY,Chara.AtkType.EFF)
                if fade == 1:
                    i.addBuff(ABuff.parasite.new(1))
                if gental == 1:
                    i.addBuff(ABuff.exhausted.new(1))
                if beauty == 1:            
                    masCha.hurtChara(i,masCha.att.mgiAtk*0.1,Chara.HurtType.PHY,Chara.AtkType.EFF)
                if heritage == 1 && stacktime >= 1:
                    att.atk += 1
                    stacktime = 0
                else:
                    stacktime += 1

func check():
    info ="[color=#C0C0C0]银莲花-花语：消逝[/color]\n普通攻击对周围一格的敌人造成自身血量越低越高的物理伤害"
    for i in masCha.items:
        if i.name == "哀嚎耳环":
            agony = 1
            info += "\n悲叹：溅射效果附加1层|哀嚎|"          
        else:
            agony = 0
        if i.name == "情变":
            heartbroke = 1
            info += "\n失情：溅射效果附加1层|心碎|"          
        else:
            heartbroke = 0
        if i.name == "绝境突矛":
            rebirth = 1
            info += "\n重生：溅射效果的伤害增加10%"          
        else:
            rebirth = 0
        if i.name == "慈悲/慈爱":
            pure = 1
            info += "\n纯洁：攻击为自己回复0.1%最大生命值"          
        else:
            pure = 0
        if i.name == "贪欲大剑":
            greed = 1
            info += "\n贪婪：溅射伤害额外造成攻速越接近0越高的伤害"          
        else:
            greed = 0
        if i.name == "不可思议天狗面":
            stink = 1
            info += "\n表里不一：攻击三次后获得1层|隐蔽|"          
        else:
            stink = 0
        if i.name == "虚无三尖枪":
            fade = 1
            info += "\n消逝：溅射效果附加3层|寄生|"          
        else:
            fade = 0
        if i.name == "温和拳刃":
            gental = 1
            info += "\n温柔：溅射效果附加1层|虚弱|"          
        else:
            gental = 0
        if i.name == "自由之心":
            beauty = 1
            info += "\n美人：溅射效果造成10%魔攻的额外魔法伤害"          
        else:
            beauty = 0
        if i.name == "教育名册":
            heritage = 1
            info += "\n传承：攻击溅射两次增加1点攻击"          
        else:
            heritage = 0

