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

##### - LovenseBluetoothManager.h
1. 主要控制玩具的实现类（如扫描玩具，连接玩具，发送命令到玩具等）


------------


#### 1.2.0  如何使用SDK

- 导入 LovenseBluetoothManager 

```objective-c
#import <LovenseBluetoothSDK/LovenseBluetoothManager.h>

```

-  扫描玩具 并 自动连接

```objective-c
    [[LovenseBluetoothManager shared] searchToysWithIsAutoConnect:YES];

```

- 监听玩具连接

```objective-c
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scanSuccessCallback:) name:kToyScanSuccessNotification object:nil];     //扫描玩具成功通知监听

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectSuccessCallback:) name:kToyConnectSuccessNotification object:nil];     //连接玩具成功
}
```

- 玩具连接成功回调

```objective-c
//扫描成功回调
-(void)scanSuccessCallback:(NSNotification *)noti
{
    NSDictionary * dict = [noti object];
    NSArray<LovenseToy * > * scanToyArr = [dict objectForKey:@"scanToyArray"];
}

//连接成功回调
-(void)connectSuccessCallback:(NSNotification *)noti
{

}
```

- 控制玩具震动

```objective-c
NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
[paramDict setObject:@(20) forKey:kSendOrderParamKey_VibrateLevel];

[[LovenseBluetoothManager shared] sendOrderWithToyId:toy.identifier andOrderType:OrderTypeVibrate andParamDict:paramDict ];
```

------------

#### 1.3.0 详细命令说明

