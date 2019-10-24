/*
 The MIT License (MIT)
http://www.opensource.org/licenses/mit-license.html

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 */

#import "CDVInAppStore.h"


@implementation CDVInAppStore

@synthesize storeViewController;

- (void)open:(CDVInvokedUrlCommand *)command
{
    __block CDVPluginResult *pluginResult = nil;
    NSString *appStoreId = [command.arguments objectAtIndex:0];
    
    self.storeViewController = [[UIInAppStoreNavigationController alloc] init];
    self.storeViewController.delegate = self;
    NSDictionary *params = [NSDictionary dictionaryWithObject:appStoreId forKey:SKStoreProductParameterITunesItemIdentifier];
    [self.storeViewController loadProductWithParameters:params completionBlock:^(BOOL result, NSError *error) {
        if (error) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid app store id"];
        } else {
            // [self.viewController presentViewController:self.storeViewController animated:YES completion:nil];
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)openWithTokens:(CDVInvokedUrlCommand *)command
{
    __block CDVPluginResult *pluginResult = nil;
    NSString *appStoreId = [command.arguments objectAtIndex:0];
    NSString *campaignToken = [command.arguments objectAtIndex:1];
    NSString *providerToken = [command.arguments objectAtIndex:2];
    
    @try {
        // experienced multiple crashes here: wrapping it in a try catch block
        self.storeViewController = [[UIInAppStoreNavigationController alloc] init];
        self.storeViewController.delegate = self;
        NSDictionary *params = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:appStoreId,campaignToken,providerToken,nil]
                                                  forKeys:[NSArray arrayWithObjects:SKStoreProductParameterITunesItemIdentifier,SKStoreProductParameterCampaignToken,SKStoreProductParameterProviderToken,nil]];
        
        [self.storeViewController loadProductWithParameters:params completionBlock:^(BOOL result, NSError *error) {
            if (error) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid app store id"];
            } else {
                // [self.viewController presentViewController:self.storeViewController animated:YES completion:nil];
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    }
    @catch ( NSException *e ) {
        NSLog(@"Exception: %@", e);
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Failure"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    @finally {
    }
}


- (void)show:(CDVInvokedUrlCommand *)command
{
    @try {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        [self.viewController presentViewController:self.storeViewController animated:NO completion:nil];
    }
    @catch ( NSException *e ) {
        NSLog(@"Exception: %@", e);
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Failure"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    @finally {
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

# pragma mark - UIInAppStoreNavigationController delegate

- (void)productViewControllerDidFinish:(UIInAppStoreNavigationController *)viewController {
    [self.viewController dismissViewControllerAnimated:YES completion:NULL];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

@end


@implementation UIInAppStoreNavigationController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
