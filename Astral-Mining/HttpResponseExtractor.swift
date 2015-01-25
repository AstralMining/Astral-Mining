import Foundation

class HttpResponseExtractor {
    
    var response: NSHTTPURLResponse!
    
    init(response: NSHTTPURLResponse) {
        self.response = response
    }
    
    func statusCode() -> Int {
        return response.statusCode
    }
    
    func sessionCookie() -> String? {
        if let header = response.allHeaderFields["Set-Cookie"] as? NSString {
            let cookies = header.componentsSeparatedByCharactersInSet(
                NSCharacterSet(charactersInString: ";")) as [NSString]
            
            for cookie in cookies {
                let trimmedCookie = cookie.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) as NSString
                if trimmedCookie.hasPrefix("session=") {
                    return trimmedCookie as String
                }
            }
            
            return nil
        } else {
            return nil
        }
    }
}
