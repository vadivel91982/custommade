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
