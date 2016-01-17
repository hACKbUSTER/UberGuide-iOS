import Foundation
import Alamofire

@objc class API:NSObject {
    func tags(city city: String, completionHandler: [Tag] -> Void) {
        let parameters: [NSObject: AnyObject] = [:]
        
        AVCloud.callFunctionInBackground("city::tag::get", withParameters: parameters) { object, error in
            if let object = object {
                let dictionary = object as! NSDictionary
                let items = dictionary.objectForKey("data") as! NSArray
                var tags: [Tag] = []
                for item in items {
                    let data = item as! NSDictionary
                    let id = data.objectForKey("objectId") as! String
                    let icon = NSURL(string: data.objectForKey("imageSrc") as! String)!
                    let text = "\(data.objectForKey("zhLabel") as! String)\n\(data.objectForKey("enLabel") as! String)"
                    tags.append(Tag(id: id, text: text, icon: icon, enLabel: data.objectForKey("enLabel") as! String))
                    if tags.count == 9 {
                        break
                    }
                }
                return completionHandler(tags)
            }
            
            if let error = error {
                print(error)
            }
            
            completionHandler([])
        }
    }
    
    func postTags(tags: [Tag]) {
        let parameters: [NSObject: AnyObject] = [
            "tags": tags.map { $0.id },
        ]
        
        AVCloud.callFunctionInBackground("city::tag::post", withParameters: parameters) { object, error in
            if let object = object {
                print(object)
            }
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func postToken(token token: String) {
        let parameters: [NSObject: AnyObject] = [
            "access_token": token,
        ]
        
        AVCloud.callFunctionInBackground("uber::access_token", withParameters: parameters) { object, error in
            if let object = object {
                print(object)
            }
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func updateState(state state: String, completionHandler: Void -> Void) {
        let parameters: [NSObject: AnyObject] = [
            "request_id": UberAuth.sharedInstance.request_id!,
            "state": state
        ]
        
        AVCloud.callFunctionInBackground("uber::updateState", withParameters: parameters) { object, error in
            if let object = object {
                completionHandler()
                print(object)
            }
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func request() {
        let parameters: [NSObject: AnyObject] = [
            "access_token": UberAuth.sharedInstance.token!
        ]
        
        AVCloud.callFunctionInBackground("uber::request", withParameters: parameters) { object, error in
            if let object = object {
                let dictionary = object as! NSDictionary
                let item = dictionary.objectForKey("data") as! NSDictionary
                UberAuth.sharedInstance.saveRequestId(request_id: item.objectForKey("request_id") as! String)
                print(object)
            }
            
            if let error = error {
                print(error)
            }
        }
    }
    
    func rideInfo(index index: Int, completionHandler: [RideInfo] -> Void) {
        let parameters: [NSObject: AnyObject] = [
            "index": index,
        ]
        
        AVCloud.callFunctionInBackground("current::get", withParameters: parameters) { object, error in
            if let object = object {
                print(object)
                
                let dictionary = object as! NSDictionary
                let items = dictionary.objectForKey("data") as! NSArray
                var ride: [RideInfo] = []
                for item in items {
                    let rawData = item as! NSDictionary
                    let type = rawData.objectForKey("type") as! String

                    
                    if type == "message" {
                        let data = rawData.objectForKey("data") as! String
                        
                        ride.append(RideInfo(type: type, message: data, icon: nil, lat: nil, lon: nil, description: nil, summary: nil, title: nil, detailTitle: nil))
                    } else {
                        let data = rawData.objectForKey("data") as! NSDictionary
                        
                        let icon = NSURL(string: data.objectForKey("imageSrc") as! String)!
                        let lon = Double(data.objectForKey("longitude") as! String)
                        let lat = Double(data.objectForKey("latitude") as! String)
                        let summary = data.objectForKey("summary") as! String
                        let description = data.objectForKey("description") as! String
                        let title = "\(data.objectForKey("zhName") as! String) \(data.objectForKey("enName") as! String)"
                        let detailTitle = "\(data.objectForKey("zhName") as! String)\n\(data.objectForKey("enName") as! String)"
                        
                        ride.append(RideInfo(type: type, message: nil, icon: icon, lat: lat, lon: lon, description: description, summary: summary, title: title, detailTitle: detailTitle))
                    }
                }
                
                return completionHandler(ride)
            }
            
            if let error = error {
                print(error)
            }
            
            return completionHandler([])
        }
    }
    
    func requestCurrent(completionHandler: AnyObject! -> Void) {
        let parameters: [NSObject: AnyObject] = [
            "request_id": UberAuth.sharedInstance.request_id!
        ]
        
        AVCloud.callFunctionInBackground("uber::current_trip", withParameters: parameters) { object, error in
            if let object = object {
                completionHandler(object)
                print(object)
            }
            
            if let error = error {
                completionHandler(nil)
                print(error)
            }
        }
    }
    
    func requestMap(completionHandler: AnyObject! -> Void) {
        let parameters: [NSObject: AnyObject] = [
            "request_id": UberAuth.sharedInstance.request_id!,
        ]
        
        AVCloud.callFunctionInBackground("uber::map", withParameters: parameters) { object, error in
            if let object = object {
                completionHandler(object)
                print(object)
            }
            
            if let error = error {
                completionHandler(nil)
                print(error)
            }
        }
    }
    
    func requestCloseSpot(completionHandler: AnyObject! -> Void) {
        let parameters: [NSObject: AnyObject] = [:]
        
        AVCloud.callFunctionInBackground("ride::closeto::get", withParameters: parameters) { object, error in
            
            if let object = object {
                completionHandler(object)
                print(object)
            }
            
            if let error = error {
                completionHandler(nil)
                print(error)
            }
        }
    }
}
