import Foundation
import UIKit

class TagCell: UICollectionViewCell {
    static let margin: CGFloat = 6
    static let width: CGFloat = (UIScreen.mainScreen().bounds.width - 4 * TagCell.margin) / 3
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var text: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.lightGrayColor()
    }
}
