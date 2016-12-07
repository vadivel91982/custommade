(function ($) {
        $(document).ready(function () {
            var masonryGrid = $('.masonry-grid');
            masonryGrid.masonry({
                itemSelector: '.image',
                columnWidth: '.image',
                percentPosition: true
            });

            masonryGrid.imagesLoaded().progress( function() {
                masonryGrid.masonry('layout');
            });

        });
    })(jQuery);
      /*  var previewSettings = {
            canvas: {
                scene1: {
                    small: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/canvas-1/landscape/canvas1-land-full.png',
                        top: '8%',
                        width: '48.5%',
                        left: '25.75%'
                    },
                    medium: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/canvas-1/landscape/canvas1-land-full.png',
                        top: '4.5%',
                        width: '55.5%',
                        left: '22.25%'
                    },
                    large: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/canvas-1/landscape/canvas1-land-full.png',
                        top: '2%',
                        width: '62.5%',
                        left: '18.75%'
                    }
                },
                scene2: {
                    small: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/canvas-2/landscape/canvas2-land-full.png',
                        top: '9%',
                        width: '48.5%',
                        left: '25.7%'
                    },
                    medium: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/canvas-2/landscape/canvas2-land-full.png',
                        top: '4%',
                        width: '55.5%',
                        left: '22.25%'
                    },
                    large: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/canvas-2/landscape/canvas2-land-full.png',
                        top: '2%',
                        width: '62.5%',
                        left: '18.75%'
                    }
                },
                scene3: {
                    small: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/canvas-1/portrait/canvas1-port-full.png',
                        top: '5%',
                        width: '26.8%',
                        left: '36.6%'
                    },
                    medium: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/canvas-1/portrait/canvas1-port-full.png',
                        top: '3.4%',
                        width: '33.95%',
                        left: '33.025%'
                    },
                    large: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/canvas-1/portrait/canvas1-port-full.png',
                        top: '2.5%',
                        width: '38.3%',
                        left: '30.85%'
                    }
                },
                scene4: {
                    small: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/canvas-2/portrait/canvas2-port-full.png',
                        top: '9%',
                        width: '26.8%',
                        left: '36.6%'
                    },
                    medium: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/canvas-2/portrait/canvas2-port-full.png',
                        top: '5.5%',
                        width: '33.95%',
                        left: '33.025%'
                    },
                    large: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/canvas-2/portrait/canvas2-port-full.png',
                        top: '3.5%',
                        width: '38.3%',
                        left: '30.85%'
                    }
                },
                scene6: {
                    small: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/living_room_canvas.png',
                        top: '9%',
                        width: '48.5%',
                        left: '25.7%'
                    },
                    medium: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/living_room_canvas.png',
                        top: '4%',
                        width: '55.5%',
                        left: '22.25%'
                    },
                    large: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/living_room_canvas.png',
                        top: '2%',
                        width: '62.5%',
                        left: '18.75%'
                    }
                },
                scene5: {
                    small: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/living_room_canvas.png',
                        top: '9%',
                        width: '26.8%',
                        left: '36.6%'
                    },
                    medium: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/living_room_canvas.png',
                        top: '5.5%',
                        width: '33.95%',
                        left: '33.025%'
                    },
                    large: {
                        overlayUrl: 'https://api.createawall.co.uk/img/overlays/living_room_canvas.png',
                        top: '3.5%',
                        width: '38.3%',
                        left: '30.85%'
                    }
                }
            }
        };
*/
        (function ($) {

            $('#collage-preview').fixedsticky();

            document.title = "Floodlights on Area - Create A Wall";
            
            var jobId = '05eb03a7-b22d-11e6-9a4d-00155d141523';
            var base_url = 'https://api.createawall.co.uk';

            function makeTransformation(type, id, data) {
                var url = "";

                switch (type) {
                    case 'crop':
                        url = "https://api.createawall.co.uk/transform/0/crop";
                        break;
                    case 'rotate':
                        url = "https://api.createawall.co.uk/transform/0/rotate";
                        break;
                    case 'flip':
                        url = "https://api.createawall.co.uk/transform/0/flip";
                        break;
                    case 'filter':
                        url = "https://api.createawall.co.uk/transform/0/filter";
                        break;
                    default:
                        return false;
                }

                url = url.replace('0', id);

                var manipulationButtons = $('.transform-buttons button');

                // Add the image data to the transformation data.
                data = addImageData(data);

                $.ajax({
                    url: url,
                    method: 'POST',
                    data: data,
                    beforeSend: function () {
                        manipulationButtons.each(function (key, button) {
                            $(button).addClass('disabled');
                        });
                    },
                    success: function (response) {
                        $('.preview').attr('src', base_url + response.processedImageUrl);
                    },
                    complete: function () {
                        manipulationButtons.each(function (key, button) {
                            $(button).removeClass('disabled');
                        });
                    }
                });
            }

            /**
             * Add the image data to the provided object.
             */
            function addImageData(data) {
                var imageData = image.cropper('getImageData');

                /**
                 * If the image has been rotated on it's side flip the width and height to ensure the server-side
                 * percentage conversion is correct.
                 */
                switch (imageData.rotate) {
                    case 90:
                    case 270:
                        data.imageWidth = imageData.naturalHeight;
                        data.imageHeight = imageData.naturalWidth;
                        break;
                    default:
                        data.imageWidth = imageData.naturalWidth;
                        data.imageHeight = imageData.naturalHeight;
                }

                return data;
            }

            var image = $('#base-image');
            var options = {
                viewMode: 1, // Can use 'viewMode: 3' to remove the canvas borders but causes zoom issues on rotate.
                aspectRatio: 1 / 1,
                dragMode: 'move',
                checkCrossOrigin: false,
                zoomOnWheel: false,
                zoomable: false,
                movable: false,
                //        scalable: false,
                cropBoxResizable: false,
                minCropBoxHeight: 2000,
                guides: false,
                cropend: function (e) {
                    makeTransformation('crop', jobId, $(this).cropper('getData'));
                }
            };

            
            image.cropper(options);

            $(document).on('click', '.transform-info', function (e) {
                e.preventDefault();
            });

            $(document).on('click', '.image-rotate-left', function (e) {
                e.preventDefault();

                if ($(this).hasClass('disabled')) {
                    return;
                }

                image.cropper('rotate', -90);
                makeTransformation('rotate', jobId, image.cropper('getData'));
            });

            $(document).on('click', '.image-rotate-right', function (e) {
                e.preventDefault();

                if ($(this).hasClass('disabled')) {
                    return;
                }

                image.cropper('rotate', 90);
                makeTransformation('rotate', jobId, image.cropper('getData'));
            });

            $(document).on('click', '.image-flip-horizontally', function (e) {
                e.preventDefault();

                if ($(this).hasClass('disabled')) {
                    return;
                }

                var reversed = -1 * image.cropper('getData').scaleX;
                image.cropper('scaleX', reversed);

                makeTransformation('flip', jobId, {flip_type: 'horizontal'});
            });

            $(document).on('click', '.image-flip-vertically', function (e) {
                e.preventDefault();

                if ($(this).hasClass('disabled')) {
                    return;
                }

                var reversed = -1 * image.cropper('getData').scaleY;
                image.cropper('scaleY', reversed);

                makeTransformation('flip', jobId, {flip_type: 'vertical'});
            });

            $(document).on('click', '.image-reset', function (e) {
                e.preventDefault();

                if ($(this).hasClass('disabled')) {
                    return;
                }

                image.cropper('reset');
                makeTransformation('rotate', jobId, image.cropper('getData'));
            });

            $(document).on('click', '.colour-options img', function (e) {
                e.preventDefault();
                var button = $(this);

                if ($(this).hasClass('disabled')) {
                    return;
                }

                makeTransformation('filter', jobId, {filter_type: button.data('filter-type')});
            });

            /**
             * Update The Hidden Fields
             */

            /**
             * Calculate wall dimensions and update quantity hidden field.
             */

            var updateWallPrice = function () {
                var dimensions = calculateWallDimension();
                var hiddenQuantity = $('[name="quantity"]');
                var hiddenVariation = $('[name="variation_id"]');

                                /**
                 * Quantity is actually now based on a 100th of a meter squared.
                 */
                var quantity = dimensions.squared * 100;
                hiddenQuantity.val(quantity);

                var hiddenWidth = $('[name="wallpaper_width"]');
                var hiddenHeight = $('[name="wallpaper_height"]');
                hiddenWidth.val(dimensions.width);
                hiddenHeight.val(dimensions.height);


                
                var applicationMethod = $('[name="application-method"]:checked');
                hiddenVariation.val(applicationMethod.val());

                var price = applicationMethod.data('price');
                var totalPrice = price * quantity;

                // Multiply price by 1.2 due to the client requiring VAT to be included
                $('.price').text((totalPrice * 1.2).toFixed(2));
            };
                        $(document).ready(function () {
                updateWallPrice();
            });
            
            $(document).on('click', '[name="dimension-unit"], .dimension-unit-label, [name="application-method"], .application-method-label', function () {
                updateWallPrice();
            });

            $(document).on('change keyup blur', '#dimensions-height, #dimensions-width', function () {
                var width = $('#dimensions-width').val();
                var height = $('#dimensions-height').val();

                if (window.currentWidth == width && window.currentHeight == height) {
                    return;
                }

                window.currentWidth = width;
                window.currentHeight = height;

                updateWallPrice();
                resizeAspectRatio(width, height);
            });

            function resizeAspectRatio(width, height) {
                options.aspectRatio = width / height;
                image.cropper('destroy').cropper(options);
            }

            image.on('built.cropper', function () {
                makeTransformation('crop', jobId, image.cropper('getData'));
            });

            function calculateWallDimension() {
                var width = $('#dimensions-width').val();
                var height = $('#dimensions-height').val();
                var unit = $('[name="dimension-unit"]:checked').val();

                var values = {};

                switch (unit) {
                    case 'centimeters':
                        values.width = width / 100;
                        values.height = height / 100;
                        break;
                    case 'meters':
                        values.width = width;
                        values.height = height;
                        break;
                    case 'inch':
                        values.width = width / 39.370;
                        values.height = height / 39.370;
                        break;
                }

                values.squared = (values.width * values.height).toFixed(2);

                return values;
            }

            /**
             * Update Canvas Cart
             */
            var updateCanvasHiddenFields = function () {
                var select = $('[name="canvas-variation"]');
                var selectedOption = select.find('option:selected');
                var hiddenVariation = $('[name="variation_id"]');

                // Multiply price by 1.2 due to the client requiring VAT to be included
                $('.price').text((selectedOption.data('price') * 1.2).toFixed(2));
                hiddenVariation.val(selectedOption.val());
            };

            function resizeCanvasAspectRatio() {
                var select = $('[name="canvas-variation"]');
                var selectedOption = select.find('option:selected');
                var layout = $('[name="layout"]:checked');
                var width = selectedOption.data('width');
                var height = selectedOption.data('height');

                if (layout.val() == 'portrait') {
                    resizeAspectRatio(width, height);
                    return;
                }

                resizeAspectRatio(height, width);
            }

            function updateOrientationHiddenField() {
                var layout = $('[name="layout"]:checked');
                var orientationHiddenField = $("[name='canvas_orientation']");

                orientationHiddenField.val(layout.val());
            }

            $(document).on('change', '[name="layout"]', function () {
                resizeCanvasAspectRatio();
                updateOrientationHiddenField();
                updatePreviewCss();
            });

            $(document).on('change', '[name="canvas-variation"]', function () {
                updateCanvasHiddenFields();
                resizeCanvasAspectRatio();
                updatePreviewCss();
            });

            
            
            
            function updateCollageTemplateHiddenField() {
                var selectedTemplate = $('[name="canvas-template"]:checked').val();
                var hiddenField = $('[name="canvas_template"]');
                hiddenField.val(selectedTemplate);
            }

            $(document).on('change', '[name="canvas-template"]', function () {
                updateCollageTemplateHiddenField();
                console.log('chnanged');
            });

            
            $(document).on('click', '.upload-zip-button', function (e) {
                e.preventDefault();
                var fileInput = $('#user_collage_zip');
                fileInput.click();
            });

            $(document).on('change', '#user_collage_zip', function () {
                var input = $(this);
                var file = this.files[0];

                if (this.files.length == 0) {
                    return;
                }

                if (file.type !== 'application/zip' && file.type !== 'application/x-zip-compressed') {
                    alert('You must select a zip file');
                    return;
                }

                var formData = new FormData();
                formData.append('file', file);

                var submitButton = $('.single_add_to_cart_button');
                var uploadButton = $('.upload-zip-button');
                var uploadText = uploadButton.html();

                $.ajax({
                    url: 'https://api.createawall.co.uk/library/job/update-original-file/05eb03a7-b22d-11e6-9a4d-00155d141523/',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    beforeSend: function () {
                        submitButton.prop('disabled', true);
                        uploadButton.html('Uploading your zip file...');
                    },
                    error: function () {
                        alert('There was an error uploading your file.');
                        uploadButton.html(uploadText);
                    },
                    success: function (response) {
                        alert('Your zip file has been successfully uploaded.');
                        $('.single_add_to_cart_button').addClass('has-file');
                        submitButton.prop('disabled', false);
                        uploadButton.html("CHOOSE A DIFFERENT ZIP FILE");
                    },
                    complete: function () {

                    }
                });
            });

            $(document).on('click', '#save-design', function (e) {
                e.preventDefault();
                var button = $(this);
                var buttonVal = button.html();

                button.html('<img src="https://api.createawall.co.uk/img/loading-small.gif">');

                setTimeout(function () {
                    button.html(buttonVal);
                    $('#save-modal').modal('show');
                }, 1000);
            });

            $(document).on('click', '.previews img', function () {
                $('#show-share-modal').click();
            });

            $('#method-info-modal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget);
                var name = button.data('method-name');
                var description = button.data('method-description');

                var modal = $(this);
                modal.find('.modal-title').text(name);
                modal.find('.modal-body p').html(description);
            });

            function updatePreviewCss() {
                var layout = $('[name="layout"]:checked').val();
                var size = $('[name="canvas-variation"] option:selected').data('size');
                var horizontalPreviews = $('.horizontal-preview-button');
                var verticalPreviews = $('.vertical-preview-button');

                $('.horizontal-preview, .vertical-preview').removeClass('active');

                switch (layout) {
                    case 'landscape':
                        horizontalPreviews.show();
                        verticalPreviews.hide();
                        var previewType = 'horizontal';
                        break;
                    case 'portrait':
                        verticalPreviews.show();
                        horizontalPreviews.hide();
                        var previewType = 'vertical';
                        break;
                }

                var previews = $('.' + previewType + '-preview');
                $(previews[0]).addClass('active');
                previews.each(function (key, preview) {
                    var preview = $(preview);
                    var id = $(preview).attr('id');
                    var settings = previewSettings['canvas'][id][size];
                    var image = preview.find('.backdrop img');
                    var overlay = preview.find('.overlay img');

                    overlay.attr('src', settings.overlayUrl);
                    image.css('top', settings.top);
                    image.css('width', settings.width);
                    image.css('left', settings.left);

                    console.log(id, settings);
                });
            }

            $(document).on('click', '.go-back', function (e) {
                e.preventDefault();
                window.history.back();
            });

            function updateCanvasBleedType() {
                var select = $('#canvas-bleed-type');
                var selectedType = select.find('option:selected').val();
                var hiddenField = $("[name='canvas_bleed']");
                hiddenField.val(selectedType);
            }

            $(document).on('change', '#canvas-bleed-type', function (e) {
                updateCanvasBleedType();
            });

            $(document).on('click', '.single_add_to_cart_button.is-collage', function (e) {
                var button = $(this);

                if (!button.hasClass('has-file')) {
                    e.preventDefault();
                    alert('You must upload a zip file before adding to your bag.');
                }
            });
/*
            $(document).on('click', '#email-design', function (e) {
                var sendButton = $(this);
                var emailAddress = $('#email-address');
                var saveModal = $('#save-modal');

                if (sendButton.hasClass('disabled')) {
                    return;
                }

                if (emailAddress.val().length == 0) {
                    emailAddress.focus();
                    alert('Please enter your email address');

                    return;
                }

                $.ajax({
                    url: 'https://api.createawall.co.uk/library/job/05eb03a7-b22d-11e6-9a4d-00155d141523/photo_wall_mural/email-design',
                    data: {
                        email_address: emailAddress.val()
                    },
                    beforeSend: function () {
                        sendButton.html('Sending email...');
                        sendButton.addClass('disabled');
                    },
                    success: function () {
                        saveModal.modal('hide');
                        alert('Design has been sent to ' + emailAddress.val());
                    },
                    error: function (errors) {
                        alert(errors.responseJSON.message);
                    },
                    complete: function () {
                        sendButton.html('Send Email');
                        sendButton.removeClass('disabled');
                    }
                });
            });*/

        })(jQuery);