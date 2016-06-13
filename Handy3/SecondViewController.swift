//
//  SecondViewController.swift
//  Handy3
//
//  Created by 宫澄光 on 6/12/16.
//  Copyright © 2016 Handy. All rights reserved.
//

import UIKit
import Alamofire
import PureJsonSerializer

class SecondViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    var seguePrompt: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTry() {
        let loginRequest: [String: AnyObject] = [
            "user": "",
            "email": emailField.text!,
            "pwd": pwdField.text!,
            "token": ""
        ]
        let domain = "http://127.0.0.1:8080/"
        let url = domain + "login"
        Alamofire.request(.POST, url, parameters: loginRequest)
            .validate()
            .responseData(completionHandler: { response in
                do {
                    let json = try Json.deserialize(response.data!)
                    self.seguePrompt = json["msg"]?.stringValue
                    self.performSegueWithIdentifier("LoginSuccessSegue", sender: self)
                } catch {}
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dstVC = segue.destinationViewController as! LoginSuccessViewController
        dstVC.labelText = seguePrompt
    }
    
    @IBAction func myUnwindFunction(unwindSegue: UIStoryboardSegue) {
    }


}

