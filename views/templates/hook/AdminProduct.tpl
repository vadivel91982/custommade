{*
* @version 1.0
* @author 202-ecommerce
* @copyright 2016-2017 202-ecommerce
* @license ?
*}
<div class="panel product-tab">
    <h4>{$name|escape:'html':'UTF-8'}</h4>
    <div class="separation"></div>
    <table>
        <tbody>
            <tr>
                <td valign="top"><label for="prod_customize" style="width:300px;">{l s='Do you want to customize this product :' mod='custommade'}</label></td>
                <td>
                    <p class="preference_description"><input type="radio" name="prod_customize" id="prod_customize" value="1" {if $getCustomize->prod_customize == 1}checked="checked"{/if}/>{l s='Yes' mod='custommade'}.<input type="radio" name="prod_customize" id="prod_customize" value="0" {if $getCustomize->prod_customize != 1}checked="checked"{/if}/>{l s='No' mod='custommade'}.</p>
                </td>
                <td>
                    <p class="preference_description"></p>
                </td>
            </tr>
            <tr>
                <td valign="top"><label for="Height" style="width:300px;">{l s='Max Height :' mod='custommade'}</label></td>
                <td>
                    <input type="text" name="Height" id="Height" value="{$getCustomize->cust_height|escape:'html':'UTF-8'}" >
                </td>
                <td>
                    <p class="preference_description">{l s=' Centimeter' mod='custommade'}</p>
                </td>
        <p class="preference_description"></p>
        </tr>
        <tr>
            <td valign="top"><label for="Width" style="width:300px;">{l s='Max Width :' mod='custommade'}</label></td>	
            <td>
                <input type="text" name="Width" id="Width" value="{$getCustomize->cust_width|escape:'html':'UTF-8'}" >
            </td>
            <td>
                <p class="preference_description">{l s=' Centimeter' mod='custommade'}</p>
            </td>
        <p class="preference_description"></p>
        </tr>
        <tr>
            <td valign="top"><label for="SquareMeter" style="width:300px;">{l s='Price Per Square Meter :' mod='custommade'}</label></td>
            <td>
                <input type="text" name="SquareMeter" id="SquareMeter" value="{$getCustomize->sq_meter_price|escape:'html':'UTF-8'}" >
            </td>
            <td>
                <p class="preference_description">{l s=' Per Square Meter' mod='custommade'}</p>
            </td>
        <p class="preference_description"></p>
        </tr>
        <tr>
            <td valign="top"><label for="Delivery" style="width:300px;">{l s='Delivery Days :' mod='custommade'}</label></td>
            <td>
                <input type="text" name="Delivery" id="Delivery" value="{$getCustomize->cust_delivery|escape:'html':'UTF-8'}" >
            </td>
            <td>
                <p class="preference_description">{l s=' Days' mod='custommade'}</p>
            </td>
        <p class="preference_description"></p>
        </tr>
        <tr>
            <td valign="top"><label for="grid_size" style="width:300px;">{l s='Grid Size :' mod='custommade'}</label></td>
            <td>
                <input type="text" name="grid_size" id="grid_size" value="{$getCustomize->grid_size|escape:'html':'UTF-8'}" >
            </td>
            <td>
                <p class="preference_description">{l s='px' mod='custommade'}</p>
            </td>
        <p class="preference_description"></p>
        </tr>
        <tr>
            <td valign="top"><label for="productlist_custom" style="width:300px;">{l s='Sample Product :' mod='custommade'}</label></td>
            <td>
                <select name="sample_product" id="sample_product">
                    <option value="0">{l s='Please Select' mod='custommade'}</option>
                    {foreach from=$productList item=pdt}
                        <option value="{$pdt['id_product']|escape:'htmlall':'UTF-8'}" {if $pdt['id_product'] == $getCustomize->sample_product}selected{/if}>{$pdt['name']|escape:'htmlall':'UTF-8'}</option>
                    {/foreach}
                </select>
            </td>
            <td>
                
            </td>
        <p class="preference_description"></p>
        </tr>
        </tbody>
    </table>
    <div class="panel-footer">
        <a href="index.php?controller=AdminProducts&amp;token={$token|escape:'html':'UTF-8'}" class="btn btn-default"><i class="process-icon-cancel"></i>{l s='Cancel' mod='custommade'}</a>
        <button type="submit" name="submitAddproduct" class="btn btn-default pull-right"><i class="process-icon-save"></i>{l s='Save' mod='custommade'}</button>
    </div>
</div>
