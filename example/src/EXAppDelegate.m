#import "EXAppDelegate.h"
#import "BCTabBarController.h"
#import "ZFileHandlerViewController.h"
#import "ZMainViewController.h"
#import "ZRemoteControlViewController.h"
#import "ZEPGViewController.h"
#import "ZWebTVViewController.h"

@implementation EXAppDelegate
@synthesize tabBarController, window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    /* Initiate the tab bar */
	self.tabBarController = [[BCTabBarController alloc] init];
	self.tabBarController.viewControllers = [NSArray arrayWithObjects:
											 [[ZMainViewController alloc] init],
											 [[ZRemoteControlViewController alloc] init],
											 [[ZEPGViewController alloc] init],
											 [[ZWebTVViewController alloc] init],
											 [[ZFileHandlerViewController alloc] init],
											 nil];
	[self.window addSubview:self.tabBarController.view];
	[self.window makeKeyAndVisible];
    
    /* Chooses the remote control view at startup */
    tabBarController.selectedIndex = 1;
	return YES;
}

@end
