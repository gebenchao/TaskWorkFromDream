import UIKit

/// イニシャライズする処理のextension
extension UIViewController {
    /// ストーリーボードからViewControllerをinitializeする
    ///
    /// - Returns: initializeしたインスタンス
    static func loadFromStoryboard<T: UIViewController>() -> T {
        let vc: T = UIStoryboard(name: T.className, bundle: nil).instantiateInitialViewController() as! T
        return vc
    }
    
    /// NavigationBarの共通設定
    func initNavigationBar() {
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.tintColor = UIColor.baseLightDeep
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14.0),
            NSAttributedString.Key.foregroundColor:UIColor.white
        ]
        let titleView:UIView = .init(frame: CGRect(x: 0.0, y: 0.0, width: AppConfigs.Dimensions.screenWidth, height: AppConfigs.Dimensions.topHeight))
            titleView.backgroundColor = UIColor.baseLightPale
        self.view.addSubview(titleView)
        
    }
}

/// クラス名のextension
extension NSObject {
    /// クラス名
    public static var className: String {
        return String(describing: self)
    }

    /// クラス名
    public var className: String {
        return type(of: self).className
    }
}
