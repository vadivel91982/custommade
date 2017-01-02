{*
* @version 1.0
* @author 202-ecommerce
* @copyright 2014-2015 202-ecommerce
* @license ?
*}
{include file="$tpl_dir./errors.tpl"}
<script type="text/javascript">
// <![CDATA[

// PrestaShop internal settings
    var currencySign = "{$currencySign|escape:'html':'UTF-8'|htmlspecialchars_decode:3}";
    var currencyRate = '{$currencyRate|floatval}';
    var currencyFormat = '{$currencyFormat|intval}';
    var currencyBlank = '{$currencyBlank|intval}';
    var taxRate = {$tax_rate|floatval};
    var jqZoomEnabled = {if $jqZoomEnabled}true{else}false{/if};

        //JS Hook
        var oosHookJsCodeFunctions = new Array();

        // Parameters
        var id_product = '{$product->id|intval}';


    {if !isset($priceDisplayPrecision)}
        {assign var='priceDisplayPrecision' value=2}
    {/if}
    {if !$priceDisplay || $priceDisplay == 2}
        {assign var='productPrice' value=$product->getPrice(true, $smarty.const.NULL, $priceDisplayPrecision)}
        {assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(false, $smarty.const.NULL)}
    {elseif $priceDisplay == 1}
        {assign var='productPrice' value=$product->getPrice(false, $smarty.const.NULL, $priceDisplayPrecision)}
        {assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(true, $smarty.const.NULL)}
    {/if}

        var productPriceWithoutReduction = '{$productPriceWithoutReduction|escape:"htmlall":"UTF-8"}';
        var productPrice = '{$productPrice|escape:"htmlall":"UTF-8"}';

//]]>
</script>

