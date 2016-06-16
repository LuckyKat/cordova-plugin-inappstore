var exec = require('cordova/exec');

module.exports  = {

    open: function(appStoreId, success, fail) {
        return cordova.exec(success, fail, "CDVInAppStore", "open", [appStoreId]);
    },
    show: function(success, fail) {
        return cordova.exec(success, fail, "CDVInAppStore", "show", []);
    }

};