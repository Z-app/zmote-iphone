//
//  VRemoteControlImpl.h
//  BCTabBarController
//
//  Created by Viktor Dahl on 2012-11-28.
//
//

#import <Foundation/Foundation.h>
#import "RCCommand-zenterio.h"
#import "VChannel.h"

@interface VRemoteControlImpl : NSObject {
    RCCommand_zenterio* zenterio;
    NSMutableArray* channelList;
    VChannel* currentChannel;
}

- (VRemoteControlImpl*) init;
- (void) executeCommand: (id)sender;
- (UIImage*) getChannelIcon: (NSString*) iconURL;
- (NSMutableArray*) createChannels;
-(void) aTask;
- (void) getCurrentChannel;
-(void) changeChannel: (VChannel*) channel;
-(NSString*) getIPAddress;
-(void) setIPAddress:(NSString*) IPAddress;
-(float) getVolume;
-(void) setVolume: (float) val;

@end
