import Foundation
import UIKit
import AlamofireImage

class TagViewController: UIViewController {
    var introLabel: UILabel!
    var tagsCollectionViewController: UICollectionViewController!
    var nextButton: UIButton!
    var tags: [Tag] = []
    var selectedTags: [Tag] = []
    var api: API!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        api = API()
        
        let introLabel = UILabel()
        introLabel.textAlignment = .Center
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        introLabel.text = "Tag Your Adventures"
        introLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
        
        view.addSubview(introLabel)
        
        introLabel.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        introLabel.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        introLabel.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        introLabel.heightAnchor.constraintEqualToConstant((screenHeight - screenWidth) / 2).active = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: TagCell.margin, bottom: 0, right: TagCell.margin)
        layout.itemSize = CGSize(width: TagCell.width, height: TagCell.width)
        layout.minimumLineSpacing = TagCell.margin
        layout.minimumInteritemSpacing = TagCell.margin
        
        tagsCollectionViewController = UICollectionViewController(collectionViewLayout: layout)
        tagsCollectionViewController.collectionView?.backgroundColor = UIColor.whiteColor()
        tagsCollectionViewController.collectionView?.delegate = self
        tagsCollectionViewController.collectionView?.dataSource = self
        tagsCollectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        tagsCollectionViewController.collectionView?.registerNib(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: "TagCell")
        
        view.addSubview(tagsCollectionViewController.view)
        addChildViewController(tagsCollectionViewController)
        
        tagsCollectionViewController.view.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        tagsCollectionViewController.view.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        tagsCollectionViewController.view.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        tagsCollectionViewController.view.heightAnchor.constraintEqualToConstant(screenWidth).active = true
        
        nextButton = UIButton()
        nextButton.addTarget(self, action: "next", forControlEvents: .TouchUpInside)
        nextButton.setTitle("Remember What I Like", forState: .Normal)
        nextButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        nextButton.backgroundColor = UIColor(red:0.29, green:0.73, blue:0.89, alpha:0.65)
        nextButton.enabled = false
        nextButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nextButton)
        
        nextButton.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        nextButton.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        nextButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        nextButton.heightAnchor.constraintEqualToConstant(60).active = true
        
        api.tags(city: "PEK") { tags in
            print(tags)
            self.tags = tags
            self.tagsCollectionViewController.collectionView?.reloadData()
        }
    }
    
    // MARK: - Actions
    
    func next() {
        performSegueWithIdentifier("openLookForRide", sender: self)
        
        api.postTags(self.selectedTags)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "openLookForRide" {
            let vc = segue.destinationViewController as! LookForRideViewController
            if self.selectedTags.count > 1 {
                vc.tripTitle = "Beijing"
            } else if selectedTags.count == 1 {
                let tag = self.selectedTags[0] 
                vc.tripTitle = tag.enLabel
            }
            
            return
        }
    }
}

// MARK: - UICollectionViewDelegate

extension TagViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedTagsId = selectedTags.map { $0.id }
        let tag = tags[indexPath.row].id
        if let index = selectedTagsId.indexOf(tag) {
            selectedTags.removeAtIndex(index)
        } else {
            selectedTags.append(tags[indexPath.row])
        }
        
        nextButton.enabled = selectedTags.count > 0
        nextButton.backgroundColor = nextButton.enabled ? UIColor(red:0.29, green:0.73, blue:0.89, alpha:1) : UIColor(red:0.29, green:0.73, blue:0.89, alpha:0.65)

        tagsCollectionViewController.collectionView?.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension TagViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let tag = tags[indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TagCell", forIndexPath: indexPath) as! TagCell
        cell.icon.af_setImageWithURL(tag.icon,
            placeholderImage: nil,
            filter: nil,
            imageTransition: .None,
            runImageTransitionIfCached: false) { result in
            }
        cell.icon.contentMode = .ScaleAspectFill
        cell.text.text = tag.text
        
        if (selectedTags.map { $0.id }).contains(tag.id) {
            cell.text.backgroundColor = UIColor(red:0.29, green:0.73, blue:0.89, alpha:0.65)
        } else {
            cell.text.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.40)
        }
        
        return cell
    }
}
