///@desc saves a string to a file ()
///@arg0file_name
///@arg1string
function save_string_to_file(argument0, argument1) {

	var filename = argument0;
	var str = argument1;

	var buffer = buffer_create(string_byte_length(str)+1, buffer_fixed, 1);
	buffer_write(buffer, buffer_string, str);
	buffer_save(buffer,filename);
	buffer_delete(buffer);


}
