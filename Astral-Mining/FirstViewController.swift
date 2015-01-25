import UIKit

class FirstViewController: UIViewController {
    
    var userRecord: UserRecord?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        userRecord = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if userRecord == nil {
            let signUp = SignUpViewController(nibName: "SignUpViewController",
                bundle: NSBundle.mainBundle(), delegate: self)
            presentViewController(signUp, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FirstViewController: SignUpViewDelegate {
    func signUpSucceeded(record: UserRecord) {
        println("User record. Login: \(record.loginName), Display: \(record.displayName), Url: \(record.resourceUrl), Session: \(record.sessionCookie)")
        userRecord = record
    }
    
    func signUpFailedWithMessage(message: String) {
        println("Fail message: \(message)")
        userRecord = nil
    }
}

