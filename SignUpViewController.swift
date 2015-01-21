import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var loginNameField: UITextField!
    @IBOutlet weak var displayNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var loginName = ""
    var displayName = ""
    var password = ""
    
    enum FieldTag: Int {
        case LoginName = 1000
        case DisplayName = 1001
        case Password = 1002
    }
    
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
        let signUpMaker = SignUpMaker(url: NSURL(string: "http://192.168.1.65:8888")!)
        signUpMaker.signUp(loginName, displayName: displayName, password: password)
        
        dismissViewControllerAnimated(true, completion: nil)
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
