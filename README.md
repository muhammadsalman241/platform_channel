# platform_channel

A platform Channel Example

## Use Native code in Flutter


# Using Native code in Flutter

Flutter is a cross-platform app development framework that lets you write code in Dart and run it on multiple platforms. It has all the tools you need to build UIs, but sometimes you need to call native features. Flutter has a feature called platform channels that lets you do this. You can call native code from Dart and get the results back in your Dart code. Just specify the native code in the respective directory.

## How to do this

1. Write Native code in android folder
2. Register your Native code as Method Channel in `FlutterFragmentActivity`
3. Write Native code in ios folder
4. Register your code as Method Channel in `FlutterAppDelegate`
5. Use your native code in dart using `MethodChannel`

# Example

We will go through all of these steps one by one

### 1. Write Kotlin code in android folder

```kotlin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class RandomNumbers: MethodChannel.MethodCallHandler {
	private val GENERATE = "generate"
	
	override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
      when(call.method) {
          GENERATE -> generate(call, result)
          else -> result.notImplemented()
      }
  }

	private fun generate(call: MethodCall, result: MethodChannel.Result) {
		val userRange = ((call.arguments as? Map<*, *>)?.get("range") ?: 100) as Int
		if(userRange > 100) {
			result.error("Out of range", "Currently we dont support > 100", Exception("outta range"))
		} else {
			val ranNum = (0..userRange).random()
			result.success(mapOf("ran" to ranNum, "rangeStart" to 0, "rangeEnd" to userRange))
		}
	}
}
```

### 2. Register android code in FlutterFragmentActivity

```kotlin
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity() {

    private val RANDOM_CHANNEL = "com.your.app/random_num"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, RANDOM_CHANNEL).setMethodCallHandler(RandomNumbers())
    }
}
```

### 3. Write Swift code in ios

```swift
import Foundation
import Flutter

enum Methods: String {
    case GENERATE = "generate"
}

let ranGenerator = RandomNumbers()

func randomNumbersOnMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let mode = Methods(rawValue: call.method)
    switch mode {
        case .GENERATE:
            ranGenerator.generate(call, result)
        default:
            result(FlutterMethodNotImplemented)
                return
    }
}

class RandomNumbers {
	
	func generate(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
		let userRange = ((call.arguments as? Dictionary<String, Any>)?["range"] as? Int ?? 100)

		if userRange > 100 {
			result(FlutterError(code: "Out of range", message: "Currently we dont support > 100", details: nil))
		} else {
			let ranNum = Int.random(in: 0...userRange)
			result(["ran": ranNum, "rangeStart": 0, "rangeEnd": userRange])
		}
	}

}
```

### 4. Register ios code in FlutterAppDelegate

```swift
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    let RANDOM_CHANNEL = "com.your.app/random_num"
    
	  override func application(
	    _ application: UIApplication,
	    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	  ) -> Bool {
	   
	    GeneratedPluginRegistrant.register(with: self)
			//Register Here
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let modelChannel = FlutterMethodChannel(name: RANDOM_CHANNEL, binaryMessenger: controller.binaryMessenger)
      modelChannel.setMethodCallHandler(randomNumbersOnMethodCall)
      
	      
	    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
	  }
}
```

### 5. Consume code in dart

```dart
import 'package:flutter/services.dart';

class RandomNumbers {
	static const RANDOM_CHANNEL = "com.your.app/random_num";
	static const METHOD_GENERATE = "generate";

	final MethodChannel channel = MethodChannel(RANDOM_CHANNEL);

	Future<int?> generate([int? userRange]) async {
    try {
      final result = await channel.invokeMethod(METHOD_GENERATE, <String, dynamic>{
        'range': userRange,
      });
      final res = result as Map;
		  print(res);
			return res["ran"];
    } catch(e) {
      print("generate exception: $e");
			rethrow;
    }
  }

}
```

Yayyyy 🥳 you did this, Now use this method anywhere like a normal dart method.

