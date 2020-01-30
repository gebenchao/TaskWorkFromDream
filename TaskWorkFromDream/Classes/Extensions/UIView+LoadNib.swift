import UIKit

/// xibファイルを読み込むextension
extension UIView {
    /// xibファイルからViewをinitializeする
    func loadNib() {
        let view = Bundle.main.loadNibNamed(className, owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
        backgroundColor = UIColor.clear
        view.leftAnchor.constraint(equalTo: view.superview!.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: view.superview!.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: view.superview!.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: view.superview!.bottomAnchor).isActive = true
    }
}
