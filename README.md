## Lovense玩具蓝牙控制SDK对接文档 1.0
`谁来阅读此文档：`
`接入厂商产品的技术人员`


------------


#### 1.0.1 准备工作
1.把以下文件复制到工程主目录下
-  LovenseBluetoothSDK.framework

2.添加需要的 framework到工程

![](https://www.showdoc.cc/server/api/common/visitfile/sign/8d09f12716dceb90b3ced5223ad1b3aa?showdoc=.jpg)

3.配置环境:
TARGETS -> General -> Deployment Info -> Deployment Target -> 设置8.0或者以上版本


------------


#### 1.1.0  SDK简述

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
///这个一定要连接玩具后才有值
@property(nonatomic,copy)NSString * toyType;

//version
@property(nonatomic,copy)NSString * version;

//mac地址
@property(nonatomic,copy)NSString * macAddress;

///是否被蓝牙发现
@property(nonatomic,assign)BOOL isFound;

///Toy connection status
@property(nonatomic,assign)BOOL isConnected;

///Signal strength of the Bluetooth connection
@property(nonatomic,assign)int rssi;

///Battery status
@property(nonatomic,assign)int battery;
```

##### - LovenseBluetoothManager.h
1. 主要控制玩具的实现类（如扫描玩具，连接玩具，发送命令到玩具等）


------------

### - ** 如何使用SDK**


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


------------


### - ** Send command to the toy**

`OrderTypeVibrate`
`-Vibrate the toy .The parameter must be between 0 and 20!`

`OrderTypeRotate`
`-Rotate the toy .The parameter must be between 0 and 20!`

`OrderTypeRotateClockwise`
`-Rotate clockwise .The parameter must be between 0 and 20!`

`OrderTypeRotateAntiClockwise`
`-Rotate anti-clockwise .The parameter must be between 0 and 20!`

`OrderTypeRotateChange`
`-Change the rotation direction`

`OrderTypeAirIn`
`-Pump in air .The parameter can be 1,2 or 3`

`OrderTypeAirOut`
`-Release the air .The parameter can be 1,2 or 3`

`OrderTypeAirAuto`
`-循环充气n秒，放气n秒，0代表停止`

`OrderTypeVibrate1`
`-第一个震动马达以n档位震动`

`OrderTypeVibrate2`
`-第二个震动马达以n档位震动`

`OrderTypeVibrateAndFlash`
`-以某个档位震动，并且按指定频率闪灯`

`OrderTypeSetButtonClickOneLevel`
`-设置按第一下按钮的震动级别的强度.The parameter must be between 0 and 20!`

`OrderTypeSetButtonClickTwoLevel`
`-设置按第二下按钮的震动级别的强度.The parameter must be between 0 and 20!`

`OrderTypeSetButtonClickThreeLevel`
`-设置按第三下按钮的震动级别的强度.The parameter must be between 0 and 20!`

`OrderTypeGetFirstThreeButtonLevel`
`-返回前三个按钮的震动强度`

`OrderTypeFlash`
`-指示灯快速闪三下，然后恢复到之前状态`

`OrderTypeLightOff`
`-关闭指示灯，掉电保存`

`OrderTypeLightOn`
`-打开指示灯，掉电保存`

`OrderTypeGetLightStatus`
`-获取指示灯状态 1：开；0：关。`

`OrderTypeAidLightOff`
`-关闭辅助灯,掉电保存`

`OrderTypeAidLightOn`
`-打开辅助灯,掉电保存`

`OrderTypeGetAidLightStatus`
`-获取辅助灯状态 1：开；0：关。`

`OrderTypeBattery`
`-Get battery status`

`OrderTypeDeviceType`
`-Get device information`


`OrderTypeStartListenMove`
`-开始监听震动广播 ,震动回调 0-4`

`OrderTypeStopListenMove`
`-结束监听震动广播，震动回调 0-4`

`OrderTypeSaveProgram`
`-保存编程`

`OrderTypeGetAllExistedProgramButton`
`-获取所有已存在的编程按钮序号`



------------


### - ** Callback**

`kToyScanSuccessNotification`
`-扫描到玩具成功回调`

`kToyConnectSuccessNotification`
`-连接玩具成功回调`

`kToyConnectFailNotification`
`-连接玩具失败回调`

`kToyConnectBreakNotification`
`-断开玩具回调`

`kToySendOrderErrorNotification`
`-发送指令错误通知`

`kToyCallbackNotificationBattery`
`-电量回调`

`kToyCallbackNotificationDeviceType`
`-设备信息回调`

`kToyCallbackNotificationGetLightStatus`
`-指示灯是否开启`

`kToyCallbackNotificationGetAidLightStatus`
`-辅助灯是否开启`

`kToyCallbackNotificationGetFirstThreeButtonLevel`
`-返回前三个按钮的震动强度`

`kToyCallbackNotificationListenMove`
`-监听震动广播`

`kToyCallbackNotificationGetAllExistedProgramButton`
`- 获取所有已存在的编程按钮序号`

`kToyOrderCallbackNotificationAtSuccess`
`-命令成功回调`


`kToyOrderCallbackNotificationAtError`
`-命令错误回调`

