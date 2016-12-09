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
    var currencySign = '{$currencySign|html_entity_decode:2:"UTF-8"}';
    var currencyRate = '{$currencyRate|floatval}';
    var currencyFormat = '{$currencyFormat|intval}';
    var currencyBlank = '{$currencyBlank|intval}';
    var taxRate = {$tax_rate|floatval};
    var jqZoomEnabled = {if $jqZoomEnabled}true{else}false{/if};

//JS Hook
        var oosHookJsCodeFunctions = new Array();

// Parameters
        var id_product = '{$product->id|intval}';
        var productHasAttributes = {if isset($groups)}true{else}false{/if};
            var quantitiesDisplayAllowed = {if $display_qties == 1}true{else}false{/if};
                var quantityAvailable = {if $display_qties == 1 && $product->quantity}{$product->quantity}{else}0{/if};
                    var allowBuyWhenOutOfStock = {if $allow_oosp == 1}true{else}false{/if};
                        var availableNowValue = '{*{$product->available_now|escape:'quotes':'UTF-8'}*}';
                        var availableLaterValue = '{$product->available_later|escape:'quotes':'UTF-8'}';
                        var productPriceTaxExcluded = {$product->getPriceWithoutReduct(true)|default:'null'} - {$product->ecotax};
                        var reduction_percent = {if $product->specificPrice AND $product->specificPrice.reduction AND $product->specificPrice.reduction_type == 'percentage'}{$product->specificPrice.reduction*100}{else}0{/if};
                            var reduction_price = {if $product->specificPrice AND $product->specificPrice.reduction AND $product->specificPrice.reduction_type == 'amount'}{$product->specificPrice.reduction|floatval}{else}0{/if};
                                var specific_price = {if $product->specificPrice AND $product->specificPrice.price}{$product->specificPrice.price}{else}0{/if};
                                    var product_specific_price = new Array();
    {foreach from=$product->specificPrice key='key_specific_price' item='specific_price_value'}
                                    product_specific_price['{$key_specific_price}'] = '{$specific_price_value}';
    {/foreach}
                                    var specific_currency = {if $product->specificPrice AND $product->specificPrice.id_currency}true{else}false{/if};
                                        var group_reduction = '{$group_reduction}';
                                        var default_eco_tax = {$product->ecotax};
                                        var ecotaxTax_rate = {$ecotaxTax_rate};
                                        var currentDate = '{$smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}';
                                        var maxQuantityToAllowDisplayOfLastQuantityMessage = {$last_qties};
                                        var noTaxForThisProduct = {if $no_tax == 1}true{else}false{/if};
                                            var displayPrice = {$priceDisplay};
                                            var productReference = '{$product->reference|escape:'htmlall':'UTF-8'}';
                                            var productAvailableForOrder = {if (isset($restricted_country_mode) AND $restricted_country_mode) OR $PS_CATALOG_MODE}'0'{else}'{$product->available_for_order}'{/if};
                                                    var productShowPrice = '{if !$PS_CATALOG_MODE}{$product->show_price}{else}0{/if}';
                                                        var productUnitPriceRatio = '{$product->unit_price_ratio}';
                                                        var idDefaultImage = {if isset($cover.id_image_only)}{$cover.id_image_only}{else}0{/if};
                                                            var stock_management = {$stock_management|intval};
                                                            //var baseDir = '{$customBaseurl}';
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

                                                            var productPriceWithoutReduction = '{$productPriceWithoutReduction}';
                                                            var productPrice = '{$productPrice}';

// Customizable field
                                                            var img_ps_dir = '{$img_ps_dir}';
                                                            var customizationFields = new Array();
    {assign var='imgIndex' value=0}
    {assign var='textFieldIndex' value=0}
    {foreach from=$customizationFields item='field' name='customizationFields'}
        {assign var="key" value="pictures_`$product->id`_`$field.id_customization_field`"}
                                                            customizationFields[{$smarty.foreach.customizationFields.index|intval}] = new Array();
                                                            customizationFields[{$smarty.foreach.customizationFields.index|intval}][0] = '{if $field.type|intval == 0}img{$imgIndex++}{else}textField{$textFieldIndex++}{/if}';
                                                                customizationFields[{$smarty.foreach.customizationFields.index|intval}][1] = {if $field.type|intval == 0 && isset($pictures.$key) && $pictures.$key}2{else}{$field.required|intval}{/if};
    {/foreach}

