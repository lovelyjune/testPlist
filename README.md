## Lovense SDK for iOS 1.0


------------


### - ** 1.把以下文件复制到工程主目录下**
-  LovenseBluetoothSDK.framework

### - ** 2.添加需要的 framework到工程**

![](https://www.showdoc.cc/server/api/common/visitfile/sign/8d09f12716dceb90b3ced5223ad1b3aa?showdoc=.jpg)

### - ** 3.配置环境**
TARGETS -> General -> Deployment Info -> Deployment Target -> 设置8.0或者以上版本


### - ** 4.Connect Lovense Toys**


- 导入 LovenseBluetoothManager 

```objective-c
#import <LovenseBluetoothSDK/LovenseBluetoothManager.h>
```

-   Pass your token into Lovense framework

```objective-c
    [[LovenseBluetoothManager shared] setDeveloperToken:@"Your token"];
```

-  add scan success notification
```objective-c
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scanSuccessCallback:) name:kToyScanSuccessNotification object:nil];     //Scanning toy success notification
-(void)scanSuccessCallback:(NSNotification *)noti
{
    NSDictionary * dict = [noti object];
    NSArray <LovenseToy*> * scanToyArr = [dict objectForKey:@"scanToyArray"];
}
```

-  add connect success notification
```objective-c
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectSuccessCallback:) name:kToyConnectSuccessNotification object:nil];     //Connected toy successfully notification
-(void)connectSuccessCallback:(NSNotification *)noti
{
    NSDictionary * dict = [noti object];
    LovenseToy * toy = [dict objectForKey:@"toy"];
    NSLog(@"%@",toy);
}
```

-  Search the toys over Bluetooth

```objective-c
    [[LovenseBluetoothManager shared] searchToysWithIsAutoConnect:YES];
```


-  Save the toys

```objective-c
    [[LovenseBluetoothManager shared] saveToyList:self.allToyModelArr];
```

-  Retrieve the saved toys

```objective-c
        NSArray<LovenseToy*> * toyList = [[LovenseBluetoothManager shared] getSavedToyList];

```

-   Connect the toy

```objective-c
        [[LovenseBluetoothManager shared] connectToy:self.currentToy.identifier];

```


-   Disconnect the  toy

```objective-c
         [[LovenseBluetoothManager shared] disconnectToy:self.currentToy.identifier];

```

-    Send a command to the toy

```objective-c
         [[LovenseBluetoothManager shared] sendCommandWithToyId:toy.identifier andCommandType:COMMAND_VIBRATE andParamDict:@{kSendCommandParamKey_VibrateLevel:@(20)}];
```



 */

------------


### - ** command list **

`COMMAND_VIBRATE`
`-Vibrate the toy .The parameter must be between 0 and 20!`

`COMMAND_ROTATE`
`-Rotate the toy .The parameter must be between 0 and 20!`

`COMMAND_ROTATE_CLOCKWISE`
`-Rotate clockwise .The parameter must be between 0 and 20!`

`COMMAND_ROTATE_ANTI_CLOCKWISE`
`-Rotate anti-clockwise .The parameter must be between 0 and 20!`

`COMMAND_ROTATE_CHANGE`
`-Change the rotation direction`

`COMMAND_VIBRATE1`
`-Activate the first vibrator at level n .The parameter must be between 0 and 20!`

`COMMAND_VIBRATE2`
`-Activate the second vibrator at level n .The parameter must be between 0 and 20!`

`COMMAND_VIBRATE_FLASH`
`-Vibrate the toy at level n, and flash the light at the same time .The parameter must be between 0 and 20!`

`COMMAND_FLASH`
`-Flash the light 3 times`

`COMMAND_LIGHT_OFF`
`-Turn off the light (saved permanently)`

`COMMAND_LIGHT_ON`
`-Turn on the light (saved permanently)`

`COMMAND_GET_LIGHT_STATUS`
`-Get the light status (1: on, 0:off)`

`COMMAND_ALIGHT_OFF`
`-Turn off the AID light (saved permanently)`

`COMMAND_ALIGHT_ON`
`-Turn on the AID light (saved permanently)`

`COMMAND_GET_ALIGHT_STATUS`
`-Get the AID light status (1: on, 0:off)`

`COMMAND_BATTERY`
`-Get battery status`

`COMMAND_DEVICE_TYPE`
`-Get device/toy information`

`COMMAND_START_MOVE`
`-Start tracking the toy movement (0-4)`

`COMMAND_STOP_MOVE`
`-Stop tracking the toy movement`



------------


### - ** Notification list**

`kToyScanSuccessNotification`
`- Found toys`

`kToyConnectSuccessNotification`
`-Toy connected`

`kToyConnectFailNotification`
`-Failed to connect a toy`

`kToyConnectBreakNotification`
`-Disconnect a toy`

`kToySendCommandErrorNotification`
`-Unknown Command Received`

`kToyCallbackNotificationBattery`
`-Battery status`

`kToyCallbackNotificationDeviceType`
`-Device information`

`kToyCallbackNotificationGetLightStatus`
`-Light indicator`

`kToyCallbackNotificationGetAidLightStatus`
`-AID light indicator`


`kToyCallbackNotificationListenMove`
`-Toy movement updates`


`kToyCommandCallbackNotificationAtSuccess`
`-Command success`


`kToyCommandCallbackNotificationAtError`
`-Command Error`


------------

####  SDK简述

SDK有三个头文件，分别有以下用途
##### - LovenseBluetoothDefine.h
1. 记录所有控制玩具命令的枚举（如震动指令OrderTypeVibrate）
2. 记录所有命令参数的KEY（如震动参数kSendOrderParamKey_VibrateLevel）
3. 记录所有命令回调（如扫描玩具成功回调kToyScanSuccessNotification）

##### - LovenseToy.h
1. 玩具类，记录玩具所有属性（如玩具名称，玩具类型等）

```objective-c
///name
@property(nonatomic,copy)NSString * name;

///Toy Identifier
@property(nonatomic,copy)NSString * identifier;

///Toy type - Nora/Max/Lush/Hush/Ambi/Osci/Edge/Domi
///Once a toy connected, it will populated with a value
@property(nonatomic,copy)NSString * toyType;

//version
@property(nonatomic,copy)NSString * version;

//MAC address
@property(nonatomic,copy)NSString * macAddress;

///visibility to Bluetooth search
@property(nonatomic,assign)BOOL isFound;

///Toy connection status
@property(nonatomic,assign)BOOL isConnected;

///Signal strength of the Bluetooth connection
@property(nonatomic,assign)int rssi;

///Battery status
@property(nonatomic,assign)int battery;
```

##### - LovenseBluetoothManager.h
主要控制玩具的实现类（如扫描玩具，连接玩具，发送命令到玩具等）


