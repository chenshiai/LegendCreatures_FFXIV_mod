extends Node
var TEXT
func _ready():
    pass
func _init():
    yield(sys.get_tree().create_timer(2.5),"timeout")
    TEXT = globalData.infoDs["g_text"]
    config.bfDir["|麻痹|"] = "无法攻击和移动"
    config.bfDir["|鼓舞|"] = TEXT.format("增加100%{TMgiDef}的{TMgi}")
    config.bfDir["|不稳|"] = TEXT.format("普通攻击造成伤害为5%")
    config.bfDir["|血欲|"] = TEXT.format("增加0.1%双吸，最高叠加100次")
    config.bfDir["|虚神|"] = TEXT.format("每秒减少相当于2%最大生命值的hp")
    config.bfDir["|付与|"] = TEXT.format("普攻附加自身的50%{TMgiDam}")
    config.bfDir["|哀嚎|"] = TEXT.format("{TRegen}效果减少3%，每层增加2%效果")
    config.bfDir["|心碎|"] = TEXT.format("受到技能伤害时，所有正面buff层数减1层")
    config.bfDir["|恶臭|"] = TEXT.format("获得一个层数*45的护盾，自身无法被治疗")
    config.bfDir["|隐蔽|"] = TEXT.format("当被攻击范围大于1的敌人攻击时，伤害减少95%")
    config.bfDir["|寄生|"] = TEXT.format("""如果目标大于50%生命值，每秒造成12%目标{TMgi}+2%最大生命值的{TMgiDam};
如果小于50%，增加10%受到的{TMgiDam}，每一层增加1%""")
    config.bfDir["|缠绕|"] = TEXT.format("试图放技能时，30%机率让所有CD技能后退50%冷却，每层增加2%机率")
    config.bfDir["|数羊|"] = TEXT.format("敌方人数越多攻速越慢")
    config.bfDir["|再生|"] = TEXT.format("获得110%的{TRegen}，每层加3%")
    config.bfDir["|空灵|"] = TEXT.format("[color=#1aa30b]受到伤害时，{TRegen}2%的最大生命值，每层增加0.1%[/color]")
    config.bfDir["|无敌|"] = TEXT.format("不受到任何伤害")
    config.bfDir["|血怒|"] = TEXT.format("每损失1%的生命值，获得0.1%吸血和攻击加成")
    config.bfDir["|虚弱|"] = TEXT.format("攻击造成的伤害降低10%，如果攻击暴击，伤害降低25%, 每层加0.1%")
    config.bfDir["|魅惑|"] = TEXT.format("无法移动，攻击的目标变成最近的友军")
    config.bfDir["|过载|"] = TEXT.format("受到110%伤害，双穿增加40%")
    config.bfDir["|寒冷|"] = TEXT.format("减少30%攻速，每层增加3%")
    config.bfDir["|冰结|"] = TEXT.format("技能释放速度减少10%，受到的魔法伤害增加10%，每层增加3%")
    config.bfDir["|光镜|"] = TEXT.format("反射给自己仇恨50%除了特效外的伤害，造成魔法伤害，加5%冷却")
    config.bfDir["|绝对零度|"] = TEXT.format("无法攻击，移动，释放技能和受到伤害3秒，在结束时会受到所有累计的伤害，该效果不会被净化")
    config.bfDir["|无法者|"] = TEXT.format("当前只有山贼，后面会加")
    config.bfDir["|伏虎|"] = TEXT.format("获得30%{TPhyDef}的{TPhy}")
    config.bfDir["|心眼|"] = TEXT.format("获得100%闪避")
    config.bfDir["|空蝉|"] = TEXT.format("死亡时{TRegen}5%最大生命值，撤退至后面")
    config.bfDir["|暗杀·轻|"] = TEXT.format("若攻击的敌人的生命低于7%最大生命值，造成7%最大生命值的真伤；否则造成物抗越低越高的伤害")
    config.bfDir["|暗杀·极|"] = TEXT.format("若攻击的敌人的生命低于10%最大生命值，造成10%最大生命值的真伤；否则造成物抗越低越高的伤害")
    config.bfDir["|狐福|"] = TEXT.format("获得5%闪避，闪避时永久增加1点双攻")
    pass

