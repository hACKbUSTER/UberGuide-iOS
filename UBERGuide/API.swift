import Foundation
import Alamofire

class API {
    func tags(city city: String, completionHandler: [Tag] -> Void) {
        let parameters: [NSObject: AnyObject] = [:]
        
        AVCloud.callFunctionInBackground("city::tag::get", withParameters: parameters) { object, error in
            if let object = object {
                print(object)
            }
            if let error = error {
                print(error)
            }
            completionHandler([])
        }
    }
}
