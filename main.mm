#import <Foundation/Foundation.h>
#import "CPDistributedMessagingCenter.h"

int main(int argc, char **argv, char **envp)
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	if (argc == 1)
	{
		printf("Usage: cmdapplauncher AppIdentifier\nExample: cmdapplauncher com.apple.mobilesafari\n");
			   
	}
	else if (argc > 1)
	{
		NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithUTF8String:argv[1]], @"appID", nil];
		[[CPDistributedMessagingCenter centerNamed:@"com.whomer.CmdAppLauncher"] sendMessageName:@"LaunchApp" userInfo:userInfo];
	}
	
	[pool drain];
	return 0;
}
