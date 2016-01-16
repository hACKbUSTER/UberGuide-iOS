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
    
    func updateState(state state: String) {
        let parameters: [NSObject: AnyObject] = [
            "request_id": UberAuth.sharedInstance.request_id!,
            "state": state
        ]
        
        AVCloud.callFunctionInBackground("uber::updateState", withParameters: parameters) { object, error in
            if let object = object {
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
    
    func requestCurrent() {
        let parameters: [NSObject: AnyObject] = [
            "request_id": UberAuth.sharedInstance.request_id!
        ]
        
        AVCloud.callFunctionInBackground("uber::current_trip", withParameters: parameters) { object, error in
            if let object = object {
                print(object)
            }
            
            if let error = error {
                print(error)
            }
        }
    }

}
