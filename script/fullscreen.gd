extends Node


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_fullscreen"):
		# 错误检查
		if not InputMap.has_action("toggle_fullscreen"):
			push_error("Action 'toggle_fullscreen' not defined in Input Map!")
			return
			
		var window := get_viewport().get_window()
		
		if window.mode != Window.MODE_EXCLUSIVE_FULLSCREEN:
			# 进入全屏
			window.mode = Window.MODE_EXCLUSIVE_FULLSCREEN
			window.current_screen = 0  # 主显示器
		else:
			# 退出全屏
			window.mode = Window.MODE_WINDOWED
			# 动态计算窗口尺寸
			var base_res := Vector2i(
				ProjectSettings.get_setting("display/window/size/viewport_width"),
				ProjectSettings.get_setting("display/window/size/viewport_height")
			)
			window.size = base_res * 2
			window.position = DisplayServer.screen_get_position(0) + (DisplayServer.screen_get_size(0) - window.size) / 2  # 居中
			
		# 更新标题反馈（调试时可启用）
		window.title = "Godot - %s [%sx%s]" % [
			"Fullscreen" if window.mode == Window.MODE_FULLSCREEN else "Windowed",
			window.size.x, window.size.y
		]