func _connect():
    pass

#麻痹
class para:
    extends Buff
    func _init(lv = 1):
        ._init()
        id = "para"
        isNegetive = true
        life = lv

    var oriAi
    func _connect():
        ._connect()
        oriAi = masCha.aiOn
        masCha.aiOn = false
        

    func _upS():
        ._upS()
        var path = chaData.infoDs["cex___duwuAtrap"].dir
        var eff:Eff = sys.newEff("animEff",masCha.position) #在像素坐标100，100 创建自定义动画特效
        eff.setImgs(path +"/e_para",7.5,false)#设置当前脚本目录下的effImgs文件夹里的所有图片为序列帧图源 ， 播放速度15
        eff.normalSpr.position = Vector2(0,-30)
        eff.scale *= 1.5
        life = clamp(life,0,3)

    func _del():
        masCha.aiOn = oriAi
        ._del()   


#鼓舞        
class enpowered:
    extends Buff

    var casc

    func _init(lv = 1):
        attInit()
        life = lv
    func init():
        pass
    func _connect():
        pass
    func _upS():
        att.mgiAtk = masCha.att.mgiDef * 1.0

#不稳
class shakey:
    extends Buff

    func _init(cas,lv = 1):
        attInit()
        id = "shakey"
        life = lv
        isNegetive= true
    func _connect():
        masCha.connect("onAtkChara",self,"onAtkChara")
    func onAtkChara(atkInfo:AtkInfo):
        if masCha.isDeath == false && atkInfo.atkType == Chara.AtkType.NORMAL && atkInfo.isMiss != true:
            masCha.atkInfo.hurtVal = 0.05

#虚神
class aftereff:
    extends Buff
    func _init(lv = 20):
        attInit()
        id="aftereff"
        isNegetive=true
        life = lv

    func _upS():
        masCha.plusHp(masCha.att.maxHp * -0.02)
        life = clamp(life,1,20)    

#付与
class enchanted:
    extends Buff

    var casc

    func _init(cas,lv = 1):
        attInit()
        id = "enchanted"
        life = lv
        isNegetive=false
        casc=cas
    func _connect():
        masCha.connect("onAtkChara",self,"onAtkChara")
    func onAtkChara(atkInfo:AtkInfo):
        if casc.isDeath == false && atkInfo.atkType == Chara.AtkType.NORMAL && atkInfo.isMiss != true:
            casc.hurtChara(atkInfo.hitCha,casc.att.mgiAtk * 0.5,Chara.HurtType.MGI,Chara.AtkType.EFF)

#哀嚎
class agony:
    extends Buff 
    func _init(lv = 1):
        attInit()
        id = "agony"
        life = lv
        isNegetive=true
        att.reHp = (-0.02 + -0.03 * life)

    func _upS():
        life = clamp(life,1,20) 
        
#寒冷
class cody:
    extends Buff
    func _init(lv = 1):
        attInit()
        id = "duwu_cody"
        life = lv
        isNegetive=true
    func _connect():
        att.spd = -masCha.att.spd * 0.3 + life * 0.03

    func _upS():
        life = clamp(life,1,20) 
#冰结
class freezee:
    extends Buff
    func _init(lv = 1):
        attInit()
        id = "freezee"
        life = lv
        isNegetive=true
    func _connect():
        masCha.connect("onHurt",self,"run")
    func run(atkInfo:AtkInfo):
        if atkInfo.hurtType == Chara.HurtType.MGI:
            atkInfo.hurtVal *= 1.1 + 0.03 * life
    func _upS():
        att.cd = - (0.10 + life * 0.03)        

#心碎
class heartbreak:
    extends Buff
    func _init(lv = 1):
        attInit()
        life = lv
        id = "heartbreak"
        isNegetive=true
    func init():
        pass
    func _connect():
        masCha.connect("onHurt",self,"run")
          
    func run(atkInfo:AtkInfo):
        if atkInfo.hurtVal > 0 && atkInfo.isMiss != true && atkInfo.atkType == Chara.AtkType.SKILL:
            for bf in masCha.buffs:
                if !bf.isNegetive && bf.life != null:
                    bf.life -= 1

