var exec = require('cordova/exec');

module.exports  = {

    open: function(appStoreId, success, fail) {
        return cordova.exec(success, fail, "CDVInAppBrowser", "open", [appStoreId]);
    }

};