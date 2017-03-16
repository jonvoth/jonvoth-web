$(document).ready(function(){
	var autoScrollDist = 0,
			isScrolling = false,
			isIOS7 = false,
			shouldHideRevealContainer = false;

	var init = function init(){
				if(/(iPhone|iPad|iPod)\sOS\s7/.test(navigator.userAgent)) {
					$('html').addClass('ios7');
					isIOS7 = true;
				}
				if((!window.Modernizr.touch) || ($('.state-save-the-date').length && isIOS7 === true)){
					window.skrollr.init();
				}else{
					$('.reveal-panel-container').hide();
					shouldHideRevealContainer = true;
					if($('.state-info').length){
						$('body').addClass('non-fixed-bkg');
					}
				}
				if($('.state-error').length){
					$('.reveal-panel-container').hide();
					shouldHideRevealContainer = true;
				}
				if($('.state-save-the-date').length){
					autoScrollDist = 800;
					autoScrollToBottom(autoScrollDist);
				}
				if(!window.Modernizr.touch && $('.state-invitation, .state-info').length){
					autoScrollDist = 500;
					autoScrollToBottom(autoScrollDist);
				}

				//Autoscroll from welcome message button
				$('#auto-scroll').bind('click', function(){
					if($(this).css('opacity') === '1'){
						autoScrollToBottom(autoScrollDist);
					}
				});

				//Autoscroll on nav clicks
				$('.footer-nav a').bind('click', function(event){
					var distance = $($(this).attr('href')).offset().top - $('.head-title').height()
							;
					event.preventDefault();
					$('html, body').animate({'scrollTop': distance+'px'}, 1000);
				});

				//Scrollspy for nav
				$(window).bind('touchstart', function(){
					$('.footer-nav li.active').removeClass('active');
				});
				$(window).bind('scroll', function(){
					var scrollPos = $(window).scrollTop(),
							contentPos1,
							contentPos2,
							contentPos3,
							contentTarget1,
							contentTarget2,
							contentTarget3,
							navTarget1,
							navTarget2,
							navTarget3,
							titleHeadHeight;

					if($('.state-invitation').length){
						titleHeadHeight = $('.head-title').height();
						contentTarget1 = $('#ContainerInvite');
						contentTarget2 = $('#ContainerDetails');
						contentTarget3 = $('#ContainerRSVP');
						navTarget1 = $('#NavItemInvite');
						navTarget2 = $('#NavItemDetails');
						navTarget3 = $('#NavItemRSVP');
					}else if($('.state-info').length){
						titleHeadHeight = $('.head-title').height() + $('.head-rsvp').height();
						contentTarget1 = $('#ContainerEvents');
						contentTarget2 = $('#ContainerParty');
						contentTarget3 = $('#ContainerDetails');
						navTarget1 = $('#NavItemEvents');
						navTarget2 = $('#NavItemParty');
						navTarget3 = $('#NavItemDetails');
					}

					contentPos1 = contentTarget1.offset().top - titleHeadHeight;
					contentPos2 = contentTarget2.offset().top - titleHeadHeight;
					contentPos3 = contentTarget3.offset().top - titleHeadHeight;

					if(scrollPos < contentPos1 && shouldHideRevealContainer === false){
						$('.reveal-panel-container').show();
					}else{
						$('.reveal-panel-container').hide();
					}

					$('.footer-nav li.active').removeClass('active');
					if(scrollPos + $(window).height() >= $('.wrapper').height()){
						navTarget3.addClass('active');
						return;
					}else if(scrollPos < contentPos2){
						navTarget1.addClass('active');
						return;
					}else if(scrollPos > contentPos2 && scrollPos < contentPos3){
						navTarget2.addClass('active');
						return;
					}else {
						navTarget3.addClass('active');
					}
				});

				//RSVP form validation
				$('#BtnSubmitRSVP').attr('disabled', 'true');
				$('#Accept, #Decline').bind('click', function(){
					$('#BtnSubmitRSVP').removeAttr('disabled');
				});
		},
		autoScrollToBottom = function autoScrollToBottom(distance){
			if(isScrolling === false){
				isScrolling = true;
				$('html, body').animate({'scrollTop': distance+'px'}, 3000, function(){
					$('h2, .btn').removeClass('hide');
					isScrolling = false;
				});
			}
		};

	init();
});