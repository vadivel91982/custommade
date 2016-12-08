if (window.location.hostname == '192.168.3.127') {
    var rootUrl = 'http://192.168.3.127/prestashop/';
} else {
    var rootUrl = '/';
}

jQuery.post(rootUrl + 'module/custommade/cropper?action=savecartid', function () {
    //todo
});