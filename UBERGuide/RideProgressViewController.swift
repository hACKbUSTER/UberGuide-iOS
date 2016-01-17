import Foundation
import UIKit

class RideProgressViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var tableViewController: UITableViewController!
    var ride: [RideInfo] = []
    var rideIndex = 0
    var cancelButton: UIButton!
    var locationDetail: LocationDetail!
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Uber Guide"
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = false
        let ARButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: self, action: "presentARVC")
        self.navigationItem.rightBarButtonItem = ARButton
        
        tableViewController = UITableViewController(style: .Grouped)
        tableViewController.view.backgroundColor = UIColor(red:0.95, green:0.97, blue:0.98, alpha:1.0)
        tableViewController.view.translatesAutoresizingMaskIntoConstraints = false
        tableViewController.tableView?.registerNib(UINib(nibName: "RideInfoMessage", bundle: nil), forCellReuseIdentifier: "RideInfoMessage")
        tableViewController.tableView?.registerNib(UINib(nibName: "RideInfoProgress", bundle: nil), forCellReuseIdentifier: "RideInfoProgress")
        tableViewController.tableView?.registerNib(UINib(nibName: "RideInfoLocation", bundle: nil), forCellReuseIdentifier: "RideInfoLocation")
        
        tableViewController.tableView?.delegate = self
        tableViewController.tableView?.dataSource = self
        tableViewController.tableView?.separatorStyle = .None
        
        view.addSubview(tableViewController.view)
        addChildViewController(tableViewController)
        
        tableViewController.view.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        tableViewController.view.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        tableViewController.view.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -60).active = true
        tableViewController.view.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        
        cancelButton = UIButton()
        cancelButton.addTarget(self, action: "cancel", forControlEvents: .TouchUpInside)
        cancelButton.setTitle("Cancel Ride", forState: .Normal)
        cancelButton.backgroundColor = UIColor(red:0.29, green:0.73, blue:0.89, alpha:1)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cancelButton)
        
        cancelButton.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        cancelButton.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        cancelButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        cancelButton.heightAnchor.constraintEqualToConstant(60).active = true

        refresh()
        
        tableViewController.tableView.reloadData()
        
        timer = NSTimer(timeInterval: 2, target: self, selector: "refresh", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false;
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func cancel() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func presentFinalDestination() {
        let screenWidth = UIScreen.mainScreen().bounds.width
        
        let dim = UIView()
        dim.translatesAutoresizingMaskIntoConstraints = false
        dim.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.30)
        
        self.view.addSubview(dim)
        
        dim.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        dim.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        dim.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        dim.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        
        let info = ride.last!
        
        locationDetail = LocationDetail()
        locationDetail.title.text = info.detailTitle
        locationDetail.icon.af_setImageWithURL(info.icon!)
        locationDetail.detail.text = info.description
        locationDetail.continueButton.addTarget(self, action: "cancel", forControlEvents: .TouchUpInside)
        locationDetail.cancelButton.addTarget(self, action: "cancel", forControlEvents: .TouchUpInside)
        self.locationDetail.frame = CGRectMake(0, self.view.frame.size.height, screenWidth, LocationDetail.height)
        
        UIView.animateWithDuration(0.30, delay: 0, options: .CurveEaseInOut, animations: {
            self.locationDetail.frame = CGRectMake(0, self.view.frame.size.height - LocationDetail.height, screenWidth, LocationDetail.height)
            }, completion: nil)
        self.view.addSubview(locationDetail)
    }
    
    //this method presents ARViewController
    func presentARVC()
    {
        let ARVC = ARViewController()
        self .presentViewController(ARVC, animated: true, completion: nil)
    }
    
    func refresh() {
        API().rideInfo(index: rideIndex) {
            if self.rideIndex == 4 {
                self.timer.invalidate()
                self.presentFinalDestination()
                return
            }
            
            if $0.count > 0 {
                
                self.ride.appendContentsOf($0)
                self.tableViewController.tableView.reloadData()
                
                self.rideIndex += 1
                
                self.scrollToBottom()
            }
        }
    }
    
    func scrollToBottom() {
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            let numberOfSections = self.tableViewController?.tableView.numberOfSections
            if numberOfSections > 0 {
                let numberOfRows = self.tableViewController?.tableView.numberOfRowsInSection(numberOfSections!-1)
                
                if numberOfRows > 0 {
                    let indexPath = NSIndexPath(forRow: numberOfRows!-1, inSection: (numberOfSections!-1))
                    self.tableViewController?.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
                }
            }
        })
    }
}

extension RideProgressViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == ride.count {
            return 16
        }
        
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == ride.count {
            return RideInfoMessage.textHeight(text: " ") + 16
        }
        
        let info = ride[indexPath.section]
        
        if info.type == "message" {
            return RideInfoMessage.textHeight(text: info.message!) + 16
        }
        
        return 165
    }
}

extension RideProgressViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ride.count + 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == ride.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("RideInfoProgress") as! RideInfoProgress
            cell.loading.animate()
            return cell
        }
        
        let info = ride[indexPath.section]
        
        if info.type == "message" {
            let cell = tableView.dequeueReusableCellWithIdentifier("RideInfoMessage") as! RideInfoMessage
            cell.textBox.text = info.message
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("RideInfoLocation") as! RideInfoLocation
        print(info.icon)
        if let icon = info.icon {
            cell.icon.af_setImageWithURL(icon)
        }
        if let title = info.title {
            cell.summary.text = title
        }
        
        if let summary = info.summary {
            cell.location.text = summary
        }
        
        return cell
    }
}

class LocationDetailViewController: UIViewController {
    var locationDetail: LocationDetail!
    
    override func viewDidLoad() {
        locationDetail = LocationDetail(frame: CGRect())
        locationDetail.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(locationDetail)
        
        locationDetail.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        locationDetail.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        locationDetail.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        locationDetail.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
    }
}
