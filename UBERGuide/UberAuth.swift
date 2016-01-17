import Foundation
import p2_OAuth2

@objc class UberAuth: NSObject {
    static let sharedInstance = UberAuth()
    
    var oauth2: OAuth2?
    
    var token: String? {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.stringForKey("uber_token")
    }
    
    func save(token token: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(token, forKey: "uber_token")
    }
    
    var request_id: String? {
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.objectForKey("request_id") == nil {
            return " "
        } else {
            return defaults.stringForKey("request_id")
        }
    }
    
    func saveRequestId(request_id request_id: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(request_id, forKey: "request_id")
    }
    
    func authenticate(completionHandler: Void -> Void) {
        print("authenticate")
        
        if let _ = token {
            return completionHandler()
        }
        
        let settings = [
            "client_id": Constants.uberClientId,
            "client_secret": Constants.uberClientSecret,
            "authorize_uri": "https://login.uber.com.cn/oauth/v2/authorize",
            "token_uri": "https://login.uber.com.cn/oauth/token",
            "redirect_uris": ["UBERGuide://oauth/callback"],
            "scope": "request",
        ] as OAuth2JSON
        
        oauth2 = OAuth2CodeGrant(settings: settings)
        oauth2!.verbose = true
        oauth2!.forgetTokens()
        oauth2!.onAuthorize = { parameters in
            print("Did authorize with parameters: \(parameters)")
            let token = parameters["access_token"] as! String
            self.save(token: token)
            API().postToken(token: token)
            completionHandler()
        }
        oauth2!.onFailure = { error in
            if let error = error {
                print("Authorization went wrong: \(error)")
            }
        }
        oauth2!.authorize()
    }
}
