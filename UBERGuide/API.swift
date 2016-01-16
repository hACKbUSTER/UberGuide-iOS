import Foundation
import Alamofire

class API {
    func tags(city city: String, completionHandler: [Tag] -> Void) {
        let parameters: [NSObject: AnyObject] = [:]
        
        AVCloud.callFunctionInBackground("city::tag::get", withParameters: parameters) { object, error in
            print(error)
            completionHandler([])
        }
    }
}
