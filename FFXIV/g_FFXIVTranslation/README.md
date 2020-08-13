# 主要翻译逻辑
1. 先新建出三个对应不同语言的`Translation`实例
```js
var Chinese = Translation.new()
Chinese.locale = "zh_CN"

var English = Translation.new()
English.locale = "en"

var Japanese = Translation.new()
Japanese.locale = "ja"
```

2. 在上面的`Translation`实例中添加翻译
```js
// Translation类中有个add_message()方法
// 第一个参数是 key {String} 通常是需要翻译的文本
// 第二个参数是 text {String} 这里是被翻译后的文本
Translation.add_message(key, text)
```

比如要把 "text" 翻译成 