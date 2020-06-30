extends Node
func _ready():
	pass
func _init():
	print("东方Project:Buff列表加载中...")
	config.bfDir["{束缚}"] = "无法攻击/移动/施法"
	config.bfDir["{充能}"] = "魔法伤害+6%,不可驱散"
	config.bfDir["{祈风}"] = "造成的伤害+10%,充能速度+50%,持续20秒"
	config.bfDir["{神迹}"] = "从以下效果中随机选取一种,持续7秒\n'每秒回复最大生命7%'\n'造成伤害时额外附加该伤害20%真伤'\n'受到伤害时有20%几率取消此伤害'"
	config.bfDir["{威严}"] = "每层减伤+4%.每当受到未减伤前伤害大于自身攻击的伤害时,有40%概率失去1层.不可驱散"
	config.bfDir["{命运颠倒}"] = "造成的伤害转变为回复,持续4次伤害"
	config.bfDir["{目}"] = "2秒后,对目标周围1圈的敌人造成一半的伤害"
	config.bfDir["{集气}"] = "每次攻击改为获得10点气且发动技能不消耗[气].不可驱散"
	config.bfDir["{坍缩}"] = "攻速降低300%,每次受到伤害,全部技能CD回退2秒"
	config.bfDir["{停滞}"] = "无法移动/攻击/施法,受到伤害变为0.结束时,以期间受到伤害的1.5倍进行伤害结算"
	config.bfDir["{混乱}"] = "伤害有50%概率产生波动,范围为80%-150%"
	config.bfDir["{冻结}"] = "攻速/充能速度-99%,技能造成的伤害全为9"
	config.bfDir["{恶戏}"] = "攻击/法强+55%,受到伤害时有15%概率减伤70%,不可驱散"
	config.bfDir["{扰乱}"] = "持有者使用CD技能时,对其造成400点真实伤害.触发后消除"
	config.bfDir["{燦}"] = "普攻和释放CD技能时,受到40点真实伤害"
	config.bfDir["{濡湿}"] = "所有技能CD回退2秒.充能速度-40%"
	config.bfDir["{月光墙}"] = "生成护盾抵抗伤害.护盾值为施法者法强150%"
	config.bfDir["{静默}"] = "无法使用CD技能"
	config.bfDir["{折镜}"] = "造成超过施法者法强的伤害会随机转嫁给友军,持续2次伤害"
	config.bfDir["{恋蝶}"] = "四秒后若持有者仍未死亡,则对其造成最大生命14%的真实伤害"
	config.bfDir["{永眠}"] = "每秒损失1.5%最大生命,若在期间死亡,则变为幽幽子亡灵为其作战10秒"
	config.bfDir["{自适应伤害}"] = "使用攻击/法强较高值进行计算,伤害类型为物理伤害"
	config.bfDir["{眩晕}"] = "无法攻击/移动/施法"
	config.bfDir["{幻想之音}"] = "自身其他技能附加的Buff的持续时间+3秒"
	config.bfDir["{高昂}"] = "攻速提高100% 每普攻10次持续时间+1秒"
	config.bfDir["{忧郁}"] = "普攻有60%概率落空,释放技能时,使自身全部技能CD回退4秒"
	config.bfDir["{隙间}"] = "所有技能会对距隙间最近的单位再次释放一次"
	config.bfDir["{永动}"] = "每秒对离自己最近的单位造成法强70%的魔法伤害.若以此法击杀目标,持续时间刷新"
	config.bfDir["{思绪}"] = "溢出的治疗量会转化为护盾,不可驱散"
	config.bfDir["{降神}"] = "[大妖怪の式]改为全伤害减免,吸血量变为60%,不可驱散"
	config.bfDir["{奇门}"] = "[不成熟の式]必定大成功,且造成2.5倍伤害,不可驱散"
	config.bfDir["{不老泉}"] = "每秒回复自身及1格内单位1.5%*层数的生命"
	config.bfDir["{不死药}"] = "前2秒每秒造成最大生命8%的真实伤害,后两秒回复当前生命12%的血量"
	config.bfDir["{药品}"] = "从以下效果中随机选取一种:\n回复最大生命20%\n全属性提高20%\n造成伤害提高20%\n受到伤害降低20%\n剧毒,全属性降低40%,损失当前生命值的一半.状态类效果均持续7秒"
	config.bfDir["{壶中天地}"] = "受到的超过222的伤害皆转变为222"
	config.bfDir["{迷惑}"] = "造成的伤害皆转变为0,并对随机友方单位造成等值伤害"
	config.bfDir["{满月}"] = "损失99%的双抗"
	config.bfDir["{狂气}"] = "附加时和每9秒,创造一个持续18秒的分身.此效果不受充能速度影响,不可驱散"
	config.bfDir["{催眠}"] = "无法移动/攻击/施法,每秒强制普攻离自己最近的目标(不论敌我)1次"
	config.bfDir["{流失}"] = "受到的伤害将在之后的3秒内缓慢流失,不会因此效果而致死"
	config.bfDir["{不死鸟}"] = "持续时间内每秒回复自身最大生命4%,且死亡时可以无视[蓬莱仙药]的复活次数复活,复活时亦不会消耗[蓬莱仙药]的复活次数"
	


	pass
