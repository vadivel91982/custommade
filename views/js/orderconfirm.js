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