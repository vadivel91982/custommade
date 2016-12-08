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
                            <div class="form-horizontal">
                                <div class="form-group widthbox">
                                    <label for="width" class="control-label">Largeur (cm)</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">
                                            <i class="fa fa-arrows-h" aria-hidden="true"></i>
                                        </div>
                                        <input value="{$getPriceDetails->cust_width}" class="form-control" id="dimensions-width" type="number" placeholder="300 cm max">
                                    </div>
                                </div>
                                <div class="form-group heightbox">
                                    <label for="height" class="control-label">Hauteur (cm)</label>
                                    <div class="input-group">
                                        <div class="input-group-addon">
                                            <i class="fa fa-arrows-v" aria-hidden="true"></i>
                                        </div>
                                        <input value="{$getPriceDetails->cust_height}" class="form-control" id="dimensions-height" type="number"  placeholder="300 cm max">
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
                                    <button type="button" class="btn btn-default image-rotate-left">
                                        <i class="fa fa-undo" aria-hidden="true"></i> Rotation 90&deg;
                                    </button>
                                    <!-- <button type="button" class="btn btn-default image-rotate-right">
                                            Rotate right
                                    </button> -->
                                    <button type="button" class="btn btn-default flipbtns image-flip-horizontally">
                                        <i class="fa fa-arrows-h" aria-hidden="true"></i> Effet Mirror
                                    </button>
                                    <button type="button" class="btn btn-default flipbtns image-flip-vertically" style="display:none;">
                                        <i class="fa fa-arrows-h" aria-hidden="true"></i> Effet Mirror
                                    </button>
                                    <button type="button" class="btn btn-default image-grid"><i class="fa fa-align-justify" aria-hidden="true"></i>
                                        Montrer les l&eacute;s
                                    </button>
                                </div>
                                <div class="price-section">
                                    <p class="our_price_display "><b>PRIX:<b>
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
                                                <input type="submit" name="Submit" value="{l s='Ajouter au panier'}" class="exclusive" />
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
                                        <div id="cropper-tool-container">
                                            <img  src="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'large_default')}" id="base-image" class="cropper-hidden" />						
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
                                                        <div class="backdrop" style="height:76%;" >
                                                            <img class="preview" src="" style="left:0;top:0">
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


                                        <!--<script type="text/javascript">
                                            (function ($) {
                                                $(document).ready(function () {
                                                    var masonryGrid = $('.masonry-grid');
                                                    masonryGrid.masonry({
                                                        itemSelector: '.image',
                                                        columnWidth: '.image',
                                                        percentPosition: true
                                                    });

                                                    masonryGrid.imagesLoaded().progress(function () {
                                                        masonryGrid.masonry('layout');
                                                    });

                                                });
                                            })(jQuery);
                                        </script>-->

                                        <script>


                                            (function ($) {
                                                var flipValue = 0;
                                                var dynamicImage = '';
                                                var image = $('#base-image');
                                                //$('#collage-preview').fixedsticky();

                                                document.title = "Papier peint luxe, D&eacute;coration murale, Tapisserie design - Au fil des Couleurs";
                                                var getUrl = window.location;
                                                var baseUrl = getUrl.protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1] + "/";
                                                var jobId = $('#base-image').attr('src');
                                                var base_url = baseUrl;
                                                var activeAjaxRequests = 0;
                                                function makeTransformation(type, id, data) {
                                                    //alert(type);
                                                    //var url = "";
                                                    switch (type) {
                                                        case 'crop':
                                                            type = type;
                                                            //url = base_url + "transform/0/crop";
                                                            break;
                                                        case 'rotate':
                                                            type = type;
                                                            //url = base_url + "transform/0/rotate";
                                                            break;
                                                        case 'flip':
                                                            type = type;
                                                            //url = base_url + "transform/0/flip";
                                                            break;
                                                        case 'filter':
                                                            type = type;
                                                            //url = base_url + "transform/0/filter";
                                                            break;
                                                        default:
                                                            return false;
                                                    }

                                                    //url = url.replace('0', id);
                                                    var manipulationButtons = $('.transform-buttons button');

                                                    // Add the image data to the transformation data.
                                                    data = addImageData(data);
                                                    //datas = 'id=' + id + '&get_type=' + type + '&datas=' + data;
                                                    data.imageUrl = id;
                                                    data.type = type;

                                                    if (type == 'flip') {
                                                        data.mirror = flipValue;
                                                    }

                                                    var tempRotateVal = data.rotate;
                                                    if (tempRotateVal < 0) {

                                                        /*if(flipValue == 1){
                                                         var finalRotateValue = 360 + tempRotateVal;
                                                         }else{
                                                         var finalRotateValue = tempRotateVal * -1;
                                                         }*/
                                                        console.log(flipValue);
                                                        if (flipValue == 0) {
                                                            if (tempRotateVal == -90) {
                                                                finalRotateValue = 90;
                                                            }
                                                            if (tempRotateVal == -180) {
                                                                finalRotateValue = 180;
                                                            }
                                                            if (tempRotateVal == -270) {
                                                                finalRotateValue = 270;
                                                            }
                                                        } else {
                                                            if (tempRotateVal == -90) {
                                                                finalRotateValue = 270;
                                                            }
                                                            if (tempRotateVal == -180) {
                                                                finalRotateValue = 0;
                                                            }
                                                            if (tempRotateVal == -270) {
                                                                finalRotateValue = 90;
                                                            }
                                                        }

                                                        data.rotate = finalRotateValue;
                                                    } else {
                                                        //var correctRotateValue = data.rotate;
                                                    }

                                                    datas = data;
                                                    //console.log(datas);
                                                    //return true;
                                                    /*$.ajax({
                                                     url: baseDir,
                                                     method: 'POST',
                                                     data: datas,
                                                     beforeSend: function () {
                                                     manipulationButtons.each(function (key, button) {
                                                     $(button).addClass('disabled');
                                                     });
                                                     },
                                                     success: function (response) {
                                                     //alert(response);
                                                     $('.preview').attr('src', base_url);
                                                     },
                                                     complete: function () {
                                                     manipulationButtons.each(function (key, button) {
                                                     $(button).removeClass('disabled');
                                                     
                                                     });
                                                     }
                                                     });*/

                                                    dynamicImage = image.cropper("getCroppedCanvas").toDataURL('image/jpeg', 1);
                                                    $('.preview').attr('src', dynamicImage);
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



                                                var options = {
                                                    viewMode: 1, // Can use 'viewMode: 3' to remove the canvas borders but causes zoom issues on rotate.
                                                    aspectRatio: 1 / 1,
                                                    dragMode: 'move',
                                                    checkCrossOrigin: false,
                                                    zoomOnWheel: false,
                                                    zoomable: false,
                                                    movable: false,
                                                    cropBoxResizable: false,
                                                    minCropBoxHeight: 2000,
                                                    minContainerWidth: 710,
                                                    minContainerHeight: 500,
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

                                                    //flipValue = 0;
                                                    image.cropper('rotate', -90);
                                                    makeTransformation('rotate', jobId, image.cropper('getData'));

                                                    var tempCroperData = image.cropper('getData');
                                                    var tempRotateValue = tempCroperData.rotate * -1;
                                                    if (tempRotateValue == 90 || tempRotateValue == 270) {
                                                        jQuery('.flipbtns').hide();
                                                        jQuery('.image-flip-vertically').show();
                                                    } else {
                                                        jQuery('.flipbtns').hide();
                                                        jQuery('.image-flip-horizontally').show();
                                                    }
                                                    /**/

                                                    /**/
                                                });

                                                $(document).on('click', '.image-rotate-right', function (e) {
                                                    e.preventDefault();

                                                    if ($(this).hasClass('disabled')) {
                                                        return;
                                                    }

                                                    image.cropper('rotate', 90);
                                                    makeTransformation('rotate', jobId, image.cropper('getData'));
                                                });


                                                /*           prabakaran                  */


                                                $(document).on('click', '.image-flip-horizontally', function (e) {
                                                    e.preventDefault();

                                                    if ($(this).hasClass('disabled')) {
                                                        return;
                                                    }
                                                    if (flipValue == 0) {
                                                        flipValue = 1;
                                                    } else if (flipValue == 1) {
                                                        flipValue = 0;
                                                    }
                                                    console.log(flipValue);
                                                    var reversed = -1 * image.cropper('getData').scaleX;
                                                    image.cropper('scaleX', reversed);
                                                    makeTransformation('flip', jobId, image.cropper('getData'));
                                                });

                                                $(document).on('click', '.image-flip-vertically', function (e) {
                                                    e.preventDefault();

                                                    if ($(this).hasClass('disabled')) {
                                                        return;
                                                    }
                                                    if (flipValue == 0) {
                                                        flipValue = 1;
                                                    } else if (flipValue == 1) {
                                                        flipValue = 0;
                                                    }
                                                    var reversed = -1 * image.cropper('getData').scaleY;
                                                    image.cropper('scaleY', reversed);
                                                    makeTransformation('flip', jobId, image.cropper('getData'));
                                                });

                                                $(document).on('click', '.image-reset', function (e) {
                                                    e.preventDefault();

                                                    if ($(this).hasClass('disabled')) {
                                                        return;
                                                    }

                                                    image.cropper('reset');
                                                });

                                                $(document).on('click', '.colour-options img', function (e) {
                                                    e.preventDefault();
                                                    var button = $(this);

                                                    if ($(this).hasClass('disabled')) {
                                                        return;
                                                    }
                                                });


                                                $(document).on('click', '.image-grid', function (e) {
                                                    e.preventDefault();
                                                    //alert('testing');
                                                    var button = $(this);

                                                    $('.gridlayout').toggleClass('gridbg');

                                                    if ($(this).hasClass('disabled')) {
                                                        return;
                                                    }
                                                });
                                                 
                                                
                                                 

                                                /* prabakaran */

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
                                                    //$('.price').text((totalPrice * 1.2).toFixed(2));
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
                                                            /*case 'meters':
                                                             values.width = width;
                                                             values.height = height;
                                                             break;
                                                             case 'inch':
                                                             values.width = width / 39.370;
                                                             values.height = height / 39.370;
                                                             break;*/
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
                                                        alert('overlayUrl');
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
                                        </script>