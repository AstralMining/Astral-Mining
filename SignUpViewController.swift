import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var usernameString = ""
    var nameString = ""
    var passwordString = ""
    
    enum FieldTag: Int {
        case Username = 1000
        case Name = 1001
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
        
        usernameField.tag = FieldTag.Username.rawValue
        nameField.tag = FieldTag.Name.rawValue
        passwordField.tag = FieldTag.Password.rawValue
        
        signUpButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        switch textField.tag {
            
        case FieldTag.Username.rawValue, FieldTag.Name.rawValue:
            textField.clearsOnBeginEditing = false
            
        case FieldTag.Password.rawValue:
            textField.clearsOnBeginEditing = false
            textField.secureTextEntry = true
            textField.textColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.5)
            
        default:
            return
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let fieldValue = textField.text as NSString
        let newFieldValue = fieldValue.stringByReplacingCharactersInRange(range, withString: string)
        
        switch textField.tag {
            
        case FieldTag.Username.rawValue:
            usernameString = newFieldValue
            
        case FieldTag.Name.rawValue:
            nameString = newFieldValue
            
        case FieldTag.Password.rawValue:
            passwordString = newFieldValue
            
        default:
            return true
        }
        return true
    }
}
