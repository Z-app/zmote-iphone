//
//  VRemoteControlImpl.m
//  BCTabBarController
//
//  Created by Viktor Dahl on 2012-11-28.
//
//

#import "VRemoteControlImpl.h"
#import "RCCommand-zenterio.h"
#import "VChannel.h"

@implementation VRemoteControlImpl {

}

/* Constructor */
- (VRemoteControlImpl*) init {
    zenterio = [[RCCommand_zenterio alloc] init];
    if (self) {
        return self;
    } else {
        return nil;
    }
}

/* Function that checks which button is being pressed and acts accordingly */
- (void) executeCommand: (id)sender {
    UIButton* button = sender;
    NSString* command;
    BOOL doRequest = true;
    
    switch (button.tag) {
        case 100:
            NSLog(@"UP");
            command = @"pup";
            break;
        case 101:
            NSLog(@"DOWN");
            command = @"pdown";
            break;
        case 102:
            NSLog(@"LEFT");
            command = @"pleft";
            break;
        case 103:
            NSLog(@"RIGHT");
            command = @"pright";
            break;
        case 104:
            NSLog(@"MID");
            command = @"pmenu";
            break;
        case 105:
            NSLog(@"back");
            command = @"pback";
            break;
        case 106:
            NSLog(@"settings");
            break;
        case 107:
            NSLog(@"info");
            break;
        case 108:
            NSLog(@"cancel");
            break;
        case 109:
            NSLog(@"mute");
            command = @"pmute";
            break;
        default:
            if (button.tag >= 200 && button.tag <= 299) { /* If it's a channel */
                for (VChannel* channel in channelList) {
                    if ([channel getTag] == button.tag) {
                        NSLog(@"%@, id = %d", [channel getName], button.tag);
                        [self changeChannel:channel];
                        doRequest = false;
                    }
                }
                break;
            }
            NSLog(@"Unknown id=%d", button.tag);
            break;
    }
    if (doRequest) {
        [zenterio sendRequest:command];
    }
}

/* Calls the zenterio.getChannelIcon */
- (UIImage*) getChannelIcon: (NSString*) iconURL {
    return [zenterio getChannelIcon: iconURL];
}

/* Gets and creates channels from STB */
- (NSMutableArray*) createChannels {
    channelList = [[NSMutableArray alloc] init];
    
    NSDictionary* dict = [zenterio getEPG]; /* Gets epg JSON object */
    for(NSDictionary* channelD in dict) {
        NSString *name = [channelD objectForKey:@"name"];
        NSInteger nr = [[channelD objectForKey:@"nr"] intValue];
        NSInteger onid = [[channelD objectForKey:@"onid"] intValue];
        NSInteger tsid = [[channelD objectForKey:@"tsid"] intValue];
        NSInteger sid = [[channelD objectForKey:@"sid"] intValue];
        VChannel* channel = [[VChannel alloc] name:name nr:nr onid:onid tsid:tsid sid:sid];
        [channel setURL:[channelD objectForKey:@"url"]];
        [channelList addObject:channel];
    }
    return channelList;
}

/* A task. */
-(void) aTask {
//    [zenterio URLRequest];
}

/* Returns current channel */
- (void) getCurrentChannel {
    NSString* label = [zenterio getCurrentChannel];
    for (VChannel* channel in channelList) {
        if ([[channel getName] isEqualToString:label]) {
            NSLog(@"Current channel=%@", [channel getName]);
            if ([[currentChannel getName] isEqualToString:label]) {
            } else {
                [[channel getIcon] setBackgroundColor:[UIColor whiteColor]];
                [[currentChannel getIcon] setBackgroundColor: [UIColor clearColor]];
                currentChannel = channel;
            }
            return;
        }
    }
    NSLog(@"No current channel found");
}

/* Changes the currentChannel in the app as well as changing background color of the channels affected */
-(void) changeChannel: (VChannel*) channel {
    [[currentChannel getIcon] setBackgroundColor:[UIColor clearColor]];
    NSLog(@"Current channel: %@", [currentChannel getName]);
    [[channel getIcon] setBackgroundColor:[UIColor whiteColor]];
    currentChannel = channel;
    [zenterio changeChannel:[channel getURL]]; // This function doesn't work.
}

-(NSString*) getIPAddress {
    return [zenterio getIPAddress];
}

-(void) setIPAddress: (NSString*) IPAddress{
    [zenterio setIPAddress:IPAddress];
}
-(float) getVolume {
    return [zenterio getVolume];
}
-(void) setValue: (float) val {
//    [zenterio setVolume];
}

@end