import Foundation
import RxCocoa
import RxSwift

class TranslateListViewModel :BaseViewModel{
        
    private let translateDataRelay:BehaviorRelay<[TranslateResponse]>
    lazy var translateData: Driver<[TranslateResponse]> = { return self.translateDataRelay.asDriver() }()
    
    private let inputTextRelay:BehaviorRelay<String>
    lazy var inputText: Driver<String> = { return self.inputTextRelay.asDriver() }()
    
    /// ボタンの活性化、非活性化切り替え
    private var enableConfirmButtonRelay:BehaviorRelay<Bool>
    /// ボタンの活性化、非活性化切り替え
    lazy var enableConfirmButton:Driver<Bool> = { return self.enableConfirmButtonRelay.asDriver() }()
    /// 一覧状態更新
    private let updateStateRelay:BehaviorRelay<Bool>
    /// 一覧状態更新
    lazy var updateState: Driver<Bool> = { return self.updateStateRelay.asDriver() }()
    
    private let apiRequest = TranslateApiRequest()
    
    override init() {
        self.inputTextRelay = .init(value: "")
        self.translateDataRelay = .init(value: [])
        self.enableConfirmButtonRelay = .init(value: false)
        self.updateStateRelay = .init(value: false)
        super.init()
        self.initData()
    }
        
    /// 必要なデータの取得
    func initData() {
        
    }

    func inputText(text: String) {
        self.inputTextRelay.accept(text)
        self.updateConfirmButtonEnable()
    }
    
    func sendSearchRequest() {
        let inputText = self.inputTextRelay.value
        apiRequest.request(target: .hiragana(sentence: inputText ), response: TranslateResponse.self, errorResponse: TranslateErrorResponse.self) { respose in
                switch respose {
                case .success(let response):
                    self.translateDataRelay.accept([response])
                    self.updateStateRelay.accept(true)
                case .invalid(let errorResponse):
                    DialogManager.dialog(title: String(errorResponse.error.code), message: errorResponse.error.message)
                case .failure(let error):
                    DialogManager.dialog(title: error.localizedDescription, message: error.localizedDescription)
                }
            }

    }
    
    ///ボタン活性状態チック
    private func updateConfirmButtonEnable() {
        let enabled = !self.inputTextRelay.value.isBlank
        self.enableConfirmButtonRelay.accept(enabled)
    }
        
}


extension TranslateListViewModel: TranslateListViewDataSource {
    
    func numberOfItems() -> Int {
        self.translateDataRelay.value.count
    }
    
    func translateData(row: Int) -> TranslateResponse {
        self.translateDataRelay.value[row]
    }
    
    func onUpdateTranslateData() -> Driver<[TranslateResponse]> {
        return self.translateData
    }
    
}
