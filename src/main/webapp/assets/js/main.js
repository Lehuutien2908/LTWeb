window.awe = window.awe || {};
awe.init = function () {
	awe.showPopup();
	awe.hidePopup();
};
$(document).ready(function ($) {
	"use strict";
	awe_backtotop();
	awe_category();
	awe_tab();
	$(window).on('load resize', function () {
		resizeImage();
	});
	product_action();
});
function resizeImage() {
	setTimeout(function(){
		$('.product-block-item:not(.viewed)').each(function(){
			var thumbset = $(this).find('.product-transition');
			thumbset.css({'height':thumbset.width()+'px'});
		})
		$('.item_product_main').each(function(){
			var thumbset = $(this).find('.image_thumb');
			var wthumb = thumbset.width();
			thumbset.css({'height':wthumb+'px'});
		})
	},500);
}
$(window).on("load resize",function(e){
	if($(window).width() < 1200 ){
		$('.mobile-checkout').html('<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="check-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="svg-inline--fa fa-check-circle fa-w-16"><path fill="currentColor" d="M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z" class=""></path></svg> ÄÆ¡n hĂ ng');
	}
});
function product_action(str) {
	/*Product action*/
	$('.product-box .btn-circle').mouseenter(function() {
		var tt = $(this).attr('data-title');
		$(this).parents('form').find('.action-info').html(tt);
	});
	$('.product-box .btn-circle').mouseleave(function() {
		$(this).parents('form').find('.action-info').html('Chò£n hoà£t Ä‘Ă´̀£ng');
	});

} window.product_action=product_action;
$('.dropdown-toggle').click(function() {
	$(this).parent().toggleClass('open');
});
$('.close-pop').click(function() {
	$('#popup-cart').removeClass('opencart');
	$('body').removeClass('opacitycart');
});
$(document).on('click','.overlay, .close-popup, .btn-continue, .fancybox-close', function() {
	hidePopup('.awe-popup');
	setTimeout(function(){
		$('.loading').removeClass('loaded-content');
	},500);
	return false;
})

function awe_showLoading(selector) {
	var loading = $('.loader').html();
	$(selector).addClass("loading").append(loading);
}  window.awe_showLoading=awe_showLoading;
function awe_hideLoading(selector) {
	$(selector).removeClass("loading");
	$(selector + ' .loading-icon').remove();
}  window.awe_hideLoading=awe_hideLoading;
function awe_showPopup(selector) {
	$(selector).addClass('active');
}  window.awe_showPopup=awe_showPopup;
function awe_hidePopup(selector) {
	$(selector).removeClass('active');
}  window.awe_hidePopup=awe_hidePopup;
awe.hidePopup = function (selector) {
	$(selector).removeClass('active');
}
$(document).on('click','.overlay, .close-window, .btn-continue, .fancybox-close', function() {
	awe.hidePopup('.awe-popup');
	setTimeout(function(){
		$('.loading').removeClass('loaded-content');
	},500);
	return false;
})
var wDWs = $(window).width();
if (wDWs < 1199) {
	/*Remove html mobile*/
	$('.quickview-product').remove();
}