func _connect():
	pass

#灵梦系
#束缚
class shufu:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "shufu"
		candel = true
		life = dur
	func _connect():
		masCha.aiOn = false
	func _upS():
		masCha.aiOn = false
	func _del():
		masCha.aiOn = true

#结界DB
class jiejiedown:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "jiejiedown"
		candel = true
		life = dur
	func _connect():
		masCha.connect("onAtkChara",self,"run")
	func run(atkInfo):
		atkInfo.hurtVal *= 0.7

#结界Buff
class jiejieup:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "jiejieup"
		candel = true
		life = dur
		att.cd += 0.5
	func _connect():
		masCha.connect("onHurt",self,"run")
	func run(atkInfo):
		atkInfo.hurtVal *= 0.7

#魔理沙系
#充能
class chongneng:
	extends Buff
	var step
	var candel
	func _init(dur = 1):
		attInit()
		id = "chongneng"
		candel = false
		step = dur
	func _connect():
		masCha.connect("onAtkChara",self,"run")
	func run(atkInfo):
		if masCha.atkInfo.hurtType == Chara.HurtType.MGI && atkInfo.atkCha == masCha:
			atkInfo.hurtVal *= 1.06* step


#早苗系
#奇迹1
class qiji1:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "qiji1"
		candel = true
		life = dur
	func _connect():
		pass
	func _upS():
		masCha.plusHp(masCha.att.maxHp * 0.07)
#奇迹2
class qiji2:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "qiji2"
		candel = true
		life = dur
	func _connect():
		masCha.connect("onAtkChara",self,"run")
		pass
	func run(atkInfo):
		if atkInfo.hurtType != Chara.HurtType.REAL && atkInfo.atkCha == masCha:
			masCha.hurtChara(atkInfo.hitCha,atkInfo.hurtVal * 0.2,Chara.HurtType.REAL,Chara.AtkType.EFF)

#奇迹3
class qiji3:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "qiji3"
		candel = true
		life = dur
	func _connect():
		masCha.connect("onHurt",self,"run")
		pass
	func run(atkInfo):
		if sys.rndPer(20):
			atkInfo.hurtVal = 0

#雷米系
#威严
class weiyan:
	extends Buff
	var step
	var candel
	var buye = false
	var tm = 0
	func _init(dur = 1):
		attInit()
		id = "weiyan"
		candel = false
		step = dur
	func _connect():
		masCha.connect("onHurt",self,"run")
	func run(atkInfo):
		if sys.rndPer(40) && buye == false && step > 0 && atkInfo.hurtVal > masCha.att.atk:
			eff = sys.newEff("numHit",masCha.position,false,1)
			eff.setText("大小姐又掉威严啦~","c12957")
			step -= 1
			if step <= 0:
				self.isDel = true
		atkInfo.hurtVal*=(1 - step * 0.03)
	func _upS():
		if buye == true:
			tm += 1
			if tm == 10:
				buye = false

