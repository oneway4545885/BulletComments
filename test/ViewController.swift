//
//  ViewController.swift
//  test
//
//  Created by 王偉 on 2016/9/5.
//  Copyright © 2016年 王偉. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var mainView: UIView!

    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        nameTextField.delegate = self
  
        
        
}
    @IBAction func btn_goChat(_ sender: AnyObject) {
        
        if nameTextField.text != "" {
            
            FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
                
                if error != nil {
                    return
                }
                let vc2:ViewController2 = self.storyboard?.instantiateViewController(withIdentifier:"VC2") as! ViewController2
                vc2.userName = self.nameTextField.text
                self.present(vc2, animated:true,completion: nil)
            })
            
        }
        
        
    }
    
//UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
// hideKeyBoard
    func checkArry(_ results:NSMutableArray,temps:NSArray)->Bool{
      
        for result in results{
            
            for elemant in result as!NSArray{
                
                
                for temp in temps {
                    
                    if elemant as!Int == temp as!Int{
                        
                    }
                }
            }
        }
        return true
    }
    


}
