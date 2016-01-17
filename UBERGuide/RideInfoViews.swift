import Foundation
import UIKit

class RideInfoMessage: UITableViewCell {
    static let margin: CGFloat = 6
    static let width: CGFloat = UIScreen.mainScreen().bounds.width * 0.7 - 16
    
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
    
    static let width: CGFloat = UIScreen.mainScreen().bounds.width * 0.7
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        container.backgroundColor = UIColor.whiteColor()
        container.clipsToBounds = true
        container.layer.cornerRadius = 6
        container.layer.borderWidth = 1 / UIScreen.mainScreen().scale
        container.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        widthConstraint.constant = RideInfoLocation.width
    }
}

class LocationDetail: UIView {
    static let height: CGFloat = 400
    
    var title: UILabel!
    var icon: UIImageView!
    var detail: UILabel!
    var continueButton: UIButton!
    var cancelButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        let border = UIView()
        border.backgroundColor = UIColor.lightGrayColor()
        border.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(border)
        
        border.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        border.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true
        border.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        border.heightAnchor.constraintEqualToConstant(1 / UIScreen.mainScreen().scale).active = true
        
        title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle2)
        title.textAlignment = .Center
        
        addSubview(title)
        
        title.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        title.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        title.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true
        title.heightAnchor.constraintEqualToConstant(80).active = true
        
        icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(icon)
        
        icon.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        icon.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true
        icon.topAnchor.constraintEqualToAnchor(title.bottomAnchor).active = true
        icon.heightAnchor.constraintEqualToConstant(160).active = true
        
        detail = UILabel()
        detail.numberOfLines = 0
        detail.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(detail)
        
        detail.leftAnchor.constraintEqualToAnchor(leftAnchor, constant: 20).active = true
        detail.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: 20).active = true
        detail.topAnchor.constraintEqualToAnchor(icon.bottomAnchor).active = true
        detail.heightAnchor.constraintEqualToConstant(100).active = true
        
        continueButton = UIButton()
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.backgroundColor = UIColor.greenColor()
        continueButton.setTitle("Continue Explore", forState: .Normal)
        continueButton.titleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        addSubview(continueButton)
        
        continueButton.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        continueButton.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        continueButton.heightAnchor.constraintEqualToConstant(60).active = true
        continueButton.widthAnchor.constraintEqualToConstant(UIScreen.mainScreen().bounds.width / 2).active = true
        
        cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.backgroundColor = UIColor(red:0.29, green:0.73, blue:0.89, alpha:1)
        cancelButton.setTitle("Get Off", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        addSubview(cancelButton)
        
        cancelButton.leftAnchor.constraintEqualToAnchor(continueButton.rightAnchor).active = true
        cancelButton.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        cancelButton.heightAnchor.constraintEqualToConstant(60).active = true
        cancelButton.widthAnchor.constraintEqualToConstant(UIScreen.mainScreen().bounds.width / 2).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
