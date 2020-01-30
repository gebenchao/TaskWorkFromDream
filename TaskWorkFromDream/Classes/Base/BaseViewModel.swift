import Foundation
import RxCocoa
import RxSwift

/// BaseViewModel
class BaseViewModel {

    /// エラーハンドリング
    var errorAlertRelay:PublishRelay<(String)?>
    /// エラーハンドリング
    var errorAlert:Signal<(String)?>

    /// BaseViewModel
    init() {
        self.errorAlertRelay = .init()
        self.errorAlert = self.errorAlertRelay.asSignal()
    }

}
