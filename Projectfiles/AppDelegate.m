/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "AppDelegate.h"

@implementation AppDelegate

-(void) initializationComplete
{
    [MGWU loadMGWU:@"rLaserman"];
	
    [MGWU preFacebook]; //Temporarily disables Facebook until you integrate it later
	
	[MGWU setReminderMessage:@"Come back and play Criss Cross!"];
	
	[MGWU setTapjoyAppId: @"11c2c6b4-aac4-45d9-9c2f-9adbca3b8e6a" andSecretKey:@"dKV7TO6G6K3YkuEj0ehk"];
    
    [MGWU useCrashlytics];
    
    [MGWU setAppiraterAppId:@"585867897" andAppName:@"Criss Cross"];
	
#ifdef KK_ARC_ENABLED
	CCLOG(@"ARC is enabled");
#else
	CCLOG(@"ARC is either not available or not enabled");
#endif
}

-(id) alternateRootViewController
{
	return nil;
}

-(id) alternateView
{
	return nil;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)tokenId
{
	[MGWU registerForPush:tokenId];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [MGWU gotPush:userInfo];
}


- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    [MGWU failedPush:error];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [MGWU handleURL:url];
}

@end
