//
//  RCCommand-zenterio.m
//  Zmote-new
//
//  Created by Viktor Dahl on 2012-11-28.
//
//

#import "RCCommand-zenterio.h"
/* Implementation of all functions that connects with the actual box. */
@implementation RCCommand_zenterio

-(RCCommand_zenterio*) init {
    if (self) {
        IPAddr = @"130.236.248.226"; // The default IP of a box.
        return self;
    }
    return nil;
}

// Random URL request. Test function. Is not used.
- (void) URLRequest: (NSString*) url {
    NSURL *urlTemp = [[NSURL alloc] initWithString:url];
    NSString* response = [[NSString alloc] initWithData:[NSData dataWithContentsOfURL:urlTemp] encoding:NSUTF8StringEncoding];

}

/* Gets the channel icon. */
- (UIImage*) getChannelIcon: (NSString*) iconURL {
    NSURL *url = [[NSURL alloc] initWithString:iconURL];
    return [[ UIImage alloc ] initWithData: [ NSData dataWithContentsOfURL: url ]];
}

/* returns the EPG as a JSON object. For finding the channels. */
-(NSDictionary*) getEPG {
    NSMutableString* url = [NSMutableString stringWithFormat:@"http://"];
    [url appendString:IPAddr];
    [url appendString:@"/mdio/epg.php"];
    
    NSURL *jsonUrl = [NSURL URLWithString:url];
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonUrl options:kNilOptions error:&error];
    NSMutableDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if ([NSJSONSerialization isValidJSONObject:jsonResponse]) {
        NSMutableDictionary *jsonResponse = [NSJSONSerialization
                                             JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        return jsonResponse;
    }
    NSLog(@"Not a valid JSON Object");
    return nil;
}

/* Returns volume or 0 for mute. */
- (NSInteger) getVolume {
    NSMutableString* url = [NSMutableString stringWithFormat:@"http://"];
    [url appendString:IPAddr];
    [url appendString:@"/mdio/volume"];
    
    NSURL *jsonUrl = [NSURL URLWithString:url];
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonUrl options:kNilOptions error:&error];
    NSMutableDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];

    if ([[jsonResponse objectForKey:@"mute"] intValue] == 1) {
        return 0;
    }
    return [[jsonResponse objectForKey:@"volume"] intValue];
}

/* Sends a HTTP Request. */
-(void) sendRequest: (NSString*) command {
    dispatch_queue_t queue = dispatch_queue_create("com.yourdomain.yourappname", NULL);
    dispatch_async(queue, ^{
        NSMutableString* url = [NSMutableString stringWithFormat:@"http://"];
        [url appendString:IPAddr];
        [url appendString:@"/cgi-bin/writepipe_key"];
        NSURL *httpUrl = [NSURL URLWithString:url];
        
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:httpUrl];
        NSData *postData = [command dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:postData];
        NSError *err = nil;
        NSURLResponse *res;
        [NSURLConnection sendSynchronousRequest:request returningResponse:&res error:&err];
        if (err) {
            NSLog(@"Error sending command %@ to the url %@.", command, url);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    });
}

/* Returns current channel */
-(NSString*) getCurrentChannel {
    NSMutableString* url = [NSMutableString stringWithFormat:@"http://"];
    [url appendString:IPAddr];
    [url appendString:@"/mdio/currentchannel"];
    
    NSURL *jsonUrl = [NSURL URLWithString:url];
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonUrl options:kNilOptions error:&error];
    NSMutableDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    return [jsonResponse objectForKey:@"label"];
}

/* Changes the channel. DOES NOT WORK. Problem with the encoding of the channel URL sent. */
-(void) changeChannel: (NSString*) url {
    dispatch_queue_t queue = dispatch_queue_create("com.yourdomain.yourappname", NULL);
    dispatch_async(queue, ^{
        NSMutableString* urlFirst = [NSMutableString stringWithFormat:@"http://"];
        [urlFirst appendString:IPAddr];
        [urlFirst appendString:@"/mdio/launchurl?url="];
        [urlFirst appendString:url];
        [urlFirst appendString:@"&clid=0"];
        
        //    NSString *urlEncodedString = [@"Hej" encoding: NSISOLatin1StringEncoding];
        //    NSString *test = @"http://192.168.0.198/mdio/launchurl?url=http%3A%2F%2Fdownload.ted.com%2Ftalks%2FTerryMoore_2005-480p.mp4%3Fapikey%3DTEDDOWNLOAD%26contentViewer%3Dbroadcast%26onid%3D1%26tsid%3D1%26sid%3D1003%26nid%3D1%26clid%3D0";
        NSURL *urlTemp = [[NSURL alloc] initWithString:urlFirst];
        
        NSLog(@"URL Sent:  %@",urlFirst);
        NSString* response = [[NSString alloc] initWithData:[NSData dataWithContentsOfURL:urlTemp] encoding: NSASCIIStringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Response: %@", response);
        });
    });
    }

/* Returns the current IP address */
-(NSString*) getIPAddress {
    return IPAddr;
}

/* Sets the IP address. */
-(void) setIPAddress: (NSString*) IPAddress {
    IPAddr = IPAddress;
}
@end
