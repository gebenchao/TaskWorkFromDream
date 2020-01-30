import UIKit
import RxCocoa
import RxSwift

class TranslateListViewController: UIViewController {
    
    @IBOutlet weak var translateListView: TranslateListView!
    @IBOutlet weak var inputBackView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var inputSearchText: PlaceHolderedTextView!
    @IBOutlet weak var buttonBackView: UIView!
    
    /// dispose bag
    private var disposeBag = DisposeBag()
    
    /// TranslateListViewModel
    lazy var viewModel: TranslateListViewModel = {
          let viewModel = TranslateListViewModel()
          return viewModel
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        self.inputSearchText.delegate = self
        self.initNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.setHorizontalGradientColor(colors: [UIColor.bigAleBottom, UIColor.bigAleTop])
        self.buttonBackView.layer.cornerRadius = buttonBackView.frame.height / 2.0
    }
    

    /// initialize
    private func initialize() {
        self.initBinding()
    }
    
    /// viewWillAppear
    ///
    /// - Parameter animated: animated description
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    /// initBinding
    private func initBinding() {
        
        self.translateListView.set(dataSource: self.viewModel, delegate: self)

        self.viewModel.enableConfirmButton.drive(onNext:{ [weak self] isEnable in
            self?.searchButton.isEnabled = isEnable
            if isEnable {
                self?.searchButton.setTitleColor(.baseLightWhite, for: .normal)
            } else {
                self?.searchButton.setTitleColor(.baseLightWhite26, for: .normal)
            }
        }).disposed(by: self.disposeBag)
        
        self.viewModel.updateState.drive(onNext: { [unowned self] (enabled) in
            if enabled {
                self.viewModel.initData()
            }

        }).disposed(by: self.disposeBag)
    }
    
    
    @IBAction func sendButtonAction(_ sender: Any) {
        self.viewModel.sendSearchRequest()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputSearchText.resignFirstResponder()
        
    }
    
}


extension TranslateListViewController: UITextViewDelegate {
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
         textView.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let resultText: String = (textView.text! as NSString).replacingCharacters(in: range, with: text)
        self.viewModel.inputText(text: resultText)
        return true
    }

}

 
extension TranslateListViewController :TranslateListViewDelegate {
    
    ///Todo
    func didSelect(row: Int) {}
    
    func refreshData() {
        self.viewModel.initData()
    }

}

