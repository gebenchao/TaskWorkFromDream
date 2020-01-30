import UIKit

class AppConfigs {
    
    struct Network {
        static let appHostUrl = "https://labs.goo.ne.jp/api/"
        static let gooImageURL = "http://u.xgoo.jp/img/sgoo.png"
        
    }
    
    struct Dimensions {
        static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
        static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        static let naviBarHeight: CGFloat = 44
        static let topHeight: CGFloat = statusBarHeight + naviBarHeight
    }
    
    struct Device {
        /// バージョン
        static let osVersion = UIDevice.current.systemVersion
        /// デバイスID
        static let ID = UIDevice.current.identifierForVendor!.uuidString
    }
    
}
