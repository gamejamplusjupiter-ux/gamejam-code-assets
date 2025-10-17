extends CanvasLayer

func change_scene(target: String, type: String = 'dissolve') -> void:
	match type:
		'dissolve':
			transition_dissolve(target)
		'clouds':
			transition_clouds(target)
		_:
			push_warning("Tipo de transição desconhecido: %s" % type)
			transition_dissolve(target)

func transition_dissolve(target: String) -> void:
	$AnimationPlayer.play('dissolve')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards('dissolve')

func transition_clouds(target: String) -> void:
	$AnimationPlayer.play('clouds_in')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play('clouds_out')

## Transição padrão (dissolve)
#$SceneTransition.change_scene("res://Cena2.tscn")

# Transição de nuvens, ou outros parametros que formos usar
#$SceneTransition.change_scene("res://Cena3.tscn", "clouds")
