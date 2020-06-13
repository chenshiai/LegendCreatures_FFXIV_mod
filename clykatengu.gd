extends Chara
#覆盖的初始化
func _info():
    pass
#继承的初始化，技能描述在这里写，保留之前的技能描述
func _extInit():
    ._extInit()#保留继承的处理
    chaName = "天狗"
    attCoe.atkRan = 2
    attCoe.maxHp = 3
    attCoe.atk = 5
    attCoe.mgiAtk = 2
    attCoe.def = 4
    attCoe.mgiDef = 1
    lv = 1
    evos = ["clykatengu_1","clykatengu_2"] #可以升级到的生物id
    atkEff = "atk_dao"
    addCdSkill("crowsum",5)#添加cd技能
    addSkillTxt("暗夜之砾：每5秒召唤一只乌鸦突袭敌人造成100%攻击力的伤害  —— Tengu  by  Lyka")
#进入战斗初始化，事件连接在这里初始化
func _connect():
    ._connect() #保留继承的处理

var vs = [Vector2(-1,-1),Vector2(0,-1),Vector2(1,-1),Vector2(2,-1),Vector2(3,-1),Vector2(4,-1),Vector2(5,-1),Vector2(6,-1),Vector2(7,-1),Vector2(8,-1),Vector2(-1,0),Vector2(-1,1),Vector2(-1,2),Vector2(-1,3),Vector2(-1,4),Vector2(-1,5),Vector2(0,5),Vector2(1,5),Vector2(2,5),Vector2(3,5),Vector2(4,5),Vector2(5,5),Vector2(6,5),Vector2(7,5),Vector2(8,5),Vector2(8,4),Vector2(8,3),Vector2(8,2),Vector2(8,1),Vector2(8,0)]    
var poi
var im
var image
var crowimg

func _castCdSkill(id):
    ._castCdSkill(id)
    if id == "crowsum" && aiCha != null:
        var crow = newChara("cex___lykacrow",aiCha.cell)
        var pos = sys.main.map.map_to_world(aiCha.cell)
        ying(image,pos)
        crow.hurtChara(aiCha,att.atk * 1,Chara.HurtType.PHY,Chara.AtkType.SKILL)
        crow.aiCha = aiCha

func ying(chaImage,pos):
    poi = vs[sys.rndRan(0,vs.size() - 1)] * 100
    var l:Vector2 = pos - poi
    var s = 25
    var rs = preload("res://core/ying.tscn")
    var n = l.length()/s
    for i in range(n):
        var spr = rs.instance()
        sys.main.map.add_child(spr)
        spr.texture = chaImage.texture_normal
        spr.position = poi + s * (i+1) * l.normalized() - Vector2(chaImage.texture_normal.get_width()/2,chaImage.texture_normal.get_height())
        spr.init(255/n * i + 100)
        
func _onBattleStart():
    ._onBattleStart()
    var path = self.direc
    im = Image.new()
    image = TextureButton.new()
    crowimg = ImageTexture.new()
    im.load(path + "/cex___lykacrow/cha.png")
    crowimg.create_from_image(im)
    image.texture_normal = crowimg        