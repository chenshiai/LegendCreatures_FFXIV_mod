# 最终幻想14 mod
## 生物分支
- cFFXIVAolong 敖龙  
  ├──cFFXIVAolong_1 暗黑骑士 强大的魔法抵抗 希德勒格-传奇  
  ├──cFFXIVAolong_2 武士 自嗨单体物理输出 飞燕-传奇  
  ├──cFFXIVAolong_3 忍者 工具人 夕雾-传奇

- cFFXIVHumen 人族  
  ├──cFFXIVHumen_1 战士 标准公式光，配合奶妈电梯坐电梯 阿尔伯特-传奇  
  ├──cFFXIVHumen_2 绝枪战士 俄罗斯轮盘赌 桑克瑞德-传奇  
  ├──cFFXIVHumen_3 舞者 提高自嗨队友的输出 娜休梅拉-传奇  

- cFFXIVLarafel 拉拉肥  
  ├──cFFXIVLarafel_1 白魔 奶量巨大 嘉恩·艾·神纳-传奇  
  ├──cFFXIVLarafel_2 黑魔 魔法输出爆炸 帕帕力莫-传奇  
  ├──cFFXIVLarafel_3 赤魔 魔法/物理输出切换 西·如恩·提亚-传奇  

- cFFXIVNeko 猫魅  
  ├──cFFXIVNeko_1 学者 护盾减伤应有尽有，就是莫得奶 阿尔菲诺-传奇  
  ├──cFFXIVNeko_2 召唤 召唤蛮神 雅·蜜特拉-传奇  
  ├──cFFXIVNeko_3 诗人 buff管理者 让泰尔-传奇

- cFFXIVRuga 鲁加  
  ├──cFFXIVRuga_1 骑士 能抗能打，还能奶人 杰林斯-传奇  
  ├──cFFXIVRuga_2 武僧 比较能抗的单体物理输出 维达盖尔特-传奇  
  ├──cFFXIVRuga_3 机工 野火信仰biubiubiu 希尔达-传奇

- cFFXIVSpirit 精灵  
  ├──cFFXIVSpirit_1 占星术士-白 白天垃圾分类 蕾薇瓦-传奇  
  ├──cFFXIVSpirit_2 占星术士-夜 晚上垃圾分类  
  ├──cFFXIVSpirit_3 龙骑士 脆如纸的群体物理输出 埃斯蒂尼安-传奇  

## 文件结构
### 全局对象（游戏开始时实例化一次并放在全局变量 globalData.infoDs 中）
- g_aFFXIVUtils 主要工具
- g_bFFXIVText 全局文本
- g_FFXIVBuffList 绝大多数Buff效果在这里定义
- g_FFXIVChara 与角色相关的操作（比如单位的新增，目前作为讨伐战设置用
- g_FFXIVRetreat 【退避】的机制与逻辑实现
- g_FFXIVSoulSkill 装备【灵魂水晶】的机制与实现

### 自建对象（不在游戏开始时实例化一次，在需要的时候要主动创建）
- BaseClass 基础对象，在这里统一引入上面的全局对象，给下面的对象使用
- BossHpBar boss血条对象，用来创建一个血条显示在屏幕上方
- Chant 咏唱条对象，用来创建一个咏唱进度条
- Control 主控制器对象
- Crusade 讨伐设置面板对象
- Keyboard 键盘监听对象，开启FFXIV专用的键盘监听
- LimitBreak 极限技对象，创建极限技条，并实现相关技能
- musicControl 音乐控制器对象，用来控制mod的音乐播放
- FFXIVClass 导出对象，将上述全部对象整合起来交给`Utils`使用

