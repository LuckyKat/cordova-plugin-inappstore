cordova-plugin-inappstore
=========================

Plugin for displaying an embedded App Store within the wep app.

Prerequisites: A Cordova/PhoneGap 3.5+ project for iOS.

## Index

1. [Description](#description)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Example](#example)


##Description

The InApp Store plugin enables to instantiate a store right from your web app.

##Installation

To install this plugin, follow the [Command-line Interface Guide](http://cordova.apache.org/docs/en/edge/guide_cli_index.md.html#The%20Command-line%20Interface).

This plugin follows the Cordova 3.0 plugin spec, so it can be installed through the Cordova CLI in your existing Cordova project:
```bash
cordova plugin add https://github.com/Creative-Licence-Digital/cordova-plugin-inappstore.git
```

##Usage

Pass the app store id as parameter of the open method. The open method preloads the InAppStore view. The success callback will be called when preloaded. Call the show method after this.

```javascript
open: function (appStoreId, success, fail),
show: function ()
```

##Example

* params
 * appStoreId - the id of the app you want to target on the AppStore
 * success - success callback function
 * failure - error/fail callback function

```javascript
window.plugins.inappstore.open('123456789', function () {
    // success
    window.plugins.inappstore.show();
}, function () {
    // fail
    alert("Could not open App Store!");
});
```