#恶臭
class stink:
    extends Buff
    var shield = lv * 45
    var effnow
    var tm = 0
    func _init(lv = 1):
        attInit()
        life = lv
        id = "duwu_stink"
        isNegetive=true
    func init():
        pass
    func _connect():
        masCha.connect("onHurt",self,"run1")
    func run1(atkInfo):
        if shield > atkInfo.hurtVal:
            shield -= atkInfo.hurtVal
            atkInfo.hurtVal = 0
        elif shield == atkInfo.hurtVal:
            atkInfo.hurtVal = 0
            shield = 0
        elif shield < atkInfo.hurtVal:
            atkInfo.hurtVal -= shield
            shield = 0
    func _upS():
        att.reHp = 0
        tm += 1
        if tm == 2:
            tm = 0
            if shield >= 0:
                effnow = sys.newEff("numHit",masCha.position,false,1)
                effnow.setText("护盾:%d"%[shield],"#ffffff")
                effnow.anim.set_speed_scale(0.55)
                effnow.z_index = 1

#隐蔽
class shrouded:
    extends Buff
    func _init(lv = 1):
        attInit()
        life = lv
        id = "shrounded"
        isNegetive=false
    func init():
        pass
    func _connect():
        masCha.connect("onHurt",self,"run")
    func run(atkInfo:AtkInfo):
        var ran = masCha.cellRan(masCha.atkInfo.atkCha.cell)
        if ran > 1:
            atkInfo.hurtVal *= 0.05

#寄生
class parasite:
    extends Buff
    var trigger
    func _init(lv = 1):
        id = "parasite"
        attInit()
        life = lv
        isNegetive=true
    func init():
        pass
    func _connect():
        masCha.connect("onAtkChara",self,"run")
    func run(atkInfo):
        if masCha.atkInfo.hurtType == Chara.HurtType.MGI && atkInfo.atkCha == masCha && trigger == 1:
            atkInfo.hurtVal *= 1.1 + 0.01 * life
    func _upS():
        if masCha.att.hp >= masCha.att.maxHp * 0.5:
            masCha.hurtChara(masCha,masCha.att.mgiAtk * 0.12 + masCha.att.maxHp * 0.02,Chara.HurtType.MGI,Chara.AtkType.EFF)
            trigger = 0
        else:
            trigger = 1

#缠绕
class rooted:
    extends Buff
    func _init(dur = 1):
        attInit()
        id = "rooted"
        life = dur
    func _connect():
        if sys.rndPer(30 + 2 * life):
            for i in masCha.skills:
                i.nowTime -= i.nowTime * 0.5

#数羊
class sheep:
    extends Buff
    func _init(dur = 1):
        attInit()
        id = "sheep"
        life = dur
        isNegetive=true
    func _connect():
        var chasNum = masCha.getAllChas(1).size()
        att.spd = -masCha.att.spd * (0.05 * chasNum + 0.01 * life)

#再生
class revitalize:
    extends Buff
    func _init(lv = 1):
        attInit()
        id = "revitalize"
        life = lv
        isNegetive=true
    func _upS():
        att.reHp = + (0.10 + life * 0.03)
        life = clamp(life,1,25) 

#空灵
class ethereal:
    extends Buff
    func _init(lv = 1):
        attInit()
        life = lv
        id = "ethereal"
        isNegetive=false
    func init():
        pass
    func _connect():
        masCha.connect("onHurt",self,"run")
    func run(atkInfo:AtkInfo):
        masCha.plusHp(masCha.att.maxHp * 0.2 + 0.01 * life)

#无敌
class invincible:
    extends Buff
    func _init(lv = 1):
        attInit()
        life = lv
        id = "shrounded"
        isNegetive=false
    func init():
        pass
    func _connect():
        masCha.connect("onHurtEnd",self,"run")
    func run(atkInfo:AtkInfo):
        atkInfo.hurtVal *= 0