// Images
                                                                    var img_prod_dir = '{$img_prod_dir}';
                                                                    var combinationImages = new Array();

    {if isset($combinationImages)}
        {foreach from=$combinationImages item='combination' key='combinationId' name='f_combinationImages'}
                                                                    combinationImages[{$combinationId}] = new Array();
            {foreach from=$combination item='image' name='f_combinationImage'}
                                                                    combinationImages[{$combinationId}][{$smarty.foreach.f_combinationImage.index}] = {$image.id_image|intval};
            {/foreach}
        {/foreach}
    {/if}

                                                                    combinationImages[0] = new Array();
    {if isset($images)}
        {foreach from=$images item='image' name='f_defaultImages'}
                                                                    combinationImages[0][{$smarty.foreach.f_defaultImages.index}] = {$image.id_image};
        {/foreach}
    {/if}

// Translations
                                                                    var doesntExist = '{l s='This combination does not exist for this product. Please choose another.' js=1}';
                                                                    var doesntExistNoMore = '{l s='This product is no longer in stock' js=1}';
                                                                    var doesntExistNoMoreBut = '{l s='with those attributes but is available with others' js=1}';
                                                                    var uploading_in_progress = '{l s='Uploading in progress, please wait...' js=1}';
                                                                    var fieldRequired = '{l s='Please fill in all required fields, then save the customization.' js=1}';

    {if isset($groups)}
                                                                    // Combinations
        {foreach from=$combinations key=idCombination item=combination}
                                                                    var specific_price_combination = new Array();
                                                                    specific_price_combination['reduction_percent'] = {if $combination.specific_price AND $combination.specific_price.reduction AND $combination.specific_price.reduction_type == 'percentage'}{$combination.specific_price.reduction*100}{else}0{/if};
                                                                        specific_price_combination['reduction_price'] = {if $combination.specific_price AND $combination.specific_price.reduction AND $combination.specific_price.reduction_type == 'amount'}{$combination.specific_price.reduction}{else}0{/if};
                                                                            specific_price_combination['price'] = {if $combination.specific_price AND $combination.specific_price.price}{$combination.specific_price.price}{else}0{/if};
                                                                                specific_price_combination['reduction_type'] = '{if $combination.specific_price}{$combination.specific_price.reduction_type}{/if}';
                                                                                //addCombination({$idCombination|intval}, new Array({$combination.list}), {$combination.quantity}, {$combination.price}, {$combination.ecotax}, {$combination.id_image}, '{$combination.reference|addslashes}', {$combination.unit_impact|floatval}, {$combination.minimal_quantity|floatval}, '{$combination.available_date}', specific_price_combination);
        {/foreach}
    {/if}

    {if isset($attributesCombinations)}
                                                                                // Combinations attributes informations
                                                                                var attributesCombinations = new Array();
        {foreach from=$attributesCombinations key=id item=aC}
                                                                                tabInfos = new Array();
                                                                                tabInfos['id_attribute'] = '{$aC.id_attribute|intval}';
                                                                                tabInfos['attribute'] = '{$aC.attribute}';
                                                                                tabInfos['group'] = '{$aC.group}';
                                                                                tabInfos['id_attribute_group'] = '{$aC.id_attribute_group|intval}';
                                                                                attributesCombinations.push(tabInfos);
        {/foreach}
    {/if}
//]]>
</script>
{if isset($adminActionDisplay) && $adminActionDisplay}
    <div id="admin-action">
        <p>{l s='This product is not visible to your customers.'}
            <input type="hidden" id="admin-action-product-id" value="{$product->id}" />
            <input type="submit" value="{l s='Publish'}" class="exclusive" onclick="submitPublishProduct('{$base_dir}{$smarty.get.ad|escape:'htmlall':'UTF-8'}', 0, '{$smarty.get.adtoken|escape:'htmlall':'UTF-8'}')"/>
            <input type="submit" value="{l s='Back'}" class="exclusive" onclick="submitPublishProduct('{$base_dir}{$smarty.get.ad|escape:'htmlall':'UTF-8'}', 1, '{$smarty.get.adtoken|escape:'htmlall':'UTF-8'}')"/>
        </p>
        <p id="admin-action-result"></p>
    </p>
