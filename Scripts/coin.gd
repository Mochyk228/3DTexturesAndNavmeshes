extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	Global.score += 1
	if Global.coins_pos.has(global_position):
		Global.coins_pos.erase(global_position)
		Global.coin_collected.emit(global_position)
	queue_free()