#虚弱
class exhausted:
    extends Buff
    func _init(lv = 1):
        attInit()
        life = lv
        id = "exhausted"
        isNegetive=true
    func init():
        pass
    func _connect():
        masCha.connect("onAtkChara",self,"run")
    func run(atkInfo):
        if atkInfo.isCri:
            atkInfo.hurtVal *= 0.75 - 0.01 * lv
        else:
            atkInfo.hurtVal *= 0.9 - 0.01 * lv

#魅惑
class charmed:
    extends Buff
    func _init(lv = 1):
        attInit()
        id = "charmed"
        isNegetive=true
        life = lv
    func _connect():
        masCha.aiOn = false
    func _upS():
        masCha.aiOn = false
        var chas = masCha.getAllChas(0)
        chas.sort_custom(self,"sort")
        masCha.normalAtkChara(chas[0])
        life = clamp(life, 0, 5)
    func sort(a,b):
        if masCha.cellRan(a.cell,masCha.cell) < masCha.cellRan(b.cell,masCha.cell) :
            return true
        return false
    func _del():
        masCha.aiOn = true
        ._del()

#过载
class overcharged:
    extends Buff
    func _init(lv = 1):
        attInit()
        id = "overcharged"
        life = lv
        isNegetive=true
    func _connect():
        masCha.connect("onHurt",self,"run")
    func run(atkInfo:AtkInfo):
        atkInfo.hurtVal *= 1.1
    func _upS():
        att.pen = + 0.40
        att.mgiPen = + 0.40
        life = clamp(life,1,6) 

#光镜        
class prismed:
    extends Buff
    func _init(lv = 1):
        attInit()
        id = "duwu_prismed"
        life = lv
        isNegetive=true
    func _connect():
        masCha.connect("onHurt",self,"run")
    func run(atkInfo:AtkInfo):
        if atkInfo.atkType != Chara.AtkType.EFF:
            masCha.hurtChara(masCha.aiCha,atkInfo.hurtVal * 0.5,Chara.HurtType.MGI,Chara.AtkType.EFF)
    func _upS():
        att.cd = + 0.05

#绝对0度
class abso_zero:
    extends Buff
    var sda = 0
    var oriAi
    func _init(lv = 1):
        attInit()
        life = lv
        id = "abso_zero"
        isNegetive=false
    func init():
        pass
    func _connect():
        oriAi = masCha.aiOn
        masCha.aiOn = false
        masCha.connect("onHurt",self,"run")
    func run(atkInfo:AtkInfo):
        atkInfo.hurtVal *= 0
        sda += atkInfo.hurtVal
    func _upS():
        ._upS()
        att.cd = - 1
        life = clamp(life,0,3)
    func _del():
        masCha.aiOn = oriAi
        masCha.hurtChara(self,sda,Chara.HurtType.MGI,Chara.AtkType.EFF)
        ._del()   

#伏虎
class tiger:
    extends Buff
    func _init(lv = 1):
        attInit()
        life = lv
        id = "duwu_tiger"
        isNegetive=false
    func init():
        pass
    func _connect():
        masCha.att.atk += masCha.att.def * 0.3

#心眼
class mindeye:
    extends Buff
    func _init(lv = 1):
        attInit()
        life = lv
        id = "duwu_mindeye"
        isNegetive=false
    func init():
        pass
    func _connect():
        masCha.attAdd.dod = 1.0

#空蝉
class utsusemi:
    extends Buff
    func _init(lv = 1):
        attInit()
        id = "duwu_utsusemi"
        life = lv
        isNegetive=true
    func _connect():
        masCha.connect("onDeath",self,"run")
    func run(atkInfo):
        masCha.isDeath = false
        masCha.plusHp(masCha.att.maxHp * 0.05)
        var mv = Vector2(masCha.cell.x ,masCha.cell.y)
        if masCha.team == 2:mv.x = 7
        else:mv.x = 0
        var vs = [Vector2(0,0),Vector2(1,0),Vector2(-1,0),Vector2(0,1),Vector2(0,-1),Vector2(1,1),Vector2(-1,1),Vector2(-1,-1),Vector2(1,-1)]
        for i in vs:
            var v = mv+i
            if masCha.matCha(v) == null && sys.main.isMatin(v):
                if masCha.setCell(v) :
                    var pos = sys.main.map.map_to_world(masCha.cell)
                    ying(pos)
                    masCha.position = pos
                    masCha.aiCha = null
                    break

    func ying(pos):
        var l:Vector2 = pos - masCha.position
        var s = 25
        var rs = preload("res://core/ying.tscn")
        var n = l.length()/s
        for i in range(n):
            var spr = rs.instance()
            sys.main.map.add_child(spr)
            spr.texture = masCha.img.texture_normal
            spr.position = masCha.position + s * (i+1) * l.normalized() - Vector2(masCha.img.texture_normal.get_width()/2,masCha.img.texture_normal.get_height())
            spr.init(255/n * i + 100)
        