```objective-c
/**
     - Vibrate the toy .The parameter must be between 0 and 20!
     - param Key = kSendOrderParamKey_VibrateLevel
     - Supported toys = all
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeVibrate = 101,

    /**
     - Rotate the toy .The parameter must be between 0 and 20!
     - param Key = kSendOrderParamKey_RotateLevel
     - Supported toys = Nora
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeRotate = 102,

    /**
     - Rotate clockwise .The parameter must be between 0 and 20!
     - param Key = kSendOrderParamKey_RotateLevel
     - Supported toys = Nora
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeRotateClockwise = 103,

    /**
     - Rotate anti-clockwise .The parameter must be between 0 and 20!
     - param Key = kSendOrderParamKey_RotateLevel
     - Supported toys = Nora
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeRotateAntiClockwise = 104,

    /**
     - Change the rotation direction
     - param Key = no parameter
     - Supported toys = Nora
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeRotateChange = 105,

    /**
     - Pump in air .The parameter can be 1,2 or 3
     - param Key = kSendOrderParamKey_AirLevel
     - Supported toys = Max
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeAirIn =  110,

    /**
     - Release the air .The parameter can be 1,2 or 3
     - param Key = kSendOrderParamKey_AirLevel
     - Supported toys = Max
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeAirOut = 111,

    /**
     - 循环充气n秒，放气n秒，0代表停止
     - Start contraction. The parameter can be 1,2 or 3 ; 0 = stop
     - param Key = kSendOrderParamKey_AirAutoSec
     - Supported toys = Max
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeAirAuto = 112,

    /**
     - 第一个震动马达以n档位震动
     - param Key = kSendOrderParamKey_VibrateLevel
     - Supported toys = Edge
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeVibrate1 = 113,

    /**
     - 第二个震动马达以n档位震动
     - param Key = kSendOrderParamKey_VibrateLevel
     - Supported toys = Edge
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeVibrate2 = 114,

    /**
     - 以某个档位震动，并且按指定频率闪灯
     - param key = kSendOrderParamKey_VibrateLevel: 为震动级别，取值范围为1，2，3
     - param key = kSendOrderParamKey_FlashLevel: 为闪灯频率（每秒闪灯次数），取值范围为0~9
     - Supported toys = Ambi / Domi / Osci
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeVibrateAndFlash = 120,

    /**
     - 设置按第一下按钮的震动级别的强度.The parameter must be between 0 and 20!
     - param Key = kSendOrderParamKey_VibrateLevel
     - Supported toys = Ambi / Domi / Osci
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeSetButtonClickOneLevel = 131,

    /**
     - 设置按第二下按钮的震动级别的强度.The parameter must be between 0 and 20!
     - param Key = kSendOrderParamKey_VibrateLevel
     - Supported toys = Ambi / Domi / Osci
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeSetButtonClickTwoLevel = 132,

    /**
     - 设置按第三下按钮的震动级别的强度.The parameter must be between 0 and 20!
     - param Key = kSendOrderParamKey_VibrateLevel
     - Supported toys = Ambi / Domi / Osci
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeSetButtonClickThreeLevel = 133,

    /**
     - 返回前三个按钮的震动强度
     - param Key = no parameter
     - Supported toys = Ambi / Domi / Osci
     - return notification = kToyCallbackNotificationGetFirstThreeButtonLevel
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"buttonOneLevel":NSString,
     @"buttonTwoLevel":NSString,
     @"buttonThreeLevel":NSString
     }
     */
    OrderTypeGetFirstThreeButtonLevel = 140,

    /**
     - 指示灯快速闪三下，然后恢复到之前状态
     - param Key = no parameter
     - Supported toys = all
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeFlash = 201,

    /**
     - 关闭指示灯，掉电保存
     - param Key = no parameter
     - Supported toys = Lush / Hush / Edge
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeLightOff = 210,

    /**
     - 打开指示灯，掉电保存
     - param Key = no parameter
     - Supported toys = Lush / Hush / Edge
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeLightOn = 211,

    /**
     获取指示灯状态 1：开；0：关。
     - param Key = no parameter
     * Supported toys = Lush  Hush  Edge
     - return notification "kToyCallbackNotificationGetLightStatus"
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"isOpen":NSString
     }
     */
    OrderTypeGetLightStatus = 212,

    /**
     - 关闭辅助灯,掉电保存
     - param Key = no parameter
     - Supported toys = Domi
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeAidLightOff = 220,

    /**
     - 打开辅助灯,掉电保存
     - param Key = no parameter
     - Supported toys = Domi
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeAidLightOn = 221,

    /**
     获取辅助灯状态 1：开；0：关。
     - param Key = no parameter
     * Supported toys = Domi
     - return notification "kToyCallbackNotificationGetAidLightStatus"
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"isOpen":NSString
     }
     */
    OrderTypeGetAidLightStatus = 222,

    /**
     - Get battery status,
     - param Key = no parameter
     * Supported toys = all
     - return notification "kToyCallbackNotificationBattery"
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"battery":NSString}
     */
    OrderTypeBattery = 300,

    /**
     Get device information
     - 获取设备信息，版本，类型
     - param Key = no parameter
     * Supported toys = all
     - return notification "kToyCallbackNotificationDeviceType"
      [notification object] = @{@"receiveToy":LovenseToy,
      @"receiveToyUUID":NSString,
      @"type":NSString,
      @"version":NSString,
      @"macAddress":NSString
      }
     */
    OrderTypeDeviceType = 310,

    /**
     开始监听震动广播 ,震动回调 0-4
     - param Key = no parameter
     * Supported toys = Max,Nora
     - return notification "kToyCallbackNotificationListenMove"
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"moveLevel":NSString
     }
     */
    OrderTypeStartListenMove = 400,

    /**
     结束监听震动广播，震动回调 0-4
     - param Key = no parameter
     * Supported toys = Max,Nora
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeStopListenMove = 401,

    /**
     保存编程
     - param Key = kSendOrderParamKey_ProgramButton : 0-10 就是玩具每按一下按钮，channel就加1
     - param Key = kSendOrderParamKey_ProgramContent : 传入一个数组，按数组的内容进行编程，数组最多长度是500，名字执行完成后会重复执行
     - 支持最多500个震动数值，旧版玩具由于硬件问题，敏感度比新版玩具低
     * Supported toys = Ambi, Domi, Osci
     - return notification = kToyOrderCallbackNotificationAtSuccess
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"orderType":NSString
     }
     */
    OrderTypeSaveProgram = 500,

    /**
     获取所有已存在的编程按钮序号
     * Supported toys = Ambi, Domi, Osci
     - return notification = kToyCallbackNotificationGetAllExistedProgramButton
     - return object = "kToyCallbackNotificationGetAllExistedProgramButton"
     [notification object] = @{@"receiveToy":LovenseToy,
     @"receiveToyUUID":NSString,
     @"allExistedString":NSString
     }
     ***/
    OrderTypeGetAllExistedProgramButton = 501
```

------------

#### 1.3.1 参数key

