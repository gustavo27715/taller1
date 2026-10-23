extends GdUnitTestSuite

const GlobalManagerScript = preload("res://src/core/global_manager.gd")

var manager

func before_test() -> void:
	manager = GlobalManagerScript.new()

func after_test() -> void:
	manager.free()

# --- get_plate_available_budget ---

func test_budget_positive_case() -> void:
	manager.monthly_budget = 20000
	manager.spent_total = 5000
	manager.plate_total = 3000
	assert_int(manager.get_plate_available_budget()).is_equal(12000)

func test_budget_negative_case_plate_exceeds_budget() -> void:
	manager.monthly_budget = 20000
	manager.spent_total = 0
	manager.plate_total = 25000
	assert_int(manager.get_plate_available_budget()).is_equal(-5000)

func test_budget_limit_case_exactly_zero() -> void:
	manager.monthly_budget = 20000
	manager.spent_total = 15000
	manager.plate_total = 5000
	assert_int(manager.get_plate_available_budget()).is_equal(0)

# --- get_plate_stats ---

func test_plate_stats_positive_case_two_foods() -> void:
	manager.plate_selection = {"left": "carne", "right": "tocino"}
	assert_dict(manager.get_plate_stats()).is_equal(
		{"salud": 1, "velocidad": 3, "salto": 2, "energia": 14})

func test_plate_stats_negative_case_unknown_food() -> void:
	manager.plate_selection = {"left": "xyz", "right": ""}
	assert_dict(manager.get_plate_stats()).is_equal(
		{"salud": 0, "velocidad": 0, "salto": 0, "energia": 0})

func test_plate_stats_limit_case_one_half_only() -> void:
	manager.plate_selection = {"left": "carne", "right": ""}
	assert_dict(manager.get_plate_stats()).is_equal(
		{"salud": 3, "velocidad": 1, "salto": 2, "energia": 8})
