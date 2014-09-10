cordova-plugin-inappstore
=========================

Plugin for displaying an embedded App Store within the wep app.

Prerequisites: A Cordova/PhoneGap 3.0+ project for iOS or Android.

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
cordova plugin add git@github.com:Creative-Licence-Digital/cordova-plugin-inappstore.git
```

##Usage

Pass the app store id as parameter of the open method.

```javascript
open: function (appStoreId, success, fail)
```

##Example

