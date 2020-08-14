const BaseElement = {
	"Pu": {
		"name": "钚",
		"max": 500,
		"price": 41,
	},
	"C": {
		"name": "碳",
		"max": 500,
		"price": 6.9,
	},
	"Pt": {
		"name": "铂",
		"max": 500,
		"price": 56,
	},
	"Fe": {
		"name": "铁",
		"max": 500,
		"price": 13.8,
	},
	"Ti": {
		"name": "钛",
		"max": 500,
		"price": 61.9,
	},
	"Na": {
		"name": "纳",
		"max": 500,
		"price": 53,
	},
	"Au": {
		"name": "金",
		"max": 500,
		"price": 220,
	},
	"Ag": {
		"name": "银",
		"max": 500,
		"price": 170,
	},
	"Cu": {
		"name": "铜",
		"max": 500,
		"price": 110,
	},
	"Al": {
		"name": "铝",
		"max": 500,
		"price": 165,
	},
	"Ni": {
		"name": "镍",
		"max": 500,
		"price": 137,
	},
}

# 返回基础元素字典
static func get_element():
	return BaseElement


# 设置元素的最大存储量
static func set_element_max(element_id, value):
	if BaseElement.has(element_id):
		BaseElement[element_id].max = value
		return true
	return false


# 设置元素出售的单价
static func set_element_price(element_id, value):
	if BaseElement.has(element_id):
		BaseElement[element_id].price = value
		return true
	return false


# 根据id来获取元素当前的数据
static func get_element_info(element_id):
	return BaseElement[element_id]