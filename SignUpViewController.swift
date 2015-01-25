import UIKit

protocol SignUpViewDelegate {
    func signUpSucceeded(record: UserRecord)
    func signUpFailedWithMessage(string: String)
}

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var loginNameField: UITextField!
    @IBOutlet weak var displayNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var loginName = ""
    var displayName = ""
    var password = ""
    
    let baseUrl = NSURL(string: "http://192.168.1.65:8888")!
    
    enum FieldTag: Int {
        case LoginName = 1000
        case DisplayName = 1001
        case Password = 1002
    }
    
    typealias JSONObject = [String:AnyObject]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginNameField.tag = FieldTag.LoginName.rawValue
        displayNameField.tag = FieldTag.DisplayName.rawValue
        passwordField.tag = FieldTag.Password.rawValue
        
        signUpButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        signUp(loginName, displayName: displayName, password: password)
    }
    
    private func signUp(loginName: String, displayName: String, password: String) {
        let jsonObject = mkSignUpRecord(loginName, displayName: displayName, password: password)
        let request = mkPostRequest(jsonObject, url: "user")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) {
            data, response, error in
            
            let resp = response as NSHTTPURLResponse
            println("Response code: \(resp.statusCode)")
            
            if error == nil {
                
                var decodeError = NSErrorPointer()
                
                let debugReply = NSString(data: data, encoding: NSUTF8StringEncoding)
                if let url = self.getUrlStringFromJSON(data, error: decodeError) {
                    println("GetUrlFromJSON: \(url)")
                } else {
                    println("JSON error: \(decodeError.debugDescription)")
                }
                
                
                
                println("reply: \(debugReply)")
            } else {
                println("Error: \(error)")
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)
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
    
    private func getUrlStringFromJSON(data: NSData, error: NSErrorPointer) -> String? {
        if let object: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: error) {
            let jsonObject = object as [String: String]
            if let url = jsonObject["url"] {
                return url
            } else {
                return nil
            }
        }
        return nil
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        let tag = FieldTag(rawValue: textField.tag)!
        switch tag {
            
        case .LoginName, .DisplayName:
            textField.clearsOnBeginEditing = false
         
        case .Password:
            textField.clearsOnBeginEditing = false
            textField.secureTextEntry = true
            
        default:
            return
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let fieldValue =
            (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        let tag = FieldTag(rawValue: textField.tag)!
        
        switch tag {
            
        case .LoginName:
            loginName = fieldValue
            
        case .DisplayName:
            displayName = fieldValue
            
        case .Password:
            password = fieldValue
            textField.textColor = passwordColor(fieldValue)
            
        default:
            return true
        }
        
        signUpButton.enabled = loginNameOk(loginName) &&
                               displayNameOk(displayName) &&
                               passwordOk(password)
        
        return true
    }
    
    func loginNameOk(id: String) -> Bool {
        return countElements(id) > 0
    }
    
    func displayNameOk(id: String) -> Bool {
        return countElements(id) > 0
    }
    
    func passwordOk(id: String) -> Bool {
        return countElements(id) > 4
    }
    
    func passwordColor(id: String) -> UIColor {
        return passwordOk(id) ? UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 0.5) :
                                UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.5)
    }
}
