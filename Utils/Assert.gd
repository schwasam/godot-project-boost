class_name Assert

extends Object


static func error_ok(error: Error) -> void:
	assert(error == Error.OK)


static func string_not_empty(value: String) -> void:
	assert(value != null and value != "")