#转换
class zhuanhuan:
	extends Buff
	var step
	var candel
	func _init(dur = 1):
		attInit()
		id = "zhuanhuan"
		candel = true
		step = dur
	func _connect():
		masCha.connect("onAtkChara",self,"run")
	func run(atkInfo):
		if step > 0 :
			step -= 1
			atkInfo.hitCha.plusHp(atkInfo.hurtVal)
			atkInfo.hurtVal = 0
		else:
			self.isDel = true
#芙兰
#波纹
class bowen:
	extends Buff
	var candel
	var cascha
	var cashurt
	func _init(dur = 1, cast = null, hurt = 0):
		attInit()
		id = "bowen"
		candel = true
		life = dur
		cascha = cast
		cashurt = hurt
	func _del():
		var chas = masCha.getAllChas(2)
		var mv = Vector2(masCha.cell.x,masCha.cell.y)
		var around = [Vector2(0,1),Vector2(1,1),Vector2(1,0),Vector2(1,-1),Vector2(0,-1),Vector2(-1,-1),Vector2(-1,0),Vector2(-1,1)]
		for i in around:
			var v = mv + i
			if masCha.matCha(v) != null:
				var tarcha = masCha.matCha(v)
				cascha.hurtChara(tarcha,cashurt * 0.5,Chara.HurtType.REAL,Chara.AtkType.SKILL)

#四重存在
class fourself:
	extends Buff
	var candel
	var systool = null
	func _init(dur = 1):
		attInit()
		id = "fourself"
		candel = false
		life = dur
	func _connect():
		systool = sys.main.newChara("cex___THBaseCha",1)
		masCha.connect("onAtkChara",self,"run")
		pass
	func run(atkInfo):
		if atkInfo.hurtType == Chara.HurtType.REAL && atkInfo.atkCha == masCha:
			for i in range(4):
				systool.hurtChara(atkInfo.hitCha,atkInfo.hurtVal,Chara.HurtType.REAL,Chara.AtkType.SKILL)
		elif atkInfo.hurtType == Chara.HurtType.PHY && atkInfo.atkCha == masCha:
			for i in range(4):
				systool.hurtChara(atkInfo.hitCha,atkInfo.hurtVal,Chara.HurtType.PHY,Chara.AtkType.SKILL)
		elif atkInfo.hurtType == Chara.HurtType.MGI && atkInfo.atkCha == masCha:
			for i in range(4):
				systool.hurtChara(atkInfo.hitCha,atkInfo.hurtVal,Chara.HurtType.MGI,Chara.AtkType.SKILL)

#美玲
#集气
class jiqi:
	extends Buff
	var candel
	var systool = null
	func _init(dur = 1):
		attInit()
		id = "qiji"
		candel = false
		life = dur
	func _connect():
		pass
#16
#坍缩
class tansuo:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "tansuo"
		candel = true
		life = dur
		att.spd -= 3
	func _connect():
		masCha.connect("onHurt",self,"run")
		pass
	func run(atkInfo):
		for i in masCha.skills:
			i.nowTime -= 2

