func format(text, config = {}):
  var Text = text.format(self.Config)
  return Text.format(config)

var Config = {
  "TMgiDam": "[color=%s]魔法伤害[/color]" % [COLOR.MGI],
  "TPhyDam": "[color=%s]物理伤害[/color]" % [COLOR.PHY],
  "TRealDam": "[color=%s]真实伤害[/color]" % [COLOR.REAL],
  "TPhy": "[color=%s]攻击[/color]" % [COLOR.PHY],
  "TMgi": "[color=%s]魔攻[/color]" % [COLOR.MGI],
  "TPassive": "[color=%s]被动[/color]" % [COLOR.PASSIVE],
  "TRegen": "[color=%s]回复[/color]" % [COLOR.REGEN],
  "TPhyDef": "[color=%s]物理防御[/color]" % [COLOR.PHYDEF],
  "TMgiDef": "[color=%s]魔法防御[/color]" % [COLOR.MGIDEF],
  "TDefR": "[color=%s]所有伤害[/color]" % [COLOR.DEFR],
  "TSup":"[color=%s]支援[/color]" % [COLOR.SUP],
  "TImm":"[color=%s]免疫[/color]" % [COLOR.IMMUNE],
  "TLS":"[color=%s]吸血[/color]" % [COLOR.BLOOD],
  "blizzard":"[color=%s]暴风雪[/color]" % [COLOR.IMMUNE],
  "blizzard_s":"[color=%s]强暴风雪[/color]" % [COLOR.IMMUNE],
  "sandstorm":"[color=#ecd540]沙尘暴[/color]",
  "mist":"[color=#b4bbb4]雾[/color]",
  "mist_s":"[color=#b4bbb4]迷雾[/color]",
  "mist_c":"[color=%s]血雾[/color]" % [COLOR.BLOOD],
  "mist_n":"[color=%s]瘴雾[/color]" % [COLOR.POISON],
  "heatwave":"[color=%s]热浪[/color]" % [COLOR.FIRE],
  "heatwave_s":"[color=%s]强热浪[/color]" % [COLOR.FIRE],
  "darknight":"[color=%s]暗夜[/color]" % [COLOR.DARK]

}

const COLOR = {
  "PHY": "#ff7522",
  "MGI": "#09dce3",
  "PASSIVE": "#e5e5e5",
  "REAL": "#ffffff",
  "REGEN": "#17eba1",
  "PHYDEF":"#e3b409",
  "MGIDEF":"#c870ff",
  "DEFR":"#ededed",
  "SUP":"#1385f0",
  "IMMUNE":"#ebebee",
  "BLOOD":"#8a0303",
  "POISON":"#40fd14",
  "FIRE":"#e25822",
  "DARK":"#000000"

}