</div>
{/if}

{if isset($confirmation) && $confirmation}
    <p class="confirmation">
        {$confirmation}
    </p>
{/if}
{if ($product->show_price AND !isset($restricted_country_mode)) OR isset($groups) OR $product->reference OR (isset($HOOK_PRODUCT_ACTIONS) && $HOOK_PRODUCT_ACTIONS)}
    <!-- add to cart form-->
    <form id="buy_block" class="span4" {if $PS_CATALOG_MODE AND !isset($groups) AND $product->quantity > 0}class="hidden"{/if} action="{$link->getPageLink('cart')}" method="post">

        <!-- hidden datas -->
        <p class="hidden">
            <input type="hidden" name="token" value="{$static_token}" />
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
                                {$product->description_short}
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section-content-start" >
                <div class="row">
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
                                        <input value="{$getPriceDetails->cust_width}" class="form-control" id="dataWidth" type="number" placeholder="300 cm max">										
                                    </div>
                                </div>
                                <div class="form-group heightbox">
                                    <label for="height" class="control-label">Hauteur (cm)</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">
                                            <i class="fa fa-arrows-v" aria-hidden="true"></i>
                                        </div>
                                        <input value="{$getPriceDetails->cust_height}" class="form-control" id="dataHeight" type="number"  placeholder="300 cm max">
                                    </div>
                                </div>
                                <div><a href="#" title="Autres dimensions?">Autres dimensions?</a></div>
                            </div>
                            <div class="customise-section">
                                <h3>2. Choisissez un effet</h3>
                                <div class="btn-group transform-buttons" role="group" aria-label="...">
                                    <!-- <button type="button" class="btn btn-default transform-info">
                                            Image manipulation tools:
                                    </button> -->


                                    <div id="actions">
                                        <div class="docs-buttons">			


                                            <button type="button" data-method="rotate" data-option="90" class="btn btn-default image-rotate-left">
                                                <i class="fa fa-undo" aria-hidden="true"></i> Rotation 90&deg;
                                            </button>

                                            <button type="button" class="btn btn-default flipbtns image-flip-horizontally" data-method="scaleX" data-option="-1">
                                                <i class="fa fa-arrows-h" aria-hidden="true"></i> Effet Mirror
                                            </button>
                                            <button type="button" class="btn btn-default flipbtns image-flip-vertically" data-method="scaleY" data-option="-1" style="display:none;">
                                                <i class="fa fa-arrows-h" aria-hidden="true"></i> Effet Mirror
                                            </button>
                                            <button type="button" class="btn btn-default image-grid"><i class="fa fa-align-justify" aria-hidden="true"></i>
                                                Montrer les l&eacute;s
                                            </button>

                                            <!--	<button type="button" class="btn btn-primary" data-method="getCroppedCanvas">
                                                            Get Cropped Canvas
                                                    </button> -->

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



                                    <!-- <button type="button" class="btn btn-default image-rotate-right">
                                            Rotate right
                                    </button> -->

                                </div>


                                <div class="price-section">
                                    <p class="our_price_display "><b>PRIX:</b>
                                        <span class="price our_price_display"> 
                                            <meta itemprop="currency" content="EUR" />
                                            {if $priceDisplay >= 0 && $priceDisplay <= 2}
                                                <span itemprop="price" style="display: none;">{sprintf("%.02f", $productPrice)}</span>
                                            {/if}
                                            <span itemprop="condition" style="display: none;" content="new"></span>
                                            {if (!$allow_oosp && $product->quantity <= 0) OR !$product->available_for_order OR (isset($restricted_country_mode) AND $restricted_country_mode) OR $PS_CATALOG_MODE}
                                                <span itemprop="availability" style="display: none;" content="out_of_stock"></span>
                                            {else}
                                                <span itemprop="availability" style="display: none;" content="in_stock"></span>
                                            {/if}
                                            {if $priceDisplay >= 0 && $priceDisplay <= 2}
                                                <span id="our_price_display">{convertPrice price=$productPrice}</span>
                                                <!--{if $tax_enabled  && ((isset($display_tax_label) && $display_tax_label == 1) OR !isset($display_tax_label))}
                                        {if $priceDisplay == 1}{l s='tax excl.'}{else}{l s='tax incl.'}{/if}
                                    {/if}-->
                                {/if}
                            </span>
                        </p>
                        <span class="sq-price">{$getPriceDetails->sq_meter_price} £/m2</span>
                    </div>
                    <div class="button-sec">
                        {if (!$allow_oosp && $product->quantity <= 0) OR !$product->available_for_order OR (isset($restricted_country_mode) AND $restricted_country_mode) OR $PS_CATALOG_MODE}
                            <p id="add_to_cart" class="buttons_bottom_block">
                                <span class="exclusive">
                                    {l s='Ajouter au panier'}
                                </span>
                            </p>
                        {else}
                            <p id="add_to_cart" class="buttons_bottom_block">
                                <input type="button" id="addcartbtn" name="Submit" value="{l s='Ajouter au panier'}" class="exclusive" />
                            </p>
                        {/if}
                        <p>Livraison sous {$getPriceDetails->cust_delivery} jours</p>
                        <a href="javascript:void(0)" id="sampleButton" onclick="addSampleToCart(this);
                                return false;">Commander un échantillon</a>
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

            <div class="img-container">
                <img src="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'large_default')}" alt="Picture">
            </div>


        </div>
        {if isset($accessories) && $accessories}
            <div class="accessories">
                <p>
                    <span style="padding-right:10px">{l s='Coloris'}</span> <select style="width:250px" onchange="javascript:document.location.href = this.value">
                        <option value="">{$color_feature|escape:'UTF-8':'htmlall'} - {l s='Ref.'} {$product->reference|escape:'UTF-8':'htmlall'}</option>
                        {foreach from=$accessories item=accessoire}
                            <option value="{$tempModuleUrl}?id_product={$accessoire['id_product']|intval}">{foreach from=$accessoire.features item=feature}{if $feature.id_feature==1}{$feature.value}{/if}{/foreach} - {l s='Ref.'} {$accessoire.reference}</option>
                        {/foreach}
                    </select>
                </p>
                <div class="clear"></div>
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
                        <img src="{$link->getImageLink($product->link_rewrite, $product->id|cat:'-'|cat:$cover, 'home_default')}" alt="" height="46" width="46" />
                    </li>



                    {foreach from=$accessories item=accessoire}
                        <li><a href="{$tempModuleUrl}?id_product={$accessoire['id_product']|intval}"><img src="{$link->getImageLink($accessoire.link_rewrite, $accessoire.id_image, 'large_default')}" class="img-responsive" width="46" height="46" /></a></li>
                            {/foreach}
                </ul>
                {if $accessories|@count > 5}
                    <span class="attributes_more">{l s='Voir plus'}</span>
                {/if}
                <div class="clear"></div>
            </div>
        {/if}
    </div>

    <div class="previews customise-section" id="previews-container">
        <div class="col-xs-12 col-sm-2 no-gutter" style="padding-right:0;padding-left:0;">
            <!-- required for floating -->
            <!-- Nav tabs -->
            <ul class="nav nav-tabs tabs-left">
                <!-- 'tabs-right' for right tabs -->
                {foreach from=$getUnivers1 key=k item=universeImage}
                    <li {if (1 == $k+1)}class="active"{/if}>
                       <!-- <a href="#scene{$k+1}" data-toggle="tab">{$universeImage['universe_name']|escape:'html':'UTF-8'}</a>-->
                        <a href="#scene{$k+1}" data-toggle="tab"><img src="{$img_dir|escape:'html':'UTF-8'}{$universeImage['image']|escape:'html':'UTF-8'}" width="90px"></a>
                    </li>
                {/foreach}
            </ul>
        </div>
        <div class="col-xs-12 col-sm-10 no-gutter" >
            <!-- Tab panes -->
            <div class="tab-content">
                {foreach from=$getUnivers1 key=k item=universeImage}
                    <div class="tab-pane {if (1 == $k+1)}active{/if}" id="scene{$k+1}">
                        <div class="backdrop" style="height:100%;max-height:100%;" >
                            <img class="preview" src="" style="left:0;top:0;">
                        </div>
                        <div class="overlay">
                            <img src="{$img_dir|escape:'html':'UTF-8'}{$universeImage['image']|escape:'html':'UTF-8'}">
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>


