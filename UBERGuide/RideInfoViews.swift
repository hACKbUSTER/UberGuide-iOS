import Foundation
import UIKit

class RideInfoMessage: UITableViewCell {
    static let margin: CGFloat = 6
    static let width: CGFloat = UIScreen.mainScreen().bounds.width * 0.7
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var textBox: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .None
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        textBox.numberOfLines = 0
        
        container.backgroundColor = UIColor.whiteColor()
        container.layer.cornerRadius = 6
        container.layer.borderWidth = 1 / UIScreen.mainScreen().scale
        container.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        widthConstraint.constant = RideInfoMessage.width
    }
    
    static func textHeight(text text: String) -> CGFloat {
        return text.heightWithConstrainedWidth(RideInfoMessage.width - 16, font: UIFont.preferredFontForTextStyle(UIFontTextStyleBody))
    }
}

class RideInfoProgress: UITableViewCell {    
    @IBOutlet weak var container: UIView!
    var loading: circleLoadingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        container.backgroundColor = UIColor.whiteColor()
        container.layer.cornerRadius = 6
        container.layer.borderWidth = 1 / UIScreen.mainScreen().scale
        container.layer.borderColor = UIColor.lightGrayColor().CGColor

        loading = circleLoadingView(frame: CGRect(x: 10, y: 13, width: 80, height: 16))
        loading.animate()
        
        container.addSubview(loading)
    }
}

class RideInfoLocation: UITableViewCell {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        container.backgroundColor = UIColor.whiteColor()
        container.clipsToBounds = true
        container.layer.cornerRadius = 6
        container.layer.borderWidth = 1 / UIScreen.mainScreen().scale
        container.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        widthConstraint.constant = RideInfoMessage.width
    }
}