```objective-c
#define kSendOrderParamKey_VibrateLevel @"VibrateLevel" //震动参数key 0-20
#define kSendOrderParamKey_RotateLevel @"RotateLevel"   //旋转参数key 0-20
#define kSendOrderParamKey_AirLevel @"AirLevel"     //The parameter can be 1,2 or 3
#define kSendOrderParamKey_AirAutoSec @"AirAutoSec" //The parameter can be 0,1,2 or 3 ; 0 = stop
#define kSendOrderParamKey_FlashLevel @"FlashLevel" //闪灯参数key 0-9
#define kSendOrderParamKey_ProgramButton @"ProgramButton" //0-10 就是玩具每按一下按钮，channel就加1
#define kSendOrderParamKey_ProgramContent @"ProgramContent" //传入一个数组，按数组的内容进行编程，数组最多长度是100
```

#### 1.3.2 回调
```objective-c
**
 扫描到玩具成功回调
 通知回调参数object = @{@"scanToyArray":<LovenseToy*>NSArray*}
 **/
#define kToyScanSuccessNotification @"kToyScanSuccessNotification"

/**
 连接玩具成功回调
 通知回调参数object = @{@"toy":LovenseToy}
 **/
#define kToyConnectSuccessNotification @"kToyConnectSuccessNotification"

/**
 连接玩具失败回调
 通知回调参数object = @{@"toy":LovenseToy,@"error":NSString}
 **/
#define kToyConnectFailNotification @"kToyConnectFailNotification"

/**
 断开玩具回调
 通知回调参数object = @{@"toy":LovenseToy,@"error":NSError}
 **/
#define kToyConnectBreakNotification @"kToyConnectBreakNotification"

/**
 发送指令错误通知
 通知回调参数object = @{@"errorDesc":NSString}
 **/
#define kToySendOrderErrorNotification @"kToySendOrderErrorNotification"

/**
 命令成功回调
 通知回调参数object = @{@"receiveToy":LovenseToy,
 @"receiveToyUUID":NSString,
 @"orderType":NSString
 }
 **/
#define kToyOrderCallbackNotificationAtSuccess @"kToyOrderCallbackNotificationAtSuccess"

/**
 命令错误回调
 通知回调参数object = @{@"receiveToy":LovenseToy,
 @"receiveToyUUID":NSString,
 @"orderType":NSString
 }
 **/
#define kToyOrderCallbackNotificationAtError @"kToyOrderCallbackNotificationAtError"

/**
 电量回调
 通知回调参数object = @{@"receiveToy":LovenseToy,
 @"receiveToyUUID":NSString,
 @"battery":NSString}
 **/
#define kToyCallbackNotificationBattery @"kToyCallbackNotificationBattery"

/**
 设备信息回调
 通知回调参数object = @{@"receiveToy":LovenseToy,
 @"receiveToyUUID":NSString,
 @"type":NSString,
 @"version":NSString,
 @"macAddress":NSString
 }
 **/
#define kToyCallbackNotificationDeviceType @"kToyCallbackNotificationDeviceType"

/**
 指示灯是否开启
 通知回调参数object = @{@"receiveToy":LovenseToy,
 @"receiveToyUUID":NSString,
 @"isOpen":NSString
 }
 **/
#define kToyCallbackNotificationGetLightStatus @"kToyCallbackNotificationGetLightStatus"

/**
 辅助灯是否开启
 通知回调参数object = @{@"receiveToy":LovenseToy,
 @"receiveToyUUID":NSString,
 @"isOpen":NSString
 }
 **/
#define kToyCallbackNotificationGetAidLightStatus @"kToyCallbackNotificationGetAidLightStatus"

/**
 返回前三个按钮的震动强度
 通知回调参数object = @{@"receiveToy":LovenseToy,
 @"receiveToyUUID":NSString,
 @"buttonOneLevel":NSString,
 @"buttonTwoLevel":NSString,
 @"buttonThreeLevel":NSString
 }
 **/
#define kToyCallbackNotificationGetFirstThreeButtonLevel @"kToyCallbackNotificationGetFirstThreeButtonLevel"

/**
 监听震动广播
 通知回调参数object = @{@"receiveToy":LovenseToy,
 @"receiveToyUUID":NSString,
 @"moveLevel":NSString
 }
 **/
#define kToyCallbackNotificationListenMove @"kToyCallbackNotificationListenMove"

/**
 获取所有已存在的编程按钮序号
 通知回调参数object = @{@"receiveToy":LovenseToy,
 @"receiveToyUUID":NSString,
 @"allExistedString":NSString
 }
 **/
#define kToyCallbackNotificationGetAllExistedProgramButton @"kToyCallbackNotificationGetAllExistedProgramButton"

```
