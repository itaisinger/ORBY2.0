///@description 
fright_cooldown = 0;
clang_cd = 0;
global.sfx_volume = 1;

function play_anvil_clang(){
	
	if(obj_transition.state != TRANS_STATES.off) return;
	
	if(clang_cd == 0)
	{
		clang_cd = 30;
		play_sfx(sfx_clang);
		global.camera_shake = 0.4;
	}
}