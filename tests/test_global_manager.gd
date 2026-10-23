extends GdUnitTestSuite

const GlobalManagerScript = preload("res://src/core/global_manager.gd")

var manager

func before() -> void:
	manager = GlobalManagerScript.new()

func after() -> void:
	manager.free()

# coupons es Array[Dictionary] (tipado): se arma el array con tipo antes de asignarlo
func _set_coupons(list: Array) -> void:
	var typed: Array[Dictionary] = []
	for c in list:
		typed.append(c)
	manager.coupons = typed

func test_returns_coupon_when_subtotal_is_sufficient() -> void:
	_set_coupons([{"value": 2000, "minimum_purchase": 10000}])
	var result = manager.get_best_coupon(12000)
	assert_dict(result).is_equal({"value": 2000, "minimum_purchase": 10000})

func test_returns_empty_dictionary_when_no_coupon_is_valid() -> void:
	_set_coupons([{"value": 2000, "minimum_purchase": 10000}])
	var result = manager.get_best_coupon(9999)
	assert_dict(result).is_empty()

func test_returns_coupon_with_highest_value() -> void:
	_set_coupons([
		{"value": 1000, "minimum_purchase": 5000},
		{"value": 3000, "minimum_purchase": 10000}
	])
	var result = manager.get_best_coupon(12000)
	assert_dict(result).is_equal({"value": 3000, "minimum_purchase": 10000})
