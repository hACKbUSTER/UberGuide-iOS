import Foundation
import Alamofire

class API {
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
                    tags.append(Tag(id: id, text: text, icon: icon))
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
}
