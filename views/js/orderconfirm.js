/**
* NOTICE OF LICENSE
*
* This source file is subject to a commercial license from 202 ecommerce
* Use, copy, modification or distribution of this source file without written
* license agreement from 202 ecommerce is strictly forbidden.
*
* @author    202 ecommerce <contact@202-ecommerce.com>
* @copyright Copyright (c) 202 ecommerce 2017
* @license   Commercial license
*
* Support <support@202-ecommerce.com>
*/

if (window.location.hostname == '192.168.3.127' || window.location.hostname == 'localhost' || window.location.hostname == 'localprojects.com') {
    var getUrl = window.location;
    var baseUrl = getUrl .protocol + "//" + getUrl.host + "/" + getUrl.pathname.split('/')[1]+"/";
    var rootUrl = baseUrl;
} else {
    var rootUrl = '/';
}
sessionStorage.hasGrid = '';
sessionStorage.cropData = '';
//alert(rootUrl);
jQuery.post(rootUrl + 'module/custommade/cropper?action=savecropdata', function () {
    //todo
});