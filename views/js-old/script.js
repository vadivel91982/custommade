/**
* 2016-2017 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2016-2017 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*
* Don't forget to prefix your containers with your own identifier
* to avoid any conflicts with others containers.
*/
$(function () {

  (function () {
    var canvas=0;
    var $image = $('.img-container > img'),
        $dataRotate = $('#dataRotate'),
        options = {
           modal: true,
           guides: true,
           autoCrop: false,
           dragCrop: true,
           movable: true,
           resizable: true,
           zoomable: false,
           touchDragZoom: false,
           mouseWheelZoom: false,
           preview: '.preview',
          crop: function (data) {
            $dataRotate.val(Math.round(data.rotate));
          }
        };
        
        var $preview = $(".preview"),
    width = $preview.width();

    $image.on().cropper(options);
    $(document.body).on('click', '[data-method]', function () {
      var data = $(this).data(),
          $target=0,
          result;

      if (data.method) {
        data = $.extend({}, data); // Clone a new one

        if (typeof data.target !== 'undefined') {
          $target = $(data.target);

          if (typeof data.option === 'undefined') {
            try {
              data.option = JSON.parse($target.val());
            } catch (e) {
              console.log(e.message);
            }
          }
        }

        result = $image.cropper(data.method, data.option);
        if (data.method === 'getCroppedCanvas') {
		  canvas = result;
          $('#croppedImage').html(result);
        }

        if ($.isPlainObject(result) && $target) {
          try {
            $target.val(JSON.stringify(result));
          } catch (e) {
            console.log(e.message);
          }
        }

      }
    });
	
	$("#sendToServer").click(function(){
		var croppedImageBase64 = canvas.toDataURL();
		var mainImage = $('img[alt="mainImage"]').attr('src');
        $.ajax({
				url : 'ImageServlet',
				type : 'POST',
				data : {mainImage: mainImage, croppedImage: croppedImageBase64},
				error : function() {
	
				},
				success : function(data) {
				    
				}
			});
    });


  }());
});
