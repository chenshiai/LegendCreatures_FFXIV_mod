extends Item
func init():
    name = "灭世者的死亡之帽"
    type = config.EQUITYPE_EQUI
    attInit()
    att.mgiAtk = 150
    #att.mgiAtkL = 0.3
    info = "唯一 - 灭世者:魔法攻击力增加40%"
    info += "\n技能攻击附加30%魔法伤害"
    
func _connect():
    sys.main.connect("onBattleStart",self,"run1")
    masCha.connect("onAtkChara",self,"run")
func run(atkInfo:AtkInfo):
    if atkInfo.atkType == Chara.AtkType.SKILL :
        masCha.hurtChara(atkInfo.hitCha,masCha.att.mgiAtk*0.3,Chara.HurtType.MGI,Chara.AtkType.EFF)
func run1():
    masCha.addBuff(w_mieshizhe.new())
    masCha.hasBuff("w_mieshizhe").n = 0.4

class w_mieshizhe extends Buff:
    var n setget set_n, get_n
    func set_n(val):
        n = val
    func get_n():
        return n
    func _init(lv = 1):
        attInit()
        effId = "p_diYu"
        life = lv
        id = "w_mieshizhe"
        isNegetive=true
    func init():
        pass
    func _upS():
        #print("灭世者的死亡之帽:%s" % n)
        att.mgiAtkL = n
    func _connect():
        pass
        
