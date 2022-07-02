if(!instance_exists(obj_cutscene))
{
	active = true;
	orb_active = true;
}

with(obj_player)
{
	key_down  = (keyboard_check(ord("S")) or keyboard_check(vk_down))*other.active;
	key_up    = (keyboard_check(ord("W")) or keyboard_check(vk_up))*other.active;
	key_left  = (keyboard_check(ord("A")) or keyboard_check(vk_left))*other.active;
	key_right = (keyboard_check(ord("D")) or keyboard_check(vk_right))*other.active;
	key_esc   = keyboard_check_pressed(other.bind_esc)*other.active;
	var press_jump = keyboard_check_pressed(other.bind_jump) or other.jump_with_up*keyboard_check_pressed(other.bind_up)
	key_jump  =  max(key_jump-1,5*press_jump)*other.jumped*other.active;
}
if(orb_active) with(obj_orb)
{
	key_1  = mouse_check_button_pressed(other.bind_orb1)*other.active;
	key_2  = mouse_check_button_pressed(other.bind_orb2)*other.active;
	key_up   = mouse_wheel_up()*other.active;
	key_down = mouse_wheel_down()*other.active;
	key_anchor = 0//mouse_check_button_pressed(mb_middle) or keyboard_check_pressed(vk_shift);
	key_black  = keyboard_check_pressed(vk_numpad1) or keyboard_check_pressed(ord("1")); 
	key_purple = keyboard_check_pressed(vk_numpad2) or keyboard_check_pressed(ord("2")) or keyboard_check_pressed(vk_shift); 
	key_orange = keyboard_check_pressed(vk_numpad3) or keyboard_check_pressed(ord("3")); 
	key_yellow = keyboard_check_pressed(vk_numpad4) or keyboard_check_pressed(ord("4")); 
	key_blue   = keyboard_check_pressed(vk_numpad5) or keyboard_check_pressed(ord("5"));
	key_pink   = keyboard_check_pressed(vk_numpad6) or keyboard_check_pressed(ord("7"));
	key_green  = keyboard_check_pressed(vk_numpad7) or keyboard_check_pressed(ord("6"));
}

jumped = 1;