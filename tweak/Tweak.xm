#import <Foundation/Foundation.h>
#import "CPDistributedMessagingCenter.h"

%class SBApplicationController;
%class SBUIController;

@interface SBUIController : NSObject
+ (id)sharedInstance;
- (void)activateApplicationAnimated:(id)app;
@end

@interface SBApplicationController : NSObject
+ (id)sharedInstance;
- (id)applicationWithDisplayIdentifier:(NSString *)displayIdentifier;
@end

@interface CmdAppLauncherObserver : NSObject
{
	CPDistributedMessagingCenter *center;
}
@end

@implementation CmdAppLauncherObserver

- (id)init
{
	if ((self = [super init]))
	{
		center = [[CPDistributedMessagingCenter centerNamed:@"com.whomer.CmdAppLauncher"] retain];
		[center runServerOnCurrentThread];
		[center registerForMessageName:@"LaunchApp" target:self selector:@selector(launchApp:userInfo:)];
	}
	return self;
}

- (void)launchApp:(NSString *)name userInfo:(NSDictionary *)userInfo
{
	[[$SBUIController sharedInstance] activateApplicationAnimated:[[$SBApplicationController sharedInstance] applicationWithDisplayIdentifier:[userInfo objectForKey:@"appID"]]];
}

- (void)dealloc
{
	[center release];
	[super dealloc];
}

@end

__attribute__((constructor)) static void CmdAppLauncherTweak_Main()
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	if (![[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"])
		return;

	[[CmdAppLauncherObserver alloc] init];
	
	[pool drain];
}

