class_name Matherial
extends Node


## Types of materials possible
enum TYPE {
	NONE, NUMBER, OPERATOR
}


## The 4 basic operators
enum OPERATOR {
	ADD, SUBTRACT, MULTIPLY, DIVIDE
}


## Translates operator enum to string
const OPERATOR_STRING = {
	OPERATOR.ADD: "+",
	OPERATOR.SUBTRACT: "−",
	OPERATOR.MULTIPLY: "×",
	OPERATOR.DIVIDE: "÷",
}


## Calculate a basic operation
static func calculate(argument1: int, operator: OPERATOR, argument2: int) -> int:
	match operator:
		OPERATOR.ADD:
			return argument1 + argument2
		OPERATOR.SUBTRACT:
			return argument1 - argument2
		OPERATOR.MULTIPLY:
			return argument1 * argument2
		OPERATOR.DIVIDE:
			if argument2 == 0:
				return 0
			else:
				return int(argument1 / float(argument2)) # Workaround to avoid warning
		_:
			push_error("Error: Matherial: calculate() unhandled operator")
			return -404


func _init(init_type: TYPE, init_content) -> void:
	type = init_type
	content = init_content


var type: TYPE	## Type of matherial
var content		## Content of matherial, matches with type
