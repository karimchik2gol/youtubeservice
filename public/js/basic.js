$(".add-category").click(function(e){
	e.preventDefault();
	valId=$(this).parents(".select-category").find("select option:selected");
	val=$(".hidden_category").val();
	if(!val || !val.split(",") || val.split(",").indexOf("id"+valId.val()) < 0){
		$(".hidden_category").val(val+"id"+valId.val()+",");
		$(".category_section").append("<span class='selected-category-item' data-id='"+valId.val()+"'><span class='category-label-section'>"+valId.text()+"</span> <span onclick='destroy_category(this)' class='destroy-category'>X</span> </span>")
	}
})

function destroy_category(ths){
	th=jQuery(ths);
	parentWrap=th.parents(".selected-category-item");
	id=parentWrap.data("id");
	parentWrap.remove();
	val=$(".hidden_category").val();
	splitedStr=val.split(",");
	splitedStr=jQuery.grep(splitedStr, function(value) {
	  return value != "id"+id;
	});
	if(splitedStr.length>0)
		str=splitedStr.join(",");
	else
		str="";
	$(".hidden_category").val(str);
}

function add_errors(cls_start, errors){
	$(".error-registration").remove();
	for(var i=0; i<errors.length; i++){
		splitedArray=errors[i].split(" ");
		cls=splitedArray[0].toLowerCase();
		prnt=$(cls_start+cls).parents(".field");
		splitedArray.shift();
		prnt.append("<p class='error-registration'>"+splitedArray.join(" ").replace(/[a-zA-Z]/g, "")+"<\/p>");
		$('html, body').animate({
	        scrollTop: 0
	    }, 500);
	}
}

$(".searching-input input[type='text']").keyup(function(e){
	th=$(this);
	$.ajax({
	          async: true,
	          type: "POST",
	          dataType: 'html',
	          url: "/index/searchingProfile",
	          data: {"title":th.parent().find("input").val()}, 
	          success: function(data){
	          	$(".channels").empty();
	          	$(".channels").append(data);
	          }
	});
})

$(".ajax_start").click(function(e){
		e.preventDefault();
		$.ajax({
	          async: true,
	          type: "GET",
	          dataType: 'json',
	          url: "/index/start",
	          success: function(data){
				window.location=data;
	          }
	    });
	})