import UIKit

class SignUpMaker {
    let url: NSURL
    
    init (url: NSURL) {
        self.url = url
    }
    
    func signUp(loginName: String, displayName: String, password: String) {
        println("loginName: \(loginName), displayName: \(displayName), password: \(password)")
    }
}