</div>
</div>
</form>
{/if}
    <img 
</div>



<script>


    //window.onload = function () {

    //'use strict';
    var rootUrl = '{$rootUrl}';
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
        viewMode: 1,
        aspectRatio: 1 / 1,

        dragMode: 'move',
        checkCrossOrigin: false,
        zoomOnWheel: false,
        zoomable: false,
        minContainerHeight: 500,
        guides: false,

        ready: function (e) {
            if (jQuery.trim(sessionStorage.cropData) != '') {
                var prevCropDataOrg = JSON.parse(sessionStorage.cropData);
                cropper.setData(prevCropDataOrg);
                //console.log(cropper.getData());
                if (jQuery.trim(sessionStorage.hasGrid) == '1') {
                    jQuery('.gridlayout').addClass('gridbg');
                }
            }
            dynamicImage = image.cropper.getCroppedCanvas().toDataURL('image/jpeg', 1);
            $('.preview').attr('src', dynamicImage);
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
            dataHeight.value = Math.round(data.height);
            dataWidth.value = Math.round(data.width);
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
        var button = $(this);

        $('.gridlayout').toggleClass('gridbg');

        if ($('.gridlayout').hasClass('gridbg')) {
            sessionStorage.hasGrid = '1';
        } else {
            sessionStorage.hasGrid = '0';
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
        var currentCropData = cropper.getData();
        if(currentCropData.rotate == 90 || currentCropData.rotate == 270){
            jQuery('.image-flip-horizontally').hide();
            jQuery('.image-flip-vertically').show();
        }else{
            jQuery('.image-flip-horizontally').show();
            jQuery('.image-flip-vertically').hide();
        }
        
        setCropToSession();
        dynamicImage = image.cropper.getCroppedCanvas().toDataURL('image/jpeg', 1);
        $('.preview').attr('src', dynamicImage);
    });

    jQuery(document).on('click', '.flipbtns', function () {
        setCropToSession();
        dynamicImage = image.cropper.getCroppedCanvas().toDataURL('image/jpeg', 1);
        $('.preview').attr('src', dynamicImage);
    });
    
    jQuery(document).on('keyup','#dataWidth',function(){
        var curVal = jQuery.trim(jQuery(this).val());
        curVal = curVal * 1;
        var newOpt = {
            width:curVal
        };
        cropper.setData(newOpt);
        dynamicImage = image.cropper.getCroppedCanvas().toDataURL('image/jpeg', 1);
        $('.preview').attr('src', dynamicImage);
    });
    
    jQuery(document).on('keyup','#dataHeight',function(){
        var curVal = jQuery.trim(jQuery(this).val());
        curVal = curVal * 1;
        var newOpt = {
            width:curVal
        };
        cropper.setData(newOpt);
        dynamicImage = image.cropper.getCroppedCanvas().toDataURL('image/jpeg', 1);
        $('.preview').attr('src', dynamicImage);
    });

    jQuery(document).on('click', '#addcartbtn', function () {
        var finalData = cropper.getData();
        finalData.stripe = sessionStorage.hasGrid;
        var finalDataString = JSON.stringify(finalData);
        jQuery.post(rootUrl + 'module/custommade/cropper?action=setdata&pid=' + id_product, {
            data: finalDataString
        }, function () {
            jQuery('#buy_block').submit();
        });

    });

    function setCropToSession() {
        var currentCropData = cropper.getData();
        sessionStorage.cropData = JSON.stringify(currentCropData);
    }




    /*setInterval(function () {
     var currentCropData = cropper.getData();
     sessionStorage.cropData = JSON.stringify(currentCropData);
     //console.log(currentCropData);
     }, 1000);*/

    //};



</script>