$newWindow=true;
	$startSlide=0;
	function slide(){
		if($startSlide==3)
			$startSlide=1;
		else
			$startSlide+=1;

		$(".bg-slide").attr("style", "opacity: 0;");
		$(".bg-slide-"+$startSlide).attr("style", "opacity: 1;");
	}

	setInterval(slide, 5000);

	

	$(".btn-down, .learn-more-index").click(function(e){
		e.preventDefault();
		th=$(this);
		 $('html, body').animate({
	        scrollTop: $(th.attr("href")).offset().top
	    }, 500);
	})