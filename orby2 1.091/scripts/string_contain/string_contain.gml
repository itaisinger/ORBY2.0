// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function string_contain(str, val){

var new_str = "";

for(var i=1; i < string_length(str); i++;)
{
	new_str = "";
	if(string_char_at(str,i) == string_char_at(val,1))
	{
		//gather the word
		for(var j=0; j < string_length(val) and j+i <= string_length(str); j++;)
			new_str += string_char_at(str,i+j);
		
		if(new_str == val) return true;
	}
	}
return false;
}