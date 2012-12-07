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
//        IPAddr = @"192.168.0.196";
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
    @try {
        NSURL *url = [[NSURL alloc] initWithString:iconURL];
        return [[ UIImage alloc ] initWithData: [ NSData dataWithContentsOfURL: url ]];
    }
    @catch (NSException *exception) {
        return nil;
    }
    
    
    
}

/* returns the EPG as a JSON object. For finding the channels. */
-(NSDictionary*) getEPG {
    @try {
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
    @catch (NSException *exception) {
        return nil;
    }
    
}

/* Returns volume or 0 for mute. */
- (NSInteger) getVolume {
    @try {
        NSMutableString* url = [NSMutableString stringWithFormat:@"http://"];
        [url appendString:IPAddr];
        [url appendString:@"/mdio/volume"];
        
        NSURL *jsonUrl = [NSURL URLWithString:url];
        NSError *error = nil;
        NSData *jsonData = [NSData dataWithContentsOfURL:jsonUrl options:kNilOptions error:&error];
        NSMutableDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        return [[jsonResponse objectForKey:@"volume"] intValue];    }
    @catch (NSException *exception) {
        return 0;
    }
    
}

/* Sends a HTTP Request. */
-(void) sendRequest: (NSString*) command {
    dispatch_queue_t queue = dispatch_queue_create("com.yourdomain.yourappname", NULL);
    dispatch_async(queue, ^{
        @try {
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
        }
        @catch (NSException *exception) {
        }
    });
}

/* Returns current channel */
-(NSString*) getCurrentChannel {
    
    @try {
        NSMutableString* url = [NSMutableString stringWithFormat:@"http://"];
        [url appendString:IPAddr];
        [url appendString:@"/mdio/currentchannel"];
        
        NSURL *jsonUrl = [NSURL URLWithString:url];
        NSError *error = nil;
        NSData *jsonData = [NSData dataWithContentsOfURL:jsonUrl options:kNilOptions error:&error];
        NSMutableDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        return [jsonResponse objectForKey:@"label"];
    }
    @catch (NSException *exception) {
        return nil;
    }
    }

/* Changes the channel. */
-(void) changeChannel: (NSString*) url {
    @try {
        dispatch_queue_t queue = dispatch_queue_create("com.yourdomain.yourappname", NULL);
        dispatch_async(queue, ^{
            NSMutableString* urlFirst = [NSMutableString stringWithFormat:@"http://"];
            [urlFirst appendString:IPAddr];
            [urlFirst appendString:@"/mdio/launchurl?url="];
            [urlFirst appendString:[self encodeUrl:url]];
            [urlFirst appendString:@"%26clid%3D0"]; // '%3D' is '='
            NSURL *urlTemp = [[NSURL alloc] initWithString:urlFirst];
            
            NSLog(@"URL Sent:  %@",urlFirst);
            NSString* response = [[NSString alloc] initWithData:[NSData dataWithContentsOfURL:urlTemp] encoding: NSASCIIStringEncoding];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Response: %@", response);
            });
        });

    }
    @catch (NSException *exception) {
        
    }

    
    
    }

/* Returns the current IP address */
-(NSString*) getIPAddress {
    return IPAddr;
}

/* Sets the IP address. */
-(void) setIPAddress: (NSString*) IPAddress {
    IPAddr = IPAddress;
}
/* Encodes the URL by replaceing : with %3A etc... */
-(NSString*) encodeUrl: (NSString*) url {
    NSMutableString* string = [[NSMutableString alloc] initWithString:url];
    NSArray *signs =  @[@":", @"/", @"?", @"=", @"&"]; // More can be added here if needed.
    
    for (NSString* ch in signs) {
        NSArray* tempArray = [[NSArray alloc] init];
        tempArray = [string componentsSeparatedByString:ch];
        [string setString:@""];
        
        NSString* replacement;
        if ([ch isEqualToString:@":"]) {
            replacement = @"%3A";
        } else if ([ch isEqualToString:@"/"]) {
            replacement = @"%2F";
        } else if ([ch isEqualToString:@"?"]) {
            replacement = @"%3F";
        } else if ([ch isEqualToString:@"="]) {
            replacement = @"%3D";
        } else if ([ch isEqualToString:@"&"]) {
            replacement = @"%26";
        }
        /* The actual replacement of the signs here */
        for (NSString* part in tempArray) {
            [string appendString:part];
            if ([part isEqualToString:tempArray.lastObject]) {
                break; // Dont append to the end of the string.
            }
            [string appendString:replacement];
        }
    }
    return string;
}
-(void) setVolume: (float) val {
    
}
@end
