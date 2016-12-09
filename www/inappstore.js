var exec = require('cordova/exec');

module.exports  = {

    open: function(appStoreId, success, fail) {
        return cordova.exec(success, fail, "CDVInAppStore", "open", [appStoreId]);
    },
    openWithTokens: function(appStoreId, campaignToken, providerToken, success, fail) {
        return cordova.exec(success, fail, "CDVInAppStore", "openWithTokens", [appStoreId, campaignToken || '', providerToken || '']);
    },
    show: function(success, fail) {
        return cordova.exec(success, fail, "CDVInAppStore", "show", []);
    }

};