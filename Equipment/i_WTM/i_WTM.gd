extends "../BaseFlower/BaseFlower.gd"
func init():
    name = "不可思议天狗面"
    type = config.EQUITYPE_EQUI
    attInit()
    att.suck = 0.1
    att.mgiSuck = 0.1
    att.mgiDef = 30
    info ="[color=#C0C0C0]鸡屎藤-花语：表里不一[/color]\n被攻击十次时，为自己附加2层|恶臭|，在|恶臭|期间，该效果不触发"
func _connect():
    sys.main.connect("onBattleStart",self,"check")
    sys.main.connect("onBattleStart",self,"characheck")
    masCha.connect("onHurt",self,"run")

var hit = 0
var hstink = 2
func run(atkInfo:AtkInfo):
    var bf:Buff = masCha.hasBuff("duwu_stink")
    if atkInfo.isMiss == false:
        if hit == 10:
            hit = 0
            if greed == 1:
                masCha.addBuff(b_kuangNu.new(hstink))
            if stink == 1:
                hstink += 1
            if bf == null:
                masCha.addBuff(ABuff.stink.new(hstink))
                for chass in masCha.getCellChas(masCha.cell,1,1):
                    if agony == 1:
                        chass.addBuff(ABuff.agony.new(3))
                    if heartbroke == 1:
                        chass.addBuff(ABuff.heartbreak.new(1))
                    if fade == 1:
                        chass.addBuff(ABuff.parasite.new(3))
                    if gental == 1:
                        chass.addBuff(ABuff.exhausted.new(3)) 
                for chassa in masCha.getCellChas(masCha.cell,1,2):
                    if rebirth == 1:
                        chassa.addBuff(ABuff.enpowered.new(3))
                    if pure == 1:
                        chassa.plusHp(chassa.att.maxHp * 0.01)
                    if beauty == 1:
                        chassa.addBuff(ABuff.enpowered.new(4))
        else:
            hit += 1


func check():
    hstink = 2
    info ="[color=#C0C0C0]鸡屎藤-花语：表里不一[/color]\n被攻击十次时，为自己附加2层|恶臭|，在|恶臭|期间，该效果不触发"
    for i in masCha.items:
        if i.name == "哀嚎耳环":
            agony = 1
            info += "\n悲叹：额外为周围一格的敌人附加三层|哀嚎|"          
        else:
            agony = 0
        if i.name == "情变":
            heartbroke = 1
            info += "\n失情：额外为周围一格的敌人附加两层|心碎|"          
        else:
            heartbroke = 0
        if i.name == "绝境突矛":
            rebirth = 1
            info += "\n重生：额外为周围一格的友军附加三层|鼓舞|"          
        else:
            rebirth = 0
        if i.name == "慈悲/慈爱":
            pure = 1
            info += "\n纯洁：额外为周围一格的友军回复1%最大生命值"          
        else:
            pure = 0
        if i.name == "贪欲大剑":
            greed = 1
            hstink = 4
            info += "\n贪婪：恶臭层数加倍并获得相等层数的[狂怒]"          
        else:
            greed = 0
        if i.name == "不可思议天狗面":
            stink = 1
            info += "\n恶臭：每次效果触发时恶臭层数加一，战斗结束重置"          
        else:
            stink = 0
        if i.name == "虚无三尖枪":
            fade = 1
            info += "\n消逝：额外为周围一格的敌人附加两层|寄生|"          
        else:
            fade = 0
        if i.name == "温和拳刃":
            gental = 1
            info += "\n温柔：额外为周围一格的敌人附加三层|虚弱|"          
        else:
            gental = 0
        if i.name == "自由之心":
            beauty = 1
            info += "\n美人：额外为周围一格的友军附加四层|鼓舞|"          
        else:
            beauty = 0

var t00 = 0
func characheck():
    var numHit
    var effnow
    if masCha.id.find("tengu") >= 0 || masCha.id.find("AyouA_2") >= 0 && t00 == 0:
        effnow = sys.newEff("numHit",masCha.position + Vector2(30,0),false,1)
        effnow.setText("好臭！","40fd14")
        effnow.anim.set_speed_scale(0.2)
        t00 = 1
        att.suck = 0.25
        att.mgiSuck = 0.25
        info += "\n被天狗戴过的面具，获得永久加成"

