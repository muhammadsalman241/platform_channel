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
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let modelChannel = FlutterMethodChannel(name: RANDOM_CHANNEL, binaryMessenger: controller.binaryMessenger)
    modelChannel.setMethodCallHandler(randomNumbersOnMethodCall)
        
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