{if ($product->show_price AND !isset($restricted_country_mode)) OR isset($groups) OR $product->reference OR (isset($HOOK_PRODUCT_ACTIONS) && $HOOK_PRODUCT_ACTIONS)}
    <!-- add to cart form-->
    <form id="buy_block" class="span4" {if $PS_CATALOG_MODE AND !isset($groups) AND $product->quantity > 0}class="hidden"{/if} action="{$link->getPageLink('cart')|escape:'htmlall':'UTF-8'}" method="post">

        <!-- hidden datas -->
        <p class="hidden">
            <input type="hidden" name="token" value="{$static_token|escape:'htmlall':'UTF-8'}" />
            <input type="hidden" name="id_product" value="{$product->id|intval}" id="product_page_product_id" />
            <input type="hidden" name="add" value="1" />
            <input type="hidden" name="id_product_attribute" id="idCombination" value="" />
        </p>
        <div class="container-custommade">    
            <div class="col-md-12" >
                <div class="row">
                    <div class="custom-top">
                        <h1 itemprop="name" class="product-title"><strong>{$product->name|escape:'htmlall':'UTF-8'}</strong></h1>
                        <div class="prod_desc">
                            <h2>PERSONNALISEZ LE PAPIER PEINT KUBE</h2>
                            <p>
                                {$product->description_short|escape:'html':'UTF-8'|htmlspecialchars_decode:3}
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="section-content-start">
                <div class="row">
                    <div class="overall-container">
                        <div class="col-md-3" id="left-col">
                            <div class="cart-section wall-dimensions">
                                <h3>1. Entrez vos dimensions</h3>
                                <div class="input-group input-group-sm" style="display:none;">
                                    <input type="text" class="form-control" id="dataX" placeholder="x">
                                </div>
                                <div class="input-group input-group-sm" style="display:none;">
                                    <input type="text" class="form-control" id="dataY" placeholder="y">
                                </div>
                                <div class="form-horizontal docs-data">
                                    <div class="form-group widthbox">
                                        <label for="width" class="control-label">Largeur (cm)</label>
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-arrows-h" aria-hidden="true"></i>
                                            </div>
                                            <input value="300" class="form-control" id="dataWidth" type="text" placeholder="{$getPriceDetails->cust_width|escape:'htmlall':'UTF-8'} cm max">
                                        </div>
                                    </div>
                                    <div class="form-group heightbox">
                                        <label for="height" class="control-label">Hauteur (cm)</label>
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-arrows-v" aria-hidden="true"></i>
                                            </div>
                                            <input value="300" class="form-control" id="dataHeight" type="text"  placeholder="{$getPriceDetails->cust_height|escape:'htmlall':'UTF-8'} cm max">
                                        </div>
                                    </div>
                                    <div><a id="button-scroll" title="Autres dimensions?">Autres dimensions?</a></div>
                                </div>


                                <div class="customise-section">
                                    <h3>2. Choisissez un effet</h3>
                                    <div class="btn-group transform-buttons" role="group" aria-label="...">                              
                                        <div id="actions">
                                            <div class="docs-buttons">		
                                                <!--<button type="button" data-method="rotate" data-option="90" class="btn btn-default image-rotate-left">
                                                    <i class="fa fa-undo" aria-hidden="true"></i> Rotation 90&deg;<br />
                                                </button>-->
                                                <button type="button" class="btn btn-default image-rotate-left">
                                                    Rotation 90&deg;<br />
                                                </button>

                                                <button type="button" class="btn btn-default flipbtns image-flip-horizontally" data-method="scaleX" data-option="-1">
                                                    Effet Mirror<br />
                                                </button>
                                                <button type="button" class="btn btn-default flipbtns image-flip-vertically" data-method="scaleY" data-option="-1" style="display:none;">
                                                    Effet Mirror<br />
                                                </button>
                                                <button type="button" class="btn btn-default image-grid">
                                                    Montrer les l&eacute;s
                                                </button>
                                                <!-- Show the cropped image in modal -->
                                                <div class="modal docs-cropped" id="getCroppedCanvasModal"   role="dialog" aria-hidden="true" aria-labelledby="getCroppedCanvasTitle">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header" style="display:none;">
                                                                <button data-dismiss="modal" aria-hidden="true"></button>
                                                                <h4 id="getCroppedCanvasTitle"></h4>
                                                            </div>
                                                            <div class="modal-body"></div>
                                                            <div class="modal-footer" style="display:none;">
                                                                <button data-dismiss="modal"></button>
                                                                <a  id="download" href="javascript:void(0);"></a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="docs-toggles" style="display:none;">
                                                    <div class="docs-aspect-ratios" data-toggle="buttons">   
                                                    </div>
                                                </div>
                                            </div>								
                                        </div>	
                                    </div>


                                    <div class="price-section">
                                        <p class="our_price_display "><b>PRIX:</b>
                                            <span class="price our_price_display"> 
                                                <meta itemprop="currency" content="EUR" />
                                                {if $priceDisplay >= 0 && $priceDisplay <= 2}
                                                    <span itemprop="price" style="display: none;">{sprintf("%.02f", $productPrice)|escape:'htmlall':'UTF-8'}</span>
                                                {/if}
                                                <span itemprop="condition" style="display: none;" content="new"></span>
                                                {if (!$allow_oosp && $product->quantity <= 0) OR !$product->available_for_order OR (isset($restricted_country_mode) AND $restricted_country_mode) OR $PS_CATALOG_MODE}
                                                    <span itemprop="availability" style="display: none;" content="out_of_stock"></span>
                                                {else}
                                                    <span itemprop="availability" style="display: none;" content="in_stock"></span>
                                                {/if}
                                                {if $priceDisplay >= 0 && $priceDisplay <= 2}
                                                    <span id="our_price_display">{convertPrice price=$productPrice}</span>
                                                {/if}
                                            </span>
                                        </p>
                                        <span class="sq-price">{$getPriceDetails->sq_meter_price|floatval} {$currencySign|escape:'html':'UTF-8'|htmlspecialchars_decode:3}/m2</span>
                                    </div>

                                    <div class="button-sec">
                                        {if (!$allow_oosp && $product->quantity <= 0) OR !$product->available_for_order OR (isset($restricted_country_mode) AND $restricted_country_mode) OR $PS_CATALOG_MODE}
                                            <p id="add_to_cart" class="buttons_bottom_block">
                                                <span class="exclusive">
                                                    {l s='Ajouter au panier' mod='custommade'}
                                                </span>
                                            </p>
                                        {else}
                                            <p id="add_to_cart" class="buttons_bottom_block">
                                                <input type="button" id="addcartbtn" name="Submit" value="{l s='Ajouter au panier' mod='custommade'}" class="exclusive" />
                                            </p>
                                        {/if}
                                        <p>Livraison sous {$getPriceDetails->cust_delivery|intval} jours</p>
                                        {if ($getPriceDetails->sample_product > 0)}
                                            <a href="javascript:void(0)" id="sampleButton" onclick="addSampleToCart();
                                                    return false;">Commander un &eacute;chantillon</a>
                                        {/if}
                                    </div>

                                    {assign var="color_feature" value=""}

                                    {if isset($features) && $features|is_array && $features|count}
                                        {foreach from=$features item='feature'}
                                            {if $feature.id_feature == 1}
                                                {assign var="color_feature" value=$feature.value}
                                            {/if}
                                        {/foreach}
                                    {/if}

                                </div> 
                            </div>
                        </div>

                        <div class="col-md-9" id="right-col"> 
                            <div class="img-resize imr_top">
                                <img id="dimension_indicator" src="{$rootUrl|escape:'htmlall':'UTF-8'}modules/custommade/views/img/top.png">
                                <span class="length-cm cmvalue">200cm</span>
                            </div>
                            <div class="img-container">
                                <img src="{$image_direct_url|escape:'htmlall':'UTF-8'}" alt="Picture"/>
                            </div>
                            <div class="img-resize-right imr_right">
                                <img id="dimension_indicator_right" src="{$rootUrl|escape:'htmlall':'UTF-8'}modules/custommade/views/img/right.png">
                                <span class="length-cm-right cmvalue">200cm</span>
                            </div>
                        </div><div class="clearfix"></div>



                        <div class="accessories">
                            <div class="col-md-8">
                                <p>Au fil des Couleurs - Volume 1</p>
                                <h3>Référence : {$product->reference|escape:"htmlall":"UTF-8"}</h3>
                                {$product->description|escape:'html':'UTF-8'|htmlspecialchars_decode:3}
                            </div>
                            {if isset($accessories) && $accessories}
                                <div class="col-md-4">
                                        <span style="padding-right:10px;float:left;">{l s='Coloris' mod='custommade'}</span> 
                                        <select style="width:250px" onchange="javascript:document.location.href = this.value">
                                            <option value="">{$color_feature|escape:'htmlall':'UTF-8'} - {l s='Ref.' mod='custommade'} {$product->reference|escape:'htmlall':'UTF-8'}</option>
                                            {foreach from=$accessories item=accessoire}
                                                <option value="{$accessoire.link|escape:'htmlall':'UTF-8'}">{foreach from=$accessoire.features item=feature}{if $feature.id_feature==1}{$feature.value|escape:'htmlall':'UTF-8'}{/if}{/foreach} - {l s='Ref.' mod='custommade'} {$accessoire.reference|escape:'htmlall':'UTF-8'}</option>
                                            {/foreach}
                                        </select>
                                    <div class="clear" style="padding-top: 20px;"></div>
                                    <ul class="list_accessories">
                                        {assign var="cover" value=""}
                                        {if isset($images) && $images|is_array && $images|count}
                                            {foreach from=$images key=id_image item='image' name="images"}
                                                {if $image.cover || $smarty.foreach.images.index == 1}
                                                    {assign var="cover" value=$id_image}
                                                    {break}
                                                {/if}
                                            {/foreach}
                                        {/if}

                                        <li>
                                            <img src="{$link->getImageLink($product->link_rewrite, $product->id|cat:'-'|cat:$cover|escape:'htmlall':'UTF-8', 'home_default')}" alt="" height="46" width="46" />
                                        </li>

                                        {foreach from=$accessories item=accessoire}
                                            <li><a href="{$accessoire.link|escape:'htmlall':'UTF-8'}"><img src="{$link->getImageLink($accessoire.link_rewrite, $accessoire.id_image, 'large_default')|escape:'htmlall':'UTF-8'}" class="img-responsive" width="46" height="46" /></a></li>
                                                {/foreach}
                                    </ul>
                                    {if $accessories|@count > 5}
                                        <span class="attributes_more">{l s='Voir plus' mod='custommade'}</span>
                                    {/if}
                                    <div class="clear"></div>
                                </div>
                            {/if}
                            <div class="clearfix"></div>
                        </div>

                    </div>
                </div>

                <div class="previews customise-section" id="previews-container">
                    <h1 class="title-module-preview">INSPIRATIONS AVEC LE DÉCOR KUBE EMERAUDE</h1>
                    <div class="col-xs-12 col-sm-2 no-gutter" style="padding-right:0;padding-left:0;">
                        <!-- required for floating -->
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs tabs-left">
                            <!-- 'tabs-right' for right tabs -->
                            {foreach from=$getUnivers1 key=k item=universeImage}
                                <li {if (1 == $k+1)}class="active"{/if}>
                                    <a href="#scene{$k+1|escape:'htmlall':'UTF-8'}" data-toggle="tab"><img src="{$img_dir|escape:'htmlall':'UTF-8'}{$universeImage['image']|escape:'htmlall':'UTF-8'}" width="90px"></a>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                    <div class="col-xs-12 col-sm-10 no-gutter" >
                        <!-- Tab panes -->
                        <div class="tab-content">
                            {foreach from=$getUnivers1 key=k item=universeImage}
                                <div class="tab-pane {if (1 == $k+1)}active{/if} docs-preview" id="scene{$k+1|escape:'htmlall':'UTF-8'}">
                                    <div class="backdrop" style="height:76%;">
                                        <img class="preview" src="" style="left:0;top:0;">
                                        <span class="gridlayout"></span> 										
                                    </div>
                                    <div class="overlay">
                                        <img src="{$img_dir|escape:'htmlall':'UTF-8'}{$universeImage['image']|escape:'htmlall':'UTF-8'}">
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                        <div class="span2 clear product_social">
                            <ul class="social align_center">{strip}
                                    <li><a title="Facebook" href="https://www.facebook.com/sharer.php?u={$link->getProductLink($product)|rawurlencode}&amp;t={$product->name} sur Au Fil des Couleurs" class="facebook-button" rel="nofollow" onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=500,width=700');return false;"><img src="{$img_dir}social_fb.png" alt="Facebook" /></a></li>
                                    <li><a title="Twitter" href="https://twitter.com/share?url={$link->getProductLink($product)|rawurlencode}&amp;text={$product->name} sur Au Fil des Couleurs" class="tweet-button" rel="nofollow" onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=400,width=700');return false;"><img src="{$img_dir}social_twitter.png" alt="Twitter" /></a></li>
                                    <li><a title="Pinterest" href="https://www.pinterest.com/pin/create/button/?url={$link->getProductLink($product)|rawurlencode}&amp;media={$link->getImageLink($product->link_rewrite, $cover.id_image, 'thickbox_default')|rawurlencode}&amp;description={$product->name} sur Au Fil des Couleurs" class="pin-it-button" rel="nofollow" onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=350,width=850');return false;"><img src="{$img_dir}social_pint.png" alt="Pinterest" /></a></li>
                                    {*<li><a title="Google +" href="https://plus.google.com/share?url={$link->getProductLink($product)|rawurlencode}&amp;hl=fr" class="google-button" rel="nofollow" onclick="javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=450,width=650');return false;"><img src="{$img_dir}social_google.png" alt="Google" /></a></li>*}				
                                    <li class="print"><a onclick="$.get('{$img_dir}blank.gif');" href="javascript:print();"><img src="{$img_dir}social_print.png" alt="{l s='Print'}" /></a></li>
                            {/strip}
                            </ul>
                        </div>
                    </div><div class="clearfix"></div>
                    
                </div>

                <div class="custom-product-detail" id="custom-product-detail">
                    <h1 class="title-module-preview">projets speciaux</h1>
                    <div class="col-xs-12">
                        <p>Notre studio de création vous aide  à trouver le decor de vos rêve, à le personnaliser ou le créer. Que vous soyez un particulier ou un professionnel,N’hésitez pas à nous contacter !</p>
                        <p class="buttons_bottom_block1">
                            <a href="#" class="exclusive">EN SAVOIR PLUS</a>
                        </p>
                    </div>                    
                </div>
            </div>
        </div>
    </form>
{/if}

