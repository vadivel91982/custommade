{*
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
*}

<div class="panel">
    <h3><i class="icon-shopping-cart"></i> {l s='HD Image' mod='custommade'}</h3>
    <table class="table" id="orderProducts">
        <thead>
            <tr>
                <th>
                    <span class="title_box ">{l s='' mod='custommade'}</span>
                </th>
                <th>
                    <span class="title_box ">{l s='Product Name' mod='custommade'}</span>
                </th>
                <th>
                    <span class="title_box ">{l s='Options' mod='custommade'}</span>
                </th>
                <th><span class="title_box ">{l s='Print' mod='custommade'}</span></th>
            </tr>
        </thead>
        <tbody>
            {foreach $getHDDetails['product_name'] as $key => $hdorder}	
                <tr class="product-line-row">
                    <td>
                        <a href="{$getHDDetails['image_link'][$key]|escape:'htmlall':'UTF-8'}" target="_blank">
                            <img style="width:50px;height:50px;" src="{$getHDDetails['image_link'][$key]|escape:'htmlall':'UTF-8'}"/>
                        </a>
                    </td>
                    <td>{$getHDDetails['product_name'][$key]|escape:'htmlall':'UTF-8'|htmlspecialchars_decode:3}</td>
                    <td>
                        X: {$getHDDetails['crop_options'][$key]->x|escape:'htmlall':'UTF-8'}</br>
                        Y: {$getHDDetails['crop_options'][$key]->y|escape:'htmlall':'UTF-8'}</br>
                        Width: {$getHDDetails['crop_options'][$key]->userWidth|escape:'htmlall':'UTF-8'}</br>
                        Height: {$getHDDetails['crop_options'][$key]->userHeight|escape:'htmlall':'UTF-8'}</br>
                        Rotate: {$getHDDetails['crop_options'][$key]->rotate|escape:'htmlall':'UTF-8'}</br>
                    </td>                    
                    <td>
                        {* edit/delete controls *}
                        <div class="btn-group">
                            <button type="button" class="btn btn-default" onclick="javascript:window.print();">
                                {l s='Print' mod='custommade'}
                            </button>
                        </div>
                        {* Update controls *}
                    </td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="4" class="list-empty">
                        <div class="list-empty-msg">
                            <i class="icon-warning-sign list-empty-icon"></i>
                            {l s='There is no available document' mod='custommade'}
                        </div>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>	
</div>
