/* Author: Jon Voth */

var 	$window = $(window),
		$containerHeader = $('#container_header'),
		$containerServices = $('#container_services'),
		$containerWork = $('#container_work'),
		$containerAbout = $('#container_about'),
		$containerHeader = $('#container_header'),
		$resumeLink = $('#container_resume_link a'),
		$navServices = $('#nav_services'),
		$navWork = $('#nav_work'),
		$navAbout = $('#nav_about'),
		headerHeight = $containerHeader.height(),
		navAnimationTime = 500,
		currentScrollTop = $window.scrollTop(),
		currentViewportHeight = $window.height(),
		$targetWorkArticle,
		isIOS = false,
		scrollDelayTimeout;


$('#nav_top').bind((Modernizr.touch) ? 'touchend' : 'mouseup', function(){
	doNavScroll(0);
});

$navServices.bind((Modernizr.touch) ? 'touchend' : 'mouseup', function(){
	doNavScroll($containerServices.offset().top - $containerHeader.height());
});

$navWork.bind((Modernizr.touch) ? 'touchend' : 'mouseup', function(){
	doNavScroll($containerWork.offset().top - $containerHeader.height());
});

$navAbout.bind((Modernizr.touch) ? 'touchend' : 'mouseup', function(){
	doNavScroll($containerAbout.offset().top - $containerHeader.height());
});

$('#container_work nav span').bind((Modernizr.touch) ? 'touchend' : 'mouseup', function(){
	$('#container_work nav span').removeClass('current');
	$(this).addClass('current');
	
	$targetWorkArticle = $('#work_rotator article.pos'+$(this).attr('data-item-num'));
	$('#work_rotator article').css('opacity', 0);
	$targetWorkArticle.css('opacity', 1);
	
	updateWorkHeight($targetWorkArticle);
});

function doNavScroll(scrollTarget) {
	$("html:not(:animated),body:not(:animated)").stop().animate({scrollTop: scrollTarget}, navAnimationTime, 'linear');	
}

function updateWorkHeight(targetElement){
	$('#work_rotator').css('height', targetElement.height()+'px');
}

function updateNav(current){
	$navServices.removeClass('current');
	$navWork.removeClass('current');
	$navAbout.removeClass('current');

	switch(current){
		case 'services':
			$navServices.addClass('current');
			break;
		case 'work':
			$navWork.addClass('current');
			break;
		case 'about':
			$navAbout.addClass('current');
			break;
		default:
			break;
	}
}

function getOpacity(container){	
	var containerTop = container.offset().top - headerHeight;
	var returnVal;
	if(containerTop > currentScrollTop){
		returnVal = ((currentScrollTop + currentViewportHeight) - containerTop) / (currentViewportHeight * 0.6);
	}else{
		returnVal = ((containerTop + container.height()) - currentScrollTop) / (currentViewportHeight * 0.4);
	}
	return returnVal;
}

function updateContainerOpacities() {
	if(!Modernizr.touch){
		$containerServices.css('opacity', getOpacity($containerServices));
		$containerWork.css('opacity', getOpacity($containerWork));
		$containerAbout.css('opacity', getOpacity($containerAbout));
	}
}

function init(){
	updateContainerOpacities();
	
	if(!Modernizr.svg){
		$('#container_services_chart').attr('src', 'img/img_services_chart.png');
	}
	if(navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPod/i) || navigator.userAgent.match(/iPad/i)){
		isIOS = true;
		$containerHeader.css({'position':'absolute'});
	}
	
	window.addEventListener("resize", function() {
		updateWorkHeight($targetWorkArticle);
	}, false);
}

$window.scroll(function(){
	currentScrollTop = $window.scrollTop();
	currentViewportHeight = $window.height();	

	thresholdWork = $containerWork.offset().top - headerHeight - 20;
	thresholdAbout = $containerAbout.offset().top - headerHeight - 20;

	if(currentScrollTop < thresholdWork){
		if(!$navServices.hasClass('current')){
			updateNav('services');
		}
	}else if (currentScrollTop >= thresholdWork && currentScrollTop < thresholdAbout) {
		if(!$navWork.hasClass('current')){
			updateNav('work');
		}
	}else if (currentScrollTop >= thresholdAbout) {
		if(!$navAbout.hasClass('current')){
			updateNav('about');
		}
	}else {
		updateNav();
	}
	
	updateContainerOpacities();
	
	if(isIOS){
		if(scrollDelayTimeout) clearTimeout(scrollDelayTimeout);
		scrollDelayTimeout = setTimeout(function(){$containerHeader.css({'top':currentScrollTop+'px'});}, 50);
	}
});

init();
