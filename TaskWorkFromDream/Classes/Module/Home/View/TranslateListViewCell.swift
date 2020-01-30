import UIKit

class TranslateListViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var translateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data:TranslateResponse) {
        self.translateLabel.text = "\(data.converted)"
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}
