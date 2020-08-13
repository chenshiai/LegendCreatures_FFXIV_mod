# 最终幻想14MOD 自定义类
该目录下的脚本，不与全局类同时加载，  
而是在Utils类加载中获取引用地址，在需要的时候从Utils里面new出来就可以使用
例如
```js
var Chant = Utils.FFXIVClass.Chant.new()
```
