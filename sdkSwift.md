#### SWIFT
### 4.Connect Lovense Toys

- Create YourProjectName-Bridging-Header.h 
- Import LovenseBluetoothManager 

```objective-c
#import <LovenseBluetoothSDK/LovenseBluetoothManager.h>
```

-   Pass your token into Lovense framework

```objective-c
    LovenseBluetoothManager.shared().setDeveloperToken("token")
```

-  Add a scan success notification
```objective-c
NotificationCenter.default.addObserver(self, selector: #selector(scanSuccessCallback), name: NSNotification.Name(rawValue: kToyScanSuccessNotification), object: nil)     //Scanning toy success notification
 @objc func scanSuccessCallback(nofi : Notification){
        let dict = nofi.object as? Dictionary<String, Any>
        let scanToyArr = dict?["scanToyArray"] as? Array<LovenseToy>
    }
```

-  Add a connect success notification
```objective-c
NotificationCenter.default.addObserver(self, selector: #selector(connectSuccessCallback), name: NSNotification.Name(rawValue: kToyConnectSuccessNotification), object: nil)     //Connected toy successfully notification
@objc func connectSuccessCallback(nofi : Notification){
        let dict = nofi.object as? Dictionary<String, Any>
        let toy = dict?["toy"] as? LovenseToy
    }
```

-  Search the toys over Bluetooth

```objective-c
    LovenseBluetoothManager.shared().setDeveloperToken("token")
```


-  Save the toys

```objective-c
    LovenseBluetoothManager.shared().saveToyList([LovenseToy()])
```

-  Retrieve the saved toys

```objective-c
       LovenseBluetoothManager.shared().getSavedToyList()

```

-   Connect the toy

```objective-c
       LovenseBluetoothManager.shared().connectToy("toyId")

```


-   Disconnect the  toy

```objective-c
       LovenseBluetoothManager.shared().disconnectToy("toyId")

```

-    Send a command to the toy

```objective-c
     LovenseBluetoothManager.shared().sendCommand(withToyId: "ToyId", andCommandType: COMMAND_VIBRATE, andParamDict: [kSendCommandParamKey_VibrateLevel:20])
```



 */