#暗杀·轻
class assassination_lv0:
    extends Buff
    func _init(lv = 1):
        attInit()
        life = lv
        id = "duwu_assassination_lv0"
        isNegetive=true
    func init():
        pass
    func _connect():
        if masCha.att.hp <= masCha.att.maxHp * 0.07:
            masCha.hurtChara(self,masCha.att.maxHp * 0.07,Chara.HurtType.REAL,Chara.AtkType.EFF)
        else:
            masCha.hurtChara(self,1/(masCha.att.def + 1 * 0.01),Chara.HurtType.PHY,Chara.AtkType.EFF)

#暗杀·极
class assassination_lv1:
    extends Buff
    func _init(lv = 1):
        attInit()
        life = lv
        id = "duwu_assassination_lv1"
        isNegetive=true
    func init():
        pass
    func _connect():
        if masCha.att.hp <= masCha.att.maxHp * 0.1:
            masCha.hurtChara(self,masCha.att.maxHp * 0.1,Chara.HurtType.REAL,Chara.AtkType.EFF)
        else:
            masCha.hurtChara(self,1/(masCha.att.def + 1 * 0.01),Chara.HurtType.PHY,Chara.AtkType.EFF)

#滑头鬼系
#滑头鬼1
class ayouC_1:
    extends Buff
    func _init(lv):
        id = "ayouC_1"
        self.lv = lv
        attInit()
        att.atk = lv
        att.def = lv

#滑头鬼1长刀
class ayouC_1Ka:
    extends Buff
    func _init(lv):
        id = "ayouC_1Ka"
        self.lv = lv
        attInit()
        att.atk = lv

#滑头鬼2短刃
class ayouC_1Kn:
    extends Buff
    func _init(lv):
        id = "ayouC_1Kn"
        self.lv = lv
        attInit()
        att.spd = lv

#滑头鬼2云消雾散
#加闪避
class ayouC_2:
    extends Buff
    func _init(lv):
        id = "ayouC_2"
        self.lv = lv
        attInit()
        att.dod = lv

#滑头鬼L短刀
class ayouC_1St:
    extends Buff
    func _init(lv):
        id = "ayouC_1St"
        self.lv = lv
        attInit()
        att.cri = lv
        att.defR = lv/4

#妖狐系
#妖狐生命值buff或debuff
class ayouA_1M:
    extends Buff
    func _init(lv = 1.0, duration = 0):
        attInit()
        id = "b_atkR"	
        if lv < 0:
            isNegetive = true
        noLife = true
        life = duration
        if duration > 0:
            noLife = false
        att.hp = lv

#狐福
class foxluck:
    extends Buff
    func _init():
        attInit()
        id = "duwu_foxluck"
        att.dod = 0.05
    func init():
        pass
    func _connect():
        masCha.connect("onHurt",self,"run")
    func run(atkInfo:AtkInfo):
        if atkInfo.isMiss == true:
            masCha.attInfo.atk += 1
            masCha.attInfo.mgiAtk += 1
            masCha.upAtt()

#狐假虎威魔攻buff
class ayouA_1_2:
    extends Buff
    func _init(lv):
        id = "ayouA_1_2"
        self.lv = lv
        attInit()
        att.mgiAtk = lv

#九尾狐防御buff
class ayouA_1_1_1:
    extends Buff
    func _init(lv):
        id = "ayouA_1_1_1"
        self.lv = lv
        attInit()
        att.def = lv
