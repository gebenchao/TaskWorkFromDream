import UIKit
import RxCocoa
import RxSwift

class TranslateListView: UIView {

    @IBOutlet weak var tableView: UITableView!
    /// データソース
    private var dataSource:TranslateListViewDataSource!

    /// デリゲート
    private var delegate:TranslateListViewDelegate!

    /// RxのdisposeBag
    private var disposeBag = DisposeBag()

    /// リフレッシュ
    private var refreshControl:UIRefreshControl!

    /// イニシャライザ
    ///
    /// - Parameter frame: frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        commonInitialize()
    }

    /// イニシャライザ
    ///
    /// - Parameter aDecoder: aDecoder
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
        commonInitialize()
    }

    /// イニシャライザ共通処理
    private func commonInitialize() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = UIColor.baseLightWhite
        self.refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [unowned self] _ in
                self.refreshControl.endRefreshing()
                self.delegate.refreshData()
            })
            .disposed(by: self.disposeBag)

        self.tableView.register(UINib.init(nibName: TranslateListViewCell.className, bundle: nil),
                                forCellReuseIdentifier: TranslateListViewCell.className)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.refreshControl = self.refreshControl
    }

    /// データソース、デリゲートのセット
    ///
    /// - Parameter dataSource: データソース
    /// - Parameter dataSource: データソース
    func set(dataSource:TranslateListViewDataSource,
             delegate:TranslateListViewDelegate) {
        self.dataSource = dataSource
        self.delegate = delegate
        self.tableView.reloadData()

        dataSource.onUpdateTranslateData()
            .drive(onNext: {[weak self] (data:[TranslateResponse]) in
                self?.tableView.reloadData()
            })
            .disposed(by: self.disposeBag)
    }
    
}


/// TableViewのデータソース
extension TranslateListView: UITableViewDataSource {

    /// セクション数
    ///
    /// - Parameter tableView: tableView description
    /// - Returns: return value description
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /// セル数
    ///
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - section: section description
    /// - Returns: return value description
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = self.dataSource else { return 0 }
        return self.dataSource.numberOfItems()
    }

    /// セル描画
    ///
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - indexPath: indexPath description
    /// - Returns: return value description
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TranslateListViewCell = tableView.dequeueReusableCell(withIdentifier: TranslateListViewCell.className, for: indexPath) as! TranslateListViewCell
        let data = self.dataSource.translateData(row: indexPath.row)
        cell.setData(data: data)
        return cell
    }
    
}


/// Table view delegate
extension TranslateListView: UITableViewDelegate {
    /// セル選択
    ///
    /// - Parameters:
    ///   - tableView: tableView description
    ///   - indexPath: indexPath description
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate.didSelect(row: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}


/// TranslateListViewDataSource protocol
protocol TranslateListViewDataSource: class {
    /// 要素数
    ///
    /// - Returns: 要素数
    func numberOfItems() -> Int
    /// セル描画時に使う
    ///
    /// - Parameter row: インデックス
    /// - Returns: お題データ
    func translateData(row:Int) -> TranslateResponse
    /// 更新通知取得
    func onUpdateTranslateData()-> Driver<[TranslateResponse]>

}


protocol TranslateListViewDelegate: class {
    /// セルの選択
    ///
    /// - Parameter row: row description
    func didSelect(row:Int)
    /// リフレッシュ更新処理
    func refreshData()
}
