class_name GameEffectGiveMaterials
extends GameEffect


@export var material_type: Matherial.TYPE
@export var material_content_num: int
@export var material_content_op: Matherial.OPERATOR


## Gives a material
func execute(context: GameEffectContext):
	match material_type:
		# Give number
		Matherial.TYPE.NUMBER:
			if not material_content_num:
				material_content_num = randi_range(0, 9)
			context.inventory.add_material(Matherial.TYPE.NUMBER, material_content_num)
		
		# Give Operator
		Matherial.TYPE.OPERATOR:
			if not material_content_op:
				material_content_op = randi_range(0, Matherial.OPERATOR.size()) as Matherial.OPERATOR
			context.inventory.add_material(Matherial.TYPE.OPERATOR, material_content_op)
		
		# Randomly give number or operator
		_:
			match randi_range(0, 1):
				0:
					material_content_num = randi_range(0, 9)
					context.inventory.add_material(Matherial.TYPE.NUMBER, material_content_num)
				1:
					material_content_op = randi_range(0, Matherial.OPERATOR.size() - 1) as Matherial.OPERATOR
					context.inventory.add_material(Matherial.TYPE.OPERATOR, material_content_op)
