Double jump:
	- Berikan perhitungan limit berapa kali ia bisa jump (2 kali)
	- Pastikan krn double jump tidak dilakukan di floor, hanya jumlah jump yang direset, tapi bisa loncat di atas.
	- Ubah animasi saat melompat
	- Animasi dibuat oleh Alizza Deli Satria saat lomba Gemastik 2024, karena rindu akhirnya saya pakai lagi (Terima kasih Lisa dan Daril) 
	
	- if Input.is_action_just_pressed('ui_up') and jumps_left > 0:
		velocity.y = jump_speed
		jumps_left -= 1
		sprite_2d.animation = "jump"
	- if is_on_floor():
		jumps_left = max_jumps
		
Dashing:
	- Kalau tap interval > Time.get_ticks_msec() / 1000.0 - tap time, status dash bisa diaktifkan
	- Diberikan waktu limit dash, kalau waktunya selesai, kembali lagi ke status biasa.
	
	- 	if dashing:
		dash_time_left -= delta
		if dash_time_left <= 0:
			dashing = false 
		
	- 		if Input.is_action_just_pressed("ui_left"):
			var now = Time.get_ticks_msec() / 1000.0
			if now - last_left_tap_time < tap_interval:
				dashing = true
				dash_time_left = dash_timer
				velocity.x = -dash_speed
			else:
				velocity.x = -walk_speed
			last_left_tap_time = now
			sprite_2d.flip_h = true
			sprite_2d.animation = "walk"

		elif Input.is_action_just_pressed("ui_right"):
			var now = Time.get_ticks_msec() / 1000.0
			if now - last_right_tap_time < tap_interval:
				dashing = true
				dash_time_left = dash_timer
				velocity.x = dash_speed
			else:
				velocity.x = walk_speed
			last_right_tap_time = now
			sprite_2d.flip_h = false
			sprite_2d.animation = "walk"
