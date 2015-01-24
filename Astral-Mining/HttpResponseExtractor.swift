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
        return nil
    }
}