function awe_convertVietnamese(str) {
	str= str.toLowerCase();
	str= str.replace(/Ă |Ă¡|áº¡|áº£|Ă£|Ă¢|áº§|áº¥|áº­|áº©|áº«|Äƒ|áº±|áº¯|áº·|áº³|áºµ/g,"a");
	str= str.replace(/Ă¨|Ă©|áº¹|áº»|áº½|Ăª|á»|áº¿|á»‡|á»ƒ|á»…/g,"e");
	str= str.replace(/Ă¬|Ă­|á»‹|á»‰|Ä©/g,"i");
	str= str.replace(/Ă²|Ă³|á»|á»|Ăµ|Ă´|á»“|á»‘|á»™|á»•|á»—|Æ¡|á»|á»›|á»£|á»Ÿ|á»¡/g,"o");
	str= str.replace(/Ă¹|Ăº|á»¥|á»§|Å©|Æ°|á»«|á»©|á»±|á»­|á»¯/g,"u");
	str= str.replace(/á»³|Ă½|á»µ|á»·|á»¹/g,"y");
	str= str.replace(/Ä‘/g,"d");
	str= str.replace(/!|@|%|\^|\*|\(|\)|\+|\=|\<|\>|\?|\/|,|\.|\:|\;|\'| |\"|\&|\#|\[|\]|~|$|_/g,"-");
	str= str.replace(/-+-/g,"-");
	str= str.replace(/^\-+|\-+$/g,"");
	return str;
} window.awe_convertVietnamese=awe_convertVietnamese;
function awe_category(){
	$('.nav-category .fa-plus').click(function(e){
		$(this).toggleClass('fa-minus fa-plus');
		$(this).parent().toggleClass('active');
	});
	$('.nav-category .fa-minus').click(function(e){
		$(this).toggleClass('fa-plus');
		$(this).parent().toggleClass('active');
	});
} window.awe_category=awe_category;


function awe_backtotop() {
	$(window).scroll(function() {
		$(this).scrollTop() > 200 ? $('.backtop').addClass('show') : $('.backtop').removeClass('show')
	});
	$('.backtop').click(function() {
		return $("body,html").animate({
			scrollTop: 0
		}, 800), !1
	});
} window.awe_backtotop=awe_backtotop;
function awe_tab() {
	$(".e-tabs:not(.not-dqtab)").each( function(){
		$(this).find('.tabs-title li:first-child').addClass('current');
		$(this).find('.tab-content').first().addClass('current');
		$(this).find('.tabs-title li').click(function(e){
			var tab_id = $(this).attr('data-tab');
			var url = $(this).attr('data-url');
			$(this).closest('.e-tabs').find('.tab-viewall').attr('href',url);
			$(this).closest('.e-tabs').find('.tabs-title li').removeClass('current');
			$(this).closest('.e-tabs').find('.tab-content').removeClass('current');
			$(this).addClass('current');
			$(this).closest('.e-tabs').find("#"+tab_id).addClass('current');

		});
	});
} window.awe_tab=awe_tab;
$('.dropdown-toggle').click(function() {
	$(this).parent().toggleClass('open');
});
$('.btn-close').click(function() {
	$(this).parents('.dropdown').toggleClass('open');
});
$(document).on('keydown','#qty, .number-sidebar',function(e){-1!==$.inArray(e.keyCode,[46,8,9,27,13,110,190])||/65|67|86|88/.test(e.keyCode)&&(!0===e.ctrlKey||!0===e.metaKey)||35<=e.keyCode&&40>=e.keyCode||(e.shiftKey||48>e.keyCode||57<e.keyCode)&&(96>e.keyCode||105<e.keyCode)&&e.preventDefault()});
$(document).on('click','.qtyplus',function(e){
	e.preventDefault();
	fieldName = $(this).attr('data-field');
	var currentVal = parseInt($('input[data-field='+fieldName+']').val());
	if (!isNaN(currentVal)) {
		$('input[data-field='+fieldName+']').val(currentVal + 1);
	} else {
		$('input[data-field='+fieldName+']').val(0);
	}
});
$(document).on('click','.qtyminus',function(e){
	e.preventDefault();
	fieldName = $(this).attr('data-field');
	var currentVal = parseInt($('input[data-field='+fieldName+']').val());
	if (!isNaN(currentVal) && currentVal > 1) {
		$('input[data-field='+fieldName+']').val(currentVal - 1);
	} else {
		$('input[data-field='+fieldName+']').val(1);
	}
});
$('.open-filters').click(function(e){
	e.stopPropagation();
	$(this).toggleClass('openf');
	$('.dqdt-sidebar').toggleClass('openf');
	$('.opacity_sidebar').toggleClass('openf');
});
$('.opacity_sidebar').click(function(e){
	$('.opacity_sidebar').removeClass('openf');
	$('.dqdt-sidebar, .open-filters').removeClass('openf')
});
$('.menubutton').click(function(e){
	e.stopPropagation();
	$('.wrapmenu_right').toggleClass('open_sidebar_menu');
	$('.opacity_menu').toggleClass('open_opacity');
});
$('.opacity_menu').click(function(e){
	$('.wrapmenu_right').removeClass('open_sidebar_menu');
	$('.opacity_menu').removeClass('open_opacity');
});
$(".menubar_pc").click(function(){
	$('.wrapmenu_full').slideToggle('fast');
	$('.wrapmenu_full, .cloed').toggleClass('open_menu');
	$('.dqdt-sidebar, .open-filters').removeClass('openf')
});
$(".cloed").click(function(){
	$(this).toggleClass('open_menu');
	$('.wrapmenu_full').slideToggle('fast');
});
$(".opacity_menu").click(function(){
	$('.opacity_menu').removeClass('open_opacity');
});
if ($('.dqdt-sidebar').hasClass('openf')) {
	$('.wrapmenu_full').removeClass('open_menu');
}
$('.ul_collections li > svg').click(function(){
	$(this).parent().toggleClass('current');
	$(this).toggleClass('fa-angle-down fa-angle-right');
	$(this).next('ul').slideToggle("fast");
	$(this).next('div').slideToggle("fast");
});
$('.searchion').mouseover(function() {
	$('.searchmini input').focus();
})
$('.quenmk').on('click', function() {
	$('#login').toggleClass('hidden');
	$('.h_recover').slideToggle();
});
$('a[data-toggle="collapse"]').click(function(e){
	if ($(window).width() >= 767) {
		// Should prevent the collapsible and default anchor linking
		// behavior for screen sizes equal or larger than 768px.
		e.preventDefault();
		e.stopPropagation();
	}
});

$(document).ready(function(){

	var wDWs = $(window).width();
	if (wDWs < 767) {
		$('.footer-widgetx h4').click(function(e){
			$(this).toggleClass('current');
			$(this).next('ul').toggleClass("current");
		});

	}
	if (wDWs < 991) {
		$('.close-menu, .opacity_menu').on('click', function(){
			$('.heade_menunavs').removeClass('current');
			$('.opacity_menu').removeClass('current');
		})
		$('.category-action').on('click', function(){
			$('.heade_menunavs').addClass('current');
			$('.opacity_menu').addClass('current');
		})
		$('.item_big li .fa').click(function(e){
			if($(this).hasClass('current')) {
				$(this).closest('ul').find('li, .fa').removeClass('current');
			} else {
				$(this).closest('ul').find('li, .fa').removeClass('current');
				$(this).closest('li').addClass('current');
				$(this).addClass('current');
			}
		});
	}


});
/********************************************************
Search header
********************************************************/
$('body').click(function(event) {
	if (!$(event.target).closest('.collection-selector').length) {
		$('.list_search').css('display','none');
	};
});
/* top search */

$('.search_text').click(function(){
	$(this).next().slideToggle(200);
	$('.list_search').show();
})

$('.list_search .search_item').on('click', function (e) {
	$('.list_search').hide();

	var optionSelected = $(this);


	var title = optionSelected.text();


	$('.search_text').text(title);


	$(".search-text").focus();
	optionSelected.addClass('active').siblings().removeClass('active');

});




$('#mb_search').click(function(){
	$('.mb_header_search').slideToggle('fast');
});

$('.fi-title.drop-down').click(function(){
	$(this).toggleClass('opentab');
});



/*JS XEM THĂM MENU DANH Má»¤C SP*/
$('.xemthem').click(function(e){
	e.preventDefault();
	$('ul.ul_menu>li').css('display','block');
	$(this).hide();
	$('.thugon').show();
})
$('.thugon').click(function(e){
	e.preventDefault();
	$('ul.ul_menu>li').css('display','none');
	$(this).hide();
	$('.xemthem').show();
})
$('.ul_menu .lev-1').click(function(e){
	var lil = $('.ul_menu .lev-1').length;
	var divHeight = $('.list_menu_header').height();
	if(lil = 2){
		$('.ul_menu .ul_content_right_1').css('min-height', divHeight);
	}
});
window.onload = function(e){
	var lil = $('.ul_menu .lev-1').length;
	var vw = $(window).width();
	if(lil < 9 && vw < 1500 && vw > 1200){
		$('li.hidden-lgg').remove();
	}
	if(vw < 768){
		$('.banner_img_slider').remove();
	}
}


/*MENU MOBILE*/

$('.menu-bar-h').click(function(e){
	e.stopPropagation();
	$('.menu_mobile').toggleClass('open_sidebar_menu');
	$('.opacity_menu').toggleClass('open_opacity');
});
$('.opacity_menu').click(function(e){
	$('.menu_mobile').removeClass('open_sidebar_menu');
	$('.opacity_menu').removeClass('open_opacity');
});


$('.ul_collections li > .fa').click(function(){
	$(this).parent().toggleClass('current');
	$(this).toggleClass('fa-angle-down fa-angle-up');
	$(this).next('ul').slideToggle("fast");
	$(this).next('div').slideToggle("fast");
});
$('.aside-item .aside-title .fa-chevron-down').click(function(e){
	$(this).find('.fas').toggleClass('fa-chevron-down fa-chevron-up');
	$(this).closest('.aside-item').find('.aside-content').slideToggle('fast');
});


$(document).ready(function(){

	$(".body_tab .button_show_tab").click(function(){
		$('.link_tab_check_click').slideToggle('down');
	});

	$("body header .topbar .login_content").hover(
		function () {
			$("body #menu-overlay").addClass('reveal');
		},
		function () {
			$("body #menu-overlay").removeClass("reveal");
		}
	);
});

/*js noti wishlist*/
var SuccessNoti = function(SuccessText){
	$.notify({
		// options
		title: '<strong>Tuyá»‡t vá»i</strong><br>',
		message: SuccessText,
		icon: 'glyphicon glyphicon-ok'
	},{
		// settings
		element: 'body',
		//position: null,
		type: "success",
		//allow_dismiss: true,
		//newest_on_top: false,
		showProgressbar: false,
		placement: {
			from: "top",
			align: "right"
		},
		offset: 20,
		spacing: 10,
		z_index: 1031,
		delay: 3300,
		timer: 1000,
		url_target: '_blank',
		mouse_over: null,
		animate: {
			enter: 'animated fadeInDown',
			exit: 'animated fadeOutRight'
		},
		onShow: null,
		onShown: null,
		onClose: null,
		onClosed: null,
		icon_type: 'class',
	});
}
var InfoNoti = function(InfoText){
	$.notify({
		// options
		title: '<strong>ThĂ´ng bĂ¡o</strong><br>',
		message: InfoText,
		icon: 'glyphicon glyphicon-info-sign',
	},{
		// settings
		element: 'body',
		position: null,
		type: "info",
		allow_dismiss: true,
		newest_on_top: false,
		showProgressbar: false,
		placement: {
			from: "top",
			align: "right"
		},
		offset: 20,
		spacing: 10,
		z_index: 1031,
		delay: 3300,
		timer: 1000,
		url_target: '_blank',
		mouse_over: null,
		animate: {
			enter: 'animated bounceInDown',
			exit: 'animated bounceOutUp'
		},
		onShow: null,
		onShown: null,
		onClose: null,
		onClosed: null,
		icon_type: 'class',
	});
}
var ErrorNoti = function(ErrorText){
	$.notify({
		// options
		title: '<strong>ThĂ´ng bĂ¡o</strong><br',
		message: ErrorText,
		icon: 'glyphicon glyphicon-info-sign',
	},{
		// settings
		element: 'body',
		position: null,
		type: "warning",
		allow_dismiss: true,
		newest_on_top: false,
		showProgressbar: false,
		placement: {
			from: "top",
			align: "right"
		},
		offset: 20,
		spacing: 10,
		z_index: 1031,
		delay: 3300,
		timer: 1000,
		url_target: '_blank',
		mouse_over: null,
		animate: {
			enter: 'animated bounceInDown',
			exit: 'animated bounceOutUp'
		},
		onShow: null,
		onShown: null,
		onClose: null,
		onClosed: null,
		icon_type: 'class',
	});
}




$(window).bind('scroll', function () {
	if ($(window).scrollTop() > 125) {
		$('.mid-header').addClass('sticked');
	} else {
		$('.mid-header').removeClass('sticked');
	}
});

$(document).ready(function(e){
	var wDWs = $(window).width();
	if (wDWs < 991) {
		$(".wrap_tab_index").each( function(e){
			var _this = $(this).find(' .title_module_main');
			var droptab = $(this).find('.link_tab_check_click,.more-index');

			$(_this).click(function(){
				if ($(droptab).hasClass('opentab')) {
					$(droptab).addClass('closetab').removeClass('opentab');
				}else {
					$(droptab).addClass('opentab').removeClass('closetab');
				}
			});
		});
		$('.link_tab_check_click,.more-index ').click(function(){
			$('.link_tab_check_click,.more-index').addClass('closetab').removeClass('opentab');
		});
	}

	$('.inline-block.account-dr>a').click(function(e){
		if($(window).width() < 992){
			e.preventDefault();

		}
	})

	var ww = $(window).width();
	/*** Fixed menu bar ***/
	var hh = $('.topbar').height() + $('.mainbar').height();
	// var h1 = $('header').height();
	// var h2 = $('.top-header').height() + $('.main-header').height() + $('.site-nav-mobile').height();

	$(window).scroll(function(){
		if (ww >= 992){
			if($(this).scrollTop() > hh){
				$('.menu-header').addClass('sticky');
			} else {
				$('.menu-header').removeClass('sticky');
			}
		} else {
			if($(this).scrollTop() > hh){
				$('.site-nav-mobile').addClass('sticky');
				$('.site-nav-mobile .module-title a').show();
			} else {
				$('.site-nav-mobile').removeClass('sticky');
				$('.site-nav-mobile .module-title a').hide();
			}
		}
	});
});