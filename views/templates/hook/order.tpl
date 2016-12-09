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
					<span class="title_box ">{l s=''}</span>
				</th>
				<th>
					<span class="title_box ">{l s='Product Name'}</span>
				</th>
				<th>
					<span class="title_box ">{l s='Options'}</span>
				</th>
				<th>
					<span class="title_box ">{l s='View'}</span>
				</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			{foreach $getHDDetails['product_name'] as $key => $hdorder}	
				<tr class="product-line-row">
					<td>{$getHDDetails['hd_image_url'][$key]}</td>
					<td>{$getHDDetails['product_name'][$key]}</td>
					<td>
						X: {$getHDDetails['crop_options'][$key]->x}</br>
						Y: {$getHDDetails['crop_options'][$key]->y}</br>
						Width: {$getHDDetails['crop_options'][$key]->width}</br>
						Height: {$getHDDetails['crop_options'][$key]->height}</br>
						Rotate: {$getHDDetails['crop_options'][$key]->rotate}</br>
					</td>
					<td>
						{* edit/delete controls *}
						<div class="btn-group">
							<button type="button" class="btn btn-default edit_product_change_link">
								<i class="icon-search-plus"></i>
								{l s='View'}
							</button>
						</div>
						{* Update controls *}
					</td>
				</tr>
			{/foreach}
		</tbody>
	</table>	
</div>
