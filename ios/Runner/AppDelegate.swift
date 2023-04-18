import AVKit
import FirebaseCore
import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var playerViewController: PlayerViewController?
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    override func application(_ application: UIApplication,
                              didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        FirebaseApp.configure()
        GeneratedPluginRegistrant.register(with: self)
        
        let flutterResult = super.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        print(self)
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let playerChannel = FlutterMethodChannel(name: "app.bcc.media/player",
                                                 binaryMessenger: controller.binaryMessenger)
        playerChannel.setMethodCallHandler {
            (call: FlutterMethodCall, result: @escaping FlutterResult) in
            // This method is invoked on the UI thread.
            guard call.method == "open" else {
                result(FlutterMethodNotImplemented)
                return
            }
            
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            
            let arg = call.arguments as! [String: Any]
            let url = arg["url"] as! String
            
            self.playerViewController = PlayerViewController(url: url)
            
            let navigation = UINavigationController(rootViewController: self.playerViewController!)
            let viewController: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController
            viewController?.present(navigation, animated: true, completion: nil)
        }
        
        return flutterResult
    }
    
    override func application(_ application: UIApplication,
                              supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
    {
        if fetchCurrentVC(self.window?.rootViewController) is AVPlayerViewController {
            return .allButUpsideDown
        }
        return .portrait
    }

    func fetchCurrentVC(_ viewController: UIViewController?) -> UIViewController? {
        if let tabBarController = viewController as? UITabBarController {
            return fetchCurrentVC(tabBarController.selectedViewController)
        }

        if let navigationController = viewController as? UINavigationController {
            return fetchCurrentVC(navigationController.visibleViewController)
        }

        if let viewController = viewController?.presentedViewController {
            return fetchCurrentVC(viewController)
        }

        return viewController
    }
}
