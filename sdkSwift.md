#### SWIFT
### 4.Connect Lovense Toys

- Create YourProjectName-Bridging-Header.h 
- Import Lovense 

```objective-c
#import <Lovense/Lovense.h>
```

-   Pass your token into Lovense framework

```objective-c
    Lovense.shared().setDeveloperToken("token")
```

-  Add a scan success notification
```objective-c
NotificationCenter.default.addObserver(self, selector: #selector(scanSuccessCallback), name: NSNotification.Name(rawValue: kToyScanSuccessNotification), object: nil)     //Scanning toy success notification
 @objc func scanSuccessCallback(nofi : Notification){
        let dict = nofi.object as? [String : LovenseToy]
        let scanToyArr = dict?["scanToyArray"]
    }
```

-  Add a connect success notification
```objective-c
NotificationCenter.default.addObserver(self, selector: #selector(connectSuccessCallback), name: NSNotification.Name(rawValue: kToyConnectSuccessNotification), object: nil)     //Connected toy successfully notification
@objc func connectSuccessCallback(nofi : Notification){
        let dict = nofi.object as? [String : Any]
        let toy = dict?["toy"] as? LovenseToy
    }
```

-  Search the toys over Bluetooth

```objective-c
    Lovense.shared().setDeveloperToken("token")
```


-  Save the toys

```objective-c
    Lovense.shared().save(toys)
```

-  Retrieve the saved toys

```objective-c
    Lovense.shared().listToys()

```

-   Connect the toy

```objective-c
   Lovense.shared().connectToy("toyId")

```


-   Disconnect the  toy

```objective-c
  Lovense.shared().disconnectToy("toyId")

```

-    Send a command to the toy

```objective-c
     Lovense.shared().sendCommand(withToyId: "ToyId", andCommandType: COMMAND_VIBRATE, andParamDict: [kSendCommandParamKey_VibrateLevel:20])
```



 */
