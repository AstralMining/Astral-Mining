import UIKit

typealias JSONObject = [String: String]

class SignUpMaker {
    let baseUrl: NSURL
    
    init (url: NSURL) {
        baseUrl = url
    }
    
    func signUp(loginName: String, displayName: String, password: String) {
        let jsonObject = mkSignUpRecord(loginName, displayName: displayName, password: password)
        let request = mkPostRequest(jsonObject, url: "user")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            data, response, error in
            
            let resp = response as NSHTTPURLResponse
            println("Response code: \(resp.statusCode)")
            
            if error == nil {
                
                let jsonReply = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("reply: \(jsonReply)")
            } else {
                println("Error: \(error)")
            }
        }
        task.resume()
    }
    
    private func mkSignUpRecord(loginName: String, displayName: String, password: String) -> JSONObject {
        var obj = Dictionary<String, String>()
        
        obj["loginName"] = loginName
        obj["displayName"] = displayName
        obj["password"] = password
        
        return obj
    }
    
    private func mkPostRequest(jsonObject: JSONObject, url: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: NSURL(string: url, relativeToURL: baseUrl)!)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(
            jsonObject, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        
        return request
    }
}