#停滞
class tingzhi:
	extends Buff
	var candel
	var lastdamage
	var hurtall = []
	var cascha
	var on = true
	func _init(dur = 1, last = 0, cast = null):
		attInit()
		id = "tingzhi"
		candel = false
		life = dur
		lastdamage = last
		cascha = cast
	func _connect():
		masCha.connect("onHurt",self,"run")
		pass
	func _upS():
		for i in masCha.skills:
			i.nowTime -= 1
	func run(atkInfo):
		if on ==true:
			hurtall.appent(atkInfo.hurtVal)
			atkInfo.hurtVal = 0
	func del():
		if life > 0:
			var newBF = masCha.addBuff(tingzhi.new(life))
			newBF.hurtall = self.hurtall
			newBF.lastdamage = self.lastdamage
		else:
			var chas = masCha.getAllChas(1)
			for i in chas :
				if i == cascha && i.isDeath == false:
					lastdamage += i.att.mgiAtk * i.feidao * 0.08
			on = false
			for i in hurtall:
				masCha.hurtChara(masCha,i,Chara.HurtType.REAL,Chara.AtkType.EFF)
			cascha.hurtChara(masCha,lastdamage * 1.5,Chara.HurtType.PHY,Chara.AtkType.SKILL)

#琪露诺
#混乱
class hunluan:
	extends Buff
	var candel
	func _init():
		attInit()
		id = "hunluan"
		candel = false
	func _connect():
		masCha.connect("onAtkChara",self,"run")
		pass
	func run(atkInfo):
		if sys.rndPer(50):
			atkInfo.hurtVal *= sys.rndListItem(range(79,160)) * 0.01


#冻结
class dongjie:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "dongjie"
		candel = true
		att.spd -= 0.99
		att.cd -= 0.99
		life = dur
	func _connect():
		masCha.connect("onAtkChara",self,"run")
		pass
	func run(atkInfo):
		if atkInfo.atkType == Chara.AtkType.SKILL && atkInfo.atkCha == masCha:
			atkInfo.hurtVal = 9

#三月精共通
#恶戏
class exi:
	extends Buff
	var candel
	var tarcha
	func _init():
		attInit()
		id = "exi"
		candel = false
		att.atkL += 0.35
		att.mgiAtkL += 0.35
	func _connect():
		masCha.connect("onHurt",self,"run")
		pass
	func run(atkInfo):
		if sys.rndPer(15):
			atkInfo.hurtVal *= 0.3

#斯塔
#扰乱
class raoluan:
	extends Buff
	var candel
	var cascha
	func _init(cast = null):
		attInit()
		id = "raoluan"
		candel = false
		cascha = cast
	func _connect():
		masCha.connect("onCastCdSkill",self,"run")
		pass
	func run(id):
		cascha.hurtChara(masCha,400,Chara.HurtType.REAL,Chara.AtkType.SKILL)
		self.isDel = true

#灿
class canlan:
	extends Buff
	var candel
	var cascha
	func _init(dur = 1, cast = null):
		attInit()
		id = "canlan"
		candel = false
		life = dur
		cascha = cast
	func _connect():
		masCha.connect("onCastCdSkill",self,"run")
		masCha.connect("onAtkChara",self,"run1")
		pass
	func run(id):
		cascha.hurtChara(masCha,40,Chara.HurtType.REAL,Chara.AtkType.SKILL)
	func run1(atkInfo):
		cascha.hurtChara(masCha,40,Chara.HurtType.REAL,Chara.AtkType.SKILL)

#露娜
#濡湿
class rushi:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "rushi"
		candel = true
		life = dur
		att.cd -= 0.4
	func _connect():
		for i in masCha.skills:
			i.nowTime -= 2

#月光墙
class yueguang:
	extends Buff
	var candel
	var shield = 0
	func _init(dur = 0):
		attInit()
		id = "yueguang"
		candel = true
		shield = dur
	func _connect():
		masCha.connect("onHurt",self,"run")
	func run(atkInfo):
		if shield > atkInfo.hurtVal:
			shield -= atkInfo.hurtVal
			atkInfo.hurtVal = 0
			eff = sys.newEff("numHit",masCha.position,false,1)
			eff.setText("护盾:%d"%[shield],"#ffffff")
		elif shield == atkInfo.hurtVal:
			atkInfo.hurtVal = 0
			shield = 0
			eff = sys.newEff("numHit",masCha.position,false,1)
			eff.setText("护盾已全部消耗！","#ffffff")
			self.isDel = true
		elif shield < atkInfo.hurtVal:
			atkInfo.hurtVal -= shield
			shield = 0
			eff = sys.newEff("numHit",masCha.position,false,1)
			eff.setText("护盾已全部消耗！","#ffffff")
			self.isDel = true

