// ���̺� Ȧ��, ¦�� ��� ����
$(document).ready(function() {
	//odd = Ȧ�� even = ¦��
	$('table.tbl_type_list tr:odd').addClass("oddColor");
	$('table.tbl_type_list tr:even').addClass("evenColor");
});


//�����̽�ó��
function fillSpace(val){

	if(typeof val =="undefined" || val == null){
		return ' ';
	}
	if(val.length==0){
		return ' ';
	}

    return val;
}


//INPUT TYPE=FILE �̹��� ����(������)
function fn_fileUpload(){
	var $img = $('div.fileUp input[type=image]');
	var img_width = $img.attr('width');
	
	var $file = $('div.fileUp input#upload1').css({
		"position": "absolute",
		"top": "0",
		"width": "59px",
		"height": "23px",			
		"right": "0px",
		"cursor": "pointer",
		"opacity": "0.0"
	});

	$file.bind('change',function(){
		var filename = $(this).val();
		$('div.fileUp input#file1').attr("disabled","disabled").val(filename);
	});
	
	
	var $file = $('div.fileUp input#upload2').css({
		"position": "absolute",
		"top": "0",
		"width": "59px",
		"height": "23px",			
		"right": "0px",
		"cursor": "pointer",
		"opacity": "0.0"
	});

	$file.bind('change',function(){
		var filename = $(this).val();
		$('div.fileUp input#file2').attr("disabled","disabled").val(filename);
	});
	
	
	var $file = $('div.fileUp input#upload3').css({
		"position": "absolute",
		"top": "0",
		"width": "59px",
		"height": "23px",			
		"right": "0px",
		"cursor": "pointer",
		"opacity": "0.0"
	});

	$file.bind('change',function(){
		var filename = $(this).val();
		$('div.fileUp input#file3').attr("disabled","disabled").val(filename);
	});
	
	
	var $file = $('div.fileUp input#upload4').css({
		"position": "absolute",
		"top": "0",
		"width": "59px",
		"height": "23px",			
		"right": "0px",
		"cursor": "pointer",
		"opacity": "0.0"
	});

	$file.bind('change',function(){
		var filename = $(this).val();
		$('div.fileUp input#file4').attr("disabled","disabled").val(filename);
	});
	
	
	var $file = $('div.fileUp input#upload5').css({
		"position": "absolute",
		"top": "0",
		"width": "59px",
		"height": "23px",			
		"right": "0px",
		"cursor": "pointer",
		"opacity": "0.0"
	});

	$file.bind('change',function(){
		var filename = $(this).val();
		$('div.fileUp input#file5').attr("disabled","disabled").val(filename);
	});
	
	
	var $file = $('div.fileUp input#upload6').css({
		"position": "absolute",
		"top": "0",
		"width": "59px",
		"height": "23px",			
		"right": "0px",
		"cursor": "pointer",
		"opacity": "0.0"
	});

	$file.bind('change',function(){
		var filename = $(this).val();
		$('div.fileUp input#file6').attr("disabled","disabled").val(filename);
	});
	
	
};