<script>

    //window.onload = function () {

    //'use strict';
    var newCustomPrice = '';
    var pricePerMeterSq = {$getPriceDetails->sq_meter_price|escape:'html':'UTF-8'};
    var allowedMaxWidth = {$getPriceDetails->cust_width|escape:'html':'UTF-8'};
    var allowedMaxHeight = {$getPriceDetails->cust_height|escape:'html':'UTF-8'};
    var sampleProductId = '{$getPriceDetails->sample_product|escape:'html':'UTF-8'}';
    var customGridSize = {$getPriceDetails->grid_size|escape:'html':'UTF-8'};
    var rootUrl = '{$rootUrl|escape:"html":"UTF-8"}';
    if (sampleProductId != '') {
        var samplePrice = {sprintf("%.02f", $sampleProductInfo->price|intval)};
    } else {
        var samplePrice = '';
    }

    var Cropper = window.Cropper;
    var URL = window.URL || window.webkitURL;
    var container = document.querySelector('.img-container');
    var image = container.getElementsByTagName('img').item(0);
    var download = document.getElementById('download');
    var actions = document.getElementById('actions');
    var dataX = document.getElementById('dataX');
    var dataY = document.getElementById('dataY');
    var dataHeight = document.getElementById('dataHeight');
    var dataWidth = document.getElementById('dataWidth');
    var dataRotate = document.getElementById('dataRotate');
    var dataScaleX = document.getElementById('dataScaleX');
    var dataScaleY = document.getElementById('dataScaleY');
    var options = {
        /*  viewMode: 1,
         aspectRatio: 1 / 1,
         dragMode: 'move',
         checkCrossOrigin: false,
         zoomOnWheel: false,
         zoomable: false,
         guides: false,
         cropBoxResizable: false,
         movable: false,
         minCropBoxHeight: 1000,
         minContainerWidth: 200,
         minContainerHeight: 550, */

        viewMode: 1, // Can use 'viewMode: 3' to remove the canvas borders but causes zoom issues on rotate.
        aspectRatio: 1 / 1,
        dragMode: 'move',
        checkCrossOrigin: false,
        zoomOnWheel: false,
        zoomable: false,
        movable: false,
        // scalable: false,
        cropBoxResizable: false,
        /*minCropBoxHeight: 1500,
         minContainerWidth: 200,
         minContainerHeight: 600,*/
        guides: false,
        //minCropBoxWidth: 0,
        minCropBoxHeight: 9000,
        //minContainerWidth: 200,
        //minContainerHeight: 600,

        ready: function (e) {
            if (jQuery.trim(sessionStorage.cropData) != '') {
                var prevCropDataOrg = JSON.parse(sessionStorage.cropData);
                cropper.setData(prevCropDataOrg);
                //console.log(cropper.getData());
                if (jQuery.trim(sessionStorage.hasGrid) == '1') {
                    jQuery('.gridlayout').addClass('gridbg');
                    jQuery('.image-grid').addClass('grid_active');
                    createGrid(customGridSize);
                    setTimeout(function () {
                        var previewWidth = jQuery('.tab-content .active .backdrop .preview').width();
                        var previewHeight = jQuery('.tab-content .active .backdrop .preview').height();
                        $('.backdrop .gridlayout').css('width', previewWidth + 'px');
                        $('.backdrop .gridlayout').css('height', previewHeight + 'px');

                        setNewCustomPrice();
                    }, 500);
                }
                jQuery('#dataWidth').val(sessionStorage.customWidth);
                jQuery('#dataHeight').val(sessionStorage.customHeight);
            } else {
                /*var newOpt = {
                 width: 300,
                 height: 300,
                 x: 0,
                 y: 0
                 };
                 cropper.setData(newOpt);*/
            }

            if (jQuery.trim(sessionStorage.aspectRatio) != '') {
                cropper.setAspectRatio(sessionStorage.aspectRatio);
            }

            dynamicImage = image.cropper.getCroppedCanvas().toDataURL('image/jpeg', 1);
            $('.preview').attr('src', dynamicImage);
            setCropToSession();
            setNewCustomPrice();
        },
        cropstart: function (e) {
            //console.log(e.type, e.detail.action);
            setCropToSession();
            dynamicImage = image.cropper.getCroppedCanvas().toDataURL('image/jpeg', 1);
            $('.preview').attr('src', dynamicImage);
        },
        cropmove: function (e) {
            //console.log(e.type, e.detail.action);
            setCropToSession();
            dynamicImage = image.cropper.getCroppedCanvas().toDataURL('image/jpeg', 1);
            $('.preview').attr('src', dynamicImage);
        },
        cropend: function (e) {
            //console.log(e.type, e.detail.action);
            setCropToSession();
            dynamicImage = image.cropper.getCroppedCanvas().toDataURL('image/jpeg', 1);
            $('.preview').attr('src', dynamicImage);
        },
        crop: function (e) {
            var data = e.detail;

            //console.log(e.type);
            dataX.value = Math.round(data.x);
            dataY.value = Math.round(data.y);
            // dataHeight.value = Math.round(data.height);
            //dataWidth.value = Math.round(data.width);
            //dataRotate.value = typeof data.rotate !== 'undefined' ? data.rotate : '';
            //dataScaleX.value = typeof data.scaleX !== 'undefined' ? data.scaleX : '';
            //dataScaleY.value = typeof data.scaleY !== 'undefined' ? data.scaleY : '';
        },
        zoom: function (e) {
            //console.log(e.type, e.detail.ratio);
            var currentCropData = cropper.getData();
            sessionStorage.cropData = JSON.stringify(currentCropData);
        }
    };
    var cropper = new Cropper(image, options);
    var originalImageURL = image.src;
    var uploadedImageURL;

    // Tooltip
    $('[data-toggle="tooltip"]').tooltip();


    // Buttons
    if (!document.createElement('canvas').getContext) {
        $('button[data-method="getCroppedCanvas"]').prop('disabled', true);
    }

    if (typeof document.createElement('cropper').style.transition === 'undefined') {
        $('button[data-method="rotate"]').prop('disabled', true);
        $('button[data-method="scale"]').prop('disabled', true);
    }


    // Download
    if (typeof download.download === 'undefined') {
        download.className += ' disabled';
    }


    // Options
    actions.querySelector('.docs-toggles').onchange = function (event) {
        var e = event || window.event;
        var target = e.target || e.srcElement;
        var cropBoxData;
        var canvasData;
        var isCheckbox;
        var isRadio;

        if (!cropper) {
            return;
        }

        if (target.tagName.toLowerCase() === 'label') {
            target = target.querySelector('input');
        }

        isCheckbox = target.type === 'checkbox';
        isRadio = target.type === 'radio';

        if (isCheckbox || isRadio) {
            if (isCheckbox) {
                options[target.name] = target.checked;
                cropBoxData = cropper.getCropBoxData();
                canvasData = cropper.getCanvasData();

                options.ready = function () {
                    console.log('ready');
                    cropper.setCropBoxData(cropBoxData).setCanvasData(canvasData);
                };
            } else {
                options[target.name] = target.value;
                options.ready = function () {
                    console.log('ready');
                };
            }

            // Restart
            cropper.destroy();
            cropper = new Cropper(image, options);
        }
    };


    // Methods
    actions.querySelector('.docs-buttons').onclick = function (event) {
        var e = event || window.event;
        var target = e.target || e.srcElement;
        var result;
        var input;
        var data;

        if (!cropper) {
            return;
        }

        while (target !== this) {
            if (target.getAttribute('data-method')) {
                break;
            }

            target = target.parentNode;
        }

        if (target === this || target.disabled || target.className.indexOf('disabled') > -1) {
            return;
        }

        data = {
            method: target.getAttribute('data-method'),
            target: target.getAttribute('data-target'),
            option: target.getAttribute('data-option'),
            secondOption: target.getAttribute('data-second-option')
        };

        if (data.method) {
            if (typeof data.target !== 'undefined') {
                input = document.querySelector(data.target);

                if (!target.hasAttribute('data-option') && data.target && input) {
                    try {
                        data.option = JSON.parse(input.value);
                    } catch (e) {
                        console.log(e.message);
                    }
                }
            }

            if (data.method === 'getCroppedCanvas') {
                data.option = JSON.parse(data.option);
            }

            result = cropper[data.method](data.option, data.secondOption);

            switch (data.method) {
                case 'scaleX':
                case 'scaleY':
                    target.setAttribute('data-option', -data.option);
                    break;

                case 'getCroppedCanvas':
                    if (result) {

                        // Bootstrap's Modal
                        $('#getCroppedCanvasModal').modal().find('.modal-body').html(result);

                        if (!download.disabled) {
                            download.href = result.toDataURL('image/jpeg');
                        }
                    }

                    break;

                case 'destroy':
                    cropper = null;

                    if (uploadedImageURL) {
                        URL.revokeObjectURL(uploadedImageURL);
                        uploadedImageURL = '';
                        image.src = originalImageURL;
                    }

                    break;
            }

            if (typeof result === 'object' && result !== cropper && input) {
                try {
                    input.value = JSON.stringify(result);
                } catch (e) {
                    console.log(e.message);
                }
            }
        }
    };

    $(document).on('click', '.image-grid', function (e) {
        e.preventDefault();
        //alert('testing');
        jQuery(this).toggleClass('grid_active');
        //
        var button = $(this);

        $('.gridlayout').toggleClass('gridbg');
        if ($('.image-grid').hasClass('grid_active')) {
            jQuery('.cropper-crop-box .gridlayout').html('');
            createGrid(customGridSize);
            sessionStorage.hasGrid = '1';
        } else {
            jQuery('.cropper-crop-box .gridlayout').html('');
            //createGrid(100);
            sessionStorage.hasGrid = '0';
        }
        if ($('.gridlayout').hasClass('gridbg')) {
            //sessionStorage.hasGrid = '1';
            var previewWidth = jQuery('.tab-content .active .backdrop .preview').width();
            var previewHeight = jQuery('.tab-content .active .backdrop .preview').height();
            $('.backdrop .gridlayout').css('width', previewWidth + 'px');
            $('.backdrop .gridlayout').css('height', previewHeight + 'px');
        } else {
            //sessionStorage.hasGrid = '0';
        }

        if ($(this).hasClass('disabled')) {
            return;
        }
    });

    document.body.onkeydown = function (event) {
        var e = event || window.event;

        if (!cropper || this.scrollTop > 300) {
            return;
        }

        switch (e.keyCode) {
            case 37:
                e.preventDefault();
                cropper.move(-1, 0);
                break;

            case 38:
                e.preventDefault();
                cropper.move(0, -1);
                break;

            case 39:
                e.preventDefault();
                cropper.move(1, 0);
                break;

            case 40:
                e.preventDefault();
                cropper.move(0, 1);
                break;
        }
    };

    jQuery(document).on('click', '.image-rotate-left', function () {
        jQuery('.flipbtns').attr('disabled','true');
        cropper.rotate(90);
        var currentCropData = cropper.getData();
        if (currentCropData.rotate == 90 || currentCropData.rotate == 270) {
            jQuery('.image-flip-horizontally').hide();
            jQuery('.image-flip-vertically').show();
        } else {
            jQuery('.image-flip-horizontally').show();
            jQuery('.image-flip-vertically').hide();
        }

        setCropToSession();
        dynamicImage = image.cropper.getCroppedCanvas().toDataURL('image/jpeg', 1);
        $('.preview').attr('src', dynamicImage);
        setIndicatorPosition();
        setNewCustomPrice();
        removeStripes();
        setTimeout(function(){
            jQuery('.flipbtns').removeAttr('disabled');
        },1000);
        
    });

    jQuery(document).on('click', '.flipbtns', function () {
        jQuery('.image-rotate-left').attr('disabled','true');
        setCropToSession();
        dynamicImage = image.cropper.getCroppedCanvas().toDataURL('image/jpeg', 1);
        $('.preview').attr('src', dynamicImage);
        setIndicatorPosition();
        setNewCustomPrice();
        removeStripes();
        setTimeout(function(){
            jQuery('.image-rotate-left').removeAttr('disabled');
        },1000);
    });

    jQuery(document).on('keyup', '#dataWidth', function () {
        var curVal = jQuery.trim(jQuery(this).val());
        curVal = curVal * 1;
        if (curVal > allowedMaxWidth) {
            curVal = allowedMaxWidth;
            jQuery(this).val(allowedMaxWidth);
        }
        /*var newOpt = {
         width: curVal
         };
         cropper.setData(newOpt);*/
        var tempAspectRatio = jQuery('#dataWidth').val() / jQuery('#dataHeight').val();
        cropper.setAspectRatio(tempAspectRatio);
        sessionStorage.aspectRatio = tempAspectRatio;
        dynamicImage = image.cropper.getCroppedCanvas().toDataURL('image/jpeg', 1);
        $('.preview').attr('src', dynamicImage);
        setCropToSession();
        setIndicatorPosition();
        setNewCustomPrice();
    });

    jQuery(document).on('keyup', '#dataHeight', function () {
        var curVal = jQuery.trim(jQuery(this).val());
        curVal = curVal * 1;
        if (curVal > allowedMaxHeight) {
            curVal = allowedMaxHeight;
            jQuery(this).val(allowedMaxHeight);
        }
        /*var newOpt = {
         height: curVal
         };
         cropper.setData(newOpt);*/
        var tempAspectRatio = jQuery('#dataWidth').val() / jQuery('#dataHeight').val();
        cropper.setAspectRatio(tempAspectRatio);
        sessionStorage.aspectRatio = tempAspectRatio;
        dynamicImage = image.cropper.getCroppedCanvas().toDataURL('image/jpeg', 1);
        $('.preview').attr('src', dynamicImage);
        setCropToSession();
        setIndicatorPosition();
        setNewCustomPrice();
    });

    jQuery(document).on('click', '#addcartbtn', function () {
        var finalData = cropper.getData(true);
        finalData.stripe = sessionStorage.hasGrid;
        finalData.customPrice = newCustomPrice;
        finalData.gridSize = customGridSize;
        finalData.userWidth = jQuery('#dataWidth').val();
        finalData.userHeight = jQuery('#dataHeight').val();
        console.log(finalData);
        var finalDataString = JSON.stringify(finalData);
        jQuery.post(rootUrl + 'module/custommade/cropper?action=setdata&pid=' + id_product, {
            data: finalDataString
        }, function () {
            //jQuery('#buy_block').submit();
            ajaxCart.add(id_product, '', true, null, 1, null);
            setTimeout(function () {

                if (jQuery('.popin-product .product-img').length > 0) {
                    jQuery('.popin-product .product-img').attr('src', "{$image_direct_url|escape:'htmlall':'UTF-8'}");
                    jQuery('.popin-title').html('1 x <strong>{$product->name|escape:"htmlall":"UTF-8"}</strong>');
                    jQuery('.popin-reference').html('Référence : {$product->reference|escape:"htmlall":"UTF-8"}');
                }
            }, 1000);
        });

    });

    jQuery(document).on('click', '.attributes_more', function () {
        jQuery('.list_accessories').css('height', 'auto');
        jQuery(this).hide();
    });

    function removeStripes() {
        $('.gridlayout').removeClass('gridbg');
        $('.image-grid').removeClass('grid_active');
        jQuery('.gridlayout').html('');
        sessionStorage.hasGrid = '0';
    }

    function setCropToSession() {
        var currentCropData = cropper.getData(true);
        currentCropData.gridSize = customGridSize;
        sessionStorage.cropData = JSON.stringify(currentCropData);
        sessionStorage.customWidth = jQuery('#dataWidth').val();
        sessionStorage.customHeight = jQuery('#dataHeight').val();

        var cropBoxData = cropper.getCropBoxData();
        //jQuery('.tab-content .active .backdrop .preview').width(cropBoxData.width);
        jQuery('.backdrop .preview').width(cropBoxData.width);

        setIndicatorPosition();
        setNewCustomPrice();
    }

    function setNewCustomPrice() {
        
        
        //newCustomPrice = (((cropper.getData(true).width) * (cropper.getData(true).height)) / 10000) * pricePerMeterSq;
        var widthValue = parseFloat(jQuery('#dataWidth').val());
        var heightValue = parseFloat(jQuery('#dataHeight').val());
        
        var dimension = widthValue * heightValue;
        newCustomPrice = dimension * (pricePerMeterSq);
        
        
        
        /*newCustomPrice = (((widthValue) * (heightValue)) / 10000) * pricePerMeterSq;

        newCustomPrice = newCustomPrice.toFixed(2);*/
//        alert(number_format(newCustomPrice, 2, ',', ' '));
        var formattedPrice = number_format(newCustomPrice, 2, ',', ' ');

        jQuery('#our_price_display').html(formattedPrice + ' ' + currencySign);


        setTimeout(function () {
            var previewWidth = jQuery('.tab-content .active .backdrop .preview').width();
            var previewHeight = jQuery('.tab-content .active .backdrop .preview').height();
            $('.backdrop .gridlayout').css('width', previewWidth + 'px');
            $('.backdrop .gridlayout').css('height', previewHeight + 'px');
        }, 500);
    }

    function setIndicatorPosition() {
        var widthValue = parseFloat(jQuery('#dataWidth').val());
        var heightValue = parseFloat(jQuery('#dataHeight').val());
        
        jQuery('.imr_top').width(cropper.getCropBoxData().width);
        jQuery('.imr_top').css('margin-left', cropper.getCropBoxData().left + 'px');
        jQuery('#dimension_indicator').width(cropper.getCropBoxData().width);
        jQuery('.imr_top .cmvalue').text(widthValue + 'cm');


        jQuery('.imr_right').height(cropper.getCropBoxData().height);
        jQuery('.imr_right').css('margin-top', cropper.getCropBoxData().top + 'px');
        jQuery('#dimension_indicator_right').height(cropper.getCropBoxData().height);
        jQuery('.imr_right .cmvalue').text(heightValue + 'cm');
    }

    function addSampleToCart() {
        if (sampleProductId > 0) {
            ajaxCart.add(sampleProductId, '', true, null, 1, null);
            setTimeout(function () {

                if (jQuery('.popin-product .product-img').length > 0) {
                    jQuery('.popin-product .product-img').attr('src', "{$sample_image_url_direct|escape:'htmlall':'UTF-8'}");
                    jQuery('.popin-title').html('1 x <strong>{$sampleProductInfo->name['1']|escape:"htmlall":"UTF-8"}</strong>');
                    jQuery('.popin-reference').html('Référence : {$sampleProductInfo->reference|escape:"htmlall":"UTF-8"}');
                    var formattedSamplePrice = number_format(samplePrice, 2, ',', ' ');
                    jQuery('.popin-price').html(formattedSamplePrice + ' ' + currencySign)
                    //
                }
            }, 1000);
        }
    }
    //createGrid(100);
    function createGrid(size) {
        var ratioW = Math.floor($(window).width() / size),
                ratioH = Math.floor($(window).height() / size);

        var parent = $('<div />', {
            class: 'customgrid',
            width: ratioW * size,
            height: ratioH * size
        }).addClass('customgrid').appendTo('.gridlayout');

        for (var i = 0; i < ratioH; i++) {
            for (var p = 0; p < ratioW; p++) {
                $('<div />', {
                    width: size - 1,
                    height: size - 1
                }).appendTo(parent);
            }
        }
    }

    function number_format(number, decimals, decPoint, thousandsSep) {
        if(parseInt(number) == 0){
            return '0';
        }
        decimals = decimals || 0;
        number = parseFloat(number);

        if (!decPoint || !thousandsSep) {
            decPoint = '.';
            thousandsSep = ',';
        }

        var roundedNumber = Math.round(Math.abs(number) * ('1e' + decimals)) + '';
        var numbersString = decimals ? roundedNumber.slice(0, decimals * -1) : roundedNumber;
        var decimalsString = decimals ? roundedNumber.slice(decimals * -1) : '';
        var formattedNumber = "";

        while (numbersString.length > 3) {
            formattedNumber += thousandsSep + numbersString.slice(-3)
            numbersString = numbersString.slice(0, -3);
        }

        return (number < 0 ? '-' : '') + numbersString + formattedNumber + (decimalsString ? (decPoint + decimalsString) : '');
    }





    $("#button-scroll").click(function () {
        $('html, body').animate({
            scrollTop: $("#custom-product-detail").offset().top
        }, 2000);
    });

</script>