#静默
class jingmo:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "jingmo"
		candel = true
		life = dur
		att.cd -= 0.4
	func _connect():
		for i in masCha.skills:
			if i.nowTime >= i.cd - 1:
				i.nowTime -= 1
	func _upS():
		for i in masCha.skills:
			if i.nowTime >= i.cd - 1:
				i.nowTime -= 1

#桑尼
#zhejing
class zhejing:
	extends Buff
	var candel
	var casmgi
	var count = 2
	func _init(dur = 0):
		attInit()
		id = "zhejing"
		candel = true
		casmgi = dur
	func _connect():
		masCha.connect("onAtkChara",self,"run")
	func run(atkInfo):
		if  atkInfo.hurtVal >= casmgi && count > 0:
			count -= 1
			var chas = masCha.getAllChas(2)
			var tarcha = sys.rndListItem(chas)
			masCha.hurtChara(tarcha,atkInfo.hurtVal,Chara.HurtType.REAL,Chara.AtkType.SKILL)
			atkInfo.hurtVal = 0
			if count == 0:
				self.isDel = true

#幽幽子
#恋蝶
class liandie:
	extends Buff
	var candel
	var cascha = null
	func _init(dur = 0, cast = null):
		attInit()
		id = "liandie"
		candel = true
		life = dur
		cascha = cast
	func _del():
		if masCha.isDeath == false:
			cascha.hurtChara(masCha,masCha.att.maxHp * 0.14,Chara.HurtType.REAL,Chara.AtkType.SKILL)

#永眠
class yongmian:
	extends Buff
	var candel
	var cascha = null
	func _init(dur = 0, cast = null):
		attInit()
		id = "yongmian"
		candel = true
		cascha = cast
	func _connect():
		masCha.connect("onDeath",self,"run")
	func run(atkInfo):
		yield(sys.get_tree().create_timer(0.1),"timeout")
		if masCha.isDeath == true:
			var newcha = cascha.newChara(masCha.id,cascha.cell)
			if newcha != null:
				if cascha.team == 1:
					newcha.team = 1
				else:
					newcha.team = 2
			var bf = newcha.addBuff(busiren.new(10))
			bf.wudiS = false
	func _upS():
		cascha.hurtChara(masCha,masCha.att.maxHp * 0.015,Chara.HurtType.REAL,Chara.AtkType.SKILL)

#妖梦
#无敌
class wudi:
	extends Buff
	var candel
	func _init():
		attInit()
		id = "wudi"
		candel = true
	func _connect():
		masCha.connect("onHurtEnd",self,"run")
	func run(atkInfo):
		atkInfo.hurtVal = 0

#骚灵
#幻想之音
class huanxiang:
	extends Buff
	var candel
	func _init():
		attInit()
		id = "huanxiang"
		candel = true

#高昂
class gaoang:
	extends Buff
	var candel
	var tm = 0
	func _init(dur = 1):
		attInit()
		id = "gaoang"
		candel = true
		att.spd += 1
		life = dur
	func _connect():
		masCha.connect("onAtkChara",self,"run")
	func run(atkInfo):
		tm += 1
		if tm >= 10:
			tm = 0
			life += 1

#忧郁
class youyu:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "youyu"
		candel = true
		life = dur
	func _connect():
		masCha.connect("onAtkChara",self,"run")
		masCha.connect("onCastCdSkill",self,"run1")
	func run(atkInfo):
		if sys.rndPer(60):
			atkInfo.isMiss = true
			atkInfo.hurtVal = 0
	func run1(id):
		for i in masCha.skills:
			i.nowTime -= 4

