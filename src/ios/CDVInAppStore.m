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

- (void)open:(CDVInvokedUrlCommand *)command
{
    __block CDVPluginResult *pluginResult = nil;
    NSString *appStoreId = [command.arguments objectAtIndex:0];
    
    [self.commandDelegate runInBackground:^{
        SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
        storeViewController.delegate = self;
        NSDictionary *params = [NSDictionary dictionaryWithObject:appStoreId forKey:SKStoreProductParameterITunesItemIdentifier];
        
        UIInAppStoreNavigationController* navigationController = [[UIInAppStoreNavigationController alloc] initWithRootViewController:storeViewController];
        navigationController.navigationBarHidden = YES;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            storeViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        }
        
        [storeViewController loadProductWithParameters:params completionBlock:^(BOOL result, NSError *error) {
            if (error) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid app store id"];
            } else {
                [self.viewController presentViewController:navigationController animated:YES completion:nil];
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    }];    
}


# pragma mark - SKStoreProductViewController delegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [self.viewController dismissViewControllerAnimated:YES completion:NULL];
}

@end


@implementation UIInAppStoreNavigationController

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
