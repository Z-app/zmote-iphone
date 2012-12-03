Zmote iphone prototype

The files in /src/ is  BCTabBarController (https://github.com/briancollins/BCTabBarController)

In RCCommand-zenterio.m in the constructor the default IP is set. If the app won't start go there and insert a correct IP. This IP is changable inside the app afterwards.

If the app wont start it's cus it can't load the channel icons. Go to ZRemoteControlViewController.m and in the function -(void) viewDidLoad comment away the line "channels = [remoteControl createChannels]"
