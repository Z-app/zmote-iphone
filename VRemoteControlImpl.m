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
            command = @"pinfo";
            break;
        case 108:
            NSLog(@"cancel");
            command = @"pexit";
            break;
        case 109:
            NSLog(@"mute");
            command = @"pmute";
            break;
        case 110:
            if (lastSliderValue < currentSliderValue) {
                command = @"pvolplus";
            } else if (lastSliderValue > currentSliderValue) {
                command = @"pvolminus";
            } else {
                doRequest = false;
            }
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
            NSLog(@"Unknown id %d", button.tag);
            break;
    }
    if (doRequest) { // If it's not a channel
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

/* A task. Does nothing. */
-(void) aTask {
}

/* Changes the current channel */
- (void) getCurrentChannel {
    dispatch_queue_t queue = dispatch_queue_create("com.yourdomain.yourappname", NULL);
    dispatch_async(queue, ^{
        NSString* label = [zenterio getCurrentChannel];
        dispatch_async(dispatch_get_main_queue(), ^{
            for (VChannel* channel in channelList) {
                if ([[channel getName] isEqualToString:label]) {
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
        });
    });
    
}

/* Changes the currentChannel in the app as well as changing the background color of the channels affected */
-(void) changeChannel: (VChannel*) channel {
    [[currentChannel getIcon] setBackgroundColor:[UIColor clearColor]];
    [[channel getIcon] setBackgroundColor:[UIColor whiteColor]];
    currentChannel = channel;
    dispatch_queue_t queue = dispatch_queue_create("com.yourdomain.yourappname", NULL);
    dispatch_async(queue, ^{
        [zenterio changeChannel:[channel getURL]];
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    });
}


-(NSString*) getIPAddress {
    return [zenterio getIPAddress];
}

-(void) setIPAddress: (NSString*) IPAddress{
    NSLog(@"set ip 1");
    [zenterio setIPAddress:IPAddress];
}

-(void) updateVolume: (UISlider*) slider {
    dispatch_queue_t queue = dispatch_queue_create("com.yourdomain.yourappname", NULL);
    dispatch_async(queue, ^{
        float vol = [zenterio getVolume];
        lastSliderValue = vol;
        [slider setValue:vol];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"zenterio vol = %f", vol);
        });
    });
}


/* Fullösning på volymen */
-(void) setVolume: (id) sender value: (float) val {
    currentSliderValue = val;
    int range;
    if (currentSliderValue > lastSliderValue) {
        range = (int) (currentSliderValue - lastSliderValue) / 5;
    } else {
        range = (int) (lastSliderValue - currentSliderValue) / 5;
    }
    NSLog(@"range=%d", range);
    for (int i = 0;i < range + 1; i++) {
        [self executeCommand:sender];
    }
    lastSliderValue = val;
}



@end