#八云紫
#永动
class yongdong:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "yongdong"
		candel = true
		life = dur
	func _upS():
		masCha.hurtChara(masCha.aiCha,masCha.att.mgiAtk * 0.75,Chara.HurtType.MGI,Chara.AtkType.SKILL)
		if masCha.aiCha.isDeath == true:
			life = 6

#八云蓝
#思绪
class sixu:
	extends Buff
	var shield = 0
	var candel
	func _init():
		attInit()
		id = "sixu"
		candel = false
	func _connect():
		masCha.connect("onPlusHp",self,"run")
		masCha.connect("onHurt",self,"run1")
	func run(val):
		if masCha.att.hp + val > masCha.att.maxHp:
			shield += (masCha.att.hp + val - masCha.att.maxHp)
	func run1(atkInfo):
		if shield > atkInfo.hurtVal:
			shield -= atkInfo.hurtVal
			atkInfo.hurtVal = 0
			eff = sys.newEff("numHit",masCha.position,false,1)
			eff.setText("护盾:%d"%[shield],"#ffffff")
		elif shield == atkInfo.hurtVal:
			atkInfo.hurtVal = 0
			shield = 0
			eff = sys.newEff("numHit",masCha.position,false,1)
			eff.setText("护盾已消耗！","#ffffff")
			self.isDel = true
		elif shield < atkInfo.hurtVal:
			atkInfo.hurtVal -= shield
			shield = 0
			eff = sys.newEff("numHit",masCha.position,false,1)
			eff.setText("护盾已消耗！","#ffffff")
			self.isDel = true

#降神
class jiangshen:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "jiangshen"
		candel = false
		life = dur


#橙
#奇门
class qimen:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "qimen"
		candel = false
		life = dur


#辉夜
#龙玉附加属性
class longyu:
	extends Buff
	var step
	var candel
	func _init(dur = 1):
		attInit()
		id = "longyu"
		candel = false
		step = dur
		att.atk += step
		att.def += step
		att.mgiAtk += step
		att.mgiDef += step

#不老泉
class bulao:
	extends Buff
	var step
	var candel
	func _init(dur = 1, nowlv = 1):
		attInit()
		id = "bulao"
		candel = true
		life = dur
		step = nowlv
	func _upS():
		var chas = masCha.getCellChas(masCha.aiCha.cell,1,2)
		for i in chas:
			i.plusHp(i.att.maxHp * step * 0.015)

#不老泉
class busiyao:
	extends Buff
	var cascha
	var candel
	var tm = 0
	func _init(dur = 1, cast = null):
		attInit()
		id = "busiyao"
		candel = true
		life = dur
		cascha = cast
	func _upS():
		tm += 1
		if tm <= 2:
			cascha.hurtChara(masCha,masCha.att.maxHp * 0.08,Chara.HurtType.REAL,Chara.AtkType.SKILL)
		else:
			masCha.plusHp(masCha.att.hp * 0.12)

#永琳
#药品加全属性
class yaopinup:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "yaopinupu"
		candel = true
		life = dur
		att.atkL += 0.2
		att.defL += 0.2
		att.mgiAtkL += 0.2
		att.mgiDefL += 0.2

#药品加伤害
class yaopindam:
	extends Buff
	var candel
	func _init(dur = 0):
		attInit()
		id = "yaopindam"
		candel = true
		life = dur
	func _connect():
		masCha.connect("onAtkChara",self,"run")
	func run(atkInfo):
		atkInfo.hurtVal *= 1.2

#药品减伤
class yaopinhurt:
	extends Buff
	var candel
	func _init(dur = 0):
		attInit()
		id = "yaopinhurt"
		candel = true
		life = dur
	func _connect():
		masCha.connect("onHurt",self,"run")
	func run(atkInfo):
		atkInfo.hurtVal *= 0.8

#药品剧毒
class yaopindown:
	extends Buff
	var candel
	func _init(dur = 0):
		attInit()
		id = "yaopindown"
		candel = true
		life = dur
		att.atkL -= 0.2
		att.defL -= 0.2
		att.mgiAtkL -= 0.2
		att.mgiDefL -= 0.2

