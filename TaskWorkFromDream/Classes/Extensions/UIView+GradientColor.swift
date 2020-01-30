import UIKit

/// グラデーションカラーを設定する
extension UIView {

    /// たてグラデーションカラーを設定する 上から下
    func setVerticalGradientColor(colors:[UIColor], locaitons:[NSNumber]? = nil) {
        self.setGradientColor(colors: colors,
                              startPoint: CGPoint(x: 0.5, y: 0.0),
                              endPoint: CGPoint(x: 0.5, y: 1.0),
                              locations: locaitons)
    }

    /// よこグラデーションカラーを設定する 左から右
    func setHorizontalGradientColor(colors:[UIColor], locations:[NSNumber]? = nil) {
        self.setGradientColor(colors: colors,
                              startPoint: CGPoint(x: 0.0, y: 0.5),
                              endPoint: CGPoint(x: 1.0, y: 0.5),
                              locations: locations)
    }

    /// グラデーションカラーを設定する
    ///
    /// - Parameters:
    ///   - colors: colors description
    ///   - startPoint: startPoint description
    ///   - endPoint: endPoint description
    func setGradientColor(colors:[UIColor], startPoint:CGPoint, endPoint:CGPoint, locations:[NSNumber]? = nil) {
        for view in self.subviews {
            if view is GradientView {
                return
            }
        }
        let gradientView:GradientView = .init(frame: self.bounds)
        gradientView.isUserInteractionEnabled = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(gradientView, at: 0)
        gradientView.setGradient(colors: colors, startPoint: startPoint,
                                 endPoint: endPoint, locations: locations)
        gradientView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = true
    }

    /// グラデーション解除
    func removeGradientColor() {
        for view in self.subviews {
            if view is GradientView {
                view.removeFromSuperview()
                return
            }
        }
    }

}

class GradientView:UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    /// グラデーションカラーを設定する
    ///
    /// - Parameters:
    ///   - colors: colors description
    ///   - startPoint: startPoint description
    ///   - endPoint: endPoint description
    func setGradient(colors:[UIColor], startPoint:CGPoint, endPoint:CGPoint, locations:[NSNumber]? = nil) {
        let gradientColors: [CGColor] = colors.map({$0.cgColor})
        let gradientLayer: CAGradientLayer = self.layer as! CAGradientLayer
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.bounds
        gradientLayer.locations = locations
    }
}

