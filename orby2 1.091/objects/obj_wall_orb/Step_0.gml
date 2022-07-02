///@description 
if(keyboard_check_pressed(ord("K")))
{
	preset++;
	if(preset >= 4) preset = 0;
}