#壶中天地
class yinhe:
	extends Buff
	var candel
	func _init(dur = 0):
		attInit()
		id = "yinhe"
		candel = true
		life = dur
	func _connect():
		masCha.connect("onHurtEnd",self,"run")
	func run(atkInfo):
		if atkInfo.hurtVal > 222:
			atkInfo.hurtVal = 222

#友军死亡召唤物Buff
class busiren:
	extends Buff
	var candel
	var wudiS = true
	func _init(dur = 1):
		attInit()
		id = "busiren"
		candel = true
		life = dur
	func _connect():
		masCha.connect("onHurt",self,"run")
	func run(atkInfo):
		if wudiS == true:
			atkInfo.hurtVal = 0
	func _del():
		masCha.att.hp = -1000
		masCha.hurtChara(masCha,0,Chara.HurtType.REAL,Chara.AtkType.EFF)

#铃仙
#迷惑
class mihuo:
	extends Buff
	var candel
	var tarcha
	func _init(dur = 0):
		attInit()
		id = "mihuo"
		candel = true
		life = dur
	func _connect():
		masCha.connect("onAtkChara",self,"run")
	func run(atkInfo):
		if atkInfo.hitCha != tarcha:
			var chas = masCha.getAllChas(2)
			if chas.size() > 1:
				#print(1)
				#print(atkInfo.hurtVal)
				while true:
					tarcha = sys.rndListItem(chas)
					if tarcha != masCha:
						break
				#print(tarcha.chaName)
				masCha.hurtChara(tarcha,atkInfo.hurtVal,Chara.HurtType.REAL,Chara.AtkType.EFF)
				atkInfo.hurtVal = 0


#满月
class manyue:
	extends Buff
	var candel
	func _init(dur = 0):
		attInit()
		id = "manyue"
		candel = true
		life = dur
		att.def -= 0.99
		att.mgiDefL -= 0.99
		if att.def <= 0 :
			att.def = 1
		if att.mgiDef <= 0:
			att.mgiDef = 1

#狂气
class kuangqi:
	extends Buff
	var tm = 0
	var candel
	func _init():
		attInit()
		id = "kuangqi"
		candel = true
	func _connect():
		var newC = masCha.newChara(masCha.id,masCha.cell)
		newC.addBuff(huanxiangtime.new(18))
	func _upS():
		tm += 1
		if tm >= 9:
			tm = 0
			var newC = masCha.newChara(masCha.id,masCha.cell)
			newC.addBuff(huanxiangtime.new(18))

#狂气召唤物Buff
class huanxiangtime:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "huanxiangtime"
		candel = true
		life = dur
	func _del():
		masCha.att.hp = -1000
		masCha.hurtChara(masCha,0,Chara.HurtType.REAL,Chara.AtkType.EFF)

#催眠
class cuimian:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "cuimian"
		candel = true
		life = dur
	func _connect():
		masCha.aiOn = false
	func _upS():
		masCha.aiOn = false
		var chas = masCha.getAllChas(0)
		chas.sort_custom(self,"sort")
		masCha.normalAtkChara(chas[0])
	func sort(a,b):
		if masCha.cellRan(a.cell,masCha.cell) < masCha.cellRan(b.cell,masCha.cell) :
			return true
		return false
	func _del():
		masCha.aiOn = true

#妹红
#不死鸟
class businiao:
	extends Buff
	var candel
	func _init(dur = 1):
		attInit()
		id = "businiao"
		candel = false
		life = dur
	func _connect():
		masCha.connect("onDeath",self,"run")
	func runc(atkInfo):
		masCha.isDeath = false
		masCha.att.hp = 1
		masCha.plusHp(masCha.att.maxHp * 1)
	func _upS():
		masCha.plusHp(masCha.att.maxHp * 0.04)
