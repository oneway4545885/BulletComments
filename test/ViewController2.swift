//
//  ViewController2.swift
//  test
//
//  Created by 王偉 on 2016/10/28.
//  Copyright © 2016年 王偉. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import Firebase

class ViewController2: UIViewController ,UITextFieldDelegate{
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    var count:NSInteger!
    var dataArry:NSMutableArray!
    var gTimer:Timer!
    var speedWayArry:NSMutableArray!
    
    @IBOutlet weak var textField: UITextField!
    let speedWayCount:Int = 14
    let timeInterval:Double = 0.5
    let animateDuration:Double = 5
    var chatRef:FIRDatabaseReference?
    var chatRefHandle:FIRDatabaseHandle?
    var userName:String?
    @IBOutlet weak var viewChat: UIView!
    
//MARK: ViewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        screenHeight = UIScreen.main.bounds.size.height - 32
        screenWidth = UIScreen.main.bounds.size.width
        count = 0
        
        dataArry = NSMutableArray()
        speedWayArry = NSMutableArray()
        
        textField.delegate = self
        
        for i in 0..<speedWayCount{
            
            speedWayArry.add(i)
        }
        
        observeChats()
    }
//MARK:UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        

        
        self.viewChat.frame = self.viewChat.frame.offsetBy(dx: 0, dy: 0)
    
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        
       
        
        self.viewChat.frame = self.viewChat.frame.offsetBy(dx: 0, dy: -215)
        
  
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
            
            self.viewChat.frame = self.viewChat.frame.offsetBy(dx: 0, dy: 0)
        
        
    }
//MARK:FireBase
    
    func observeChats(){
        chatRef = FIRDatabase.database().reference().child("chats")
        chatRefHandle = chatRef?.observe(.childAdded, with: { (snapshot) in
            
          // let key = snapshot.key
           let value:Dictionary =
            snapshot.value as! Dictionary<String,AnyObject>
           
           let message =
            NSString.init(format:"%@:%@",value["name"]as!String
                                         ,value["message"]as!String)
 
           
            // let font = CGFloat(arc4random()%10+12)
            //self.randomLabel(text:message as String, font:font)
            self.setDataArry(text:message as String)
        })
    }
    
    func setDataArry(text:String){
        
        if text.characters.count > 0 {
            
            dataArry .add(text)
            
        }
        
        if speedWayArry.count > 0 {
            
            if dataArry.count > 0 {
                let font = CGFloat(arc4random()%10+12)
                self.randomLabel(text:dataArry.object(at: 0) as! String, font:font)
                dataArry.removeObject(at: 0)
            }
        }
    }
    
    @IBAction func btn_send(_ sender: AnyObject) {
        
        
        
        if (textField.text?.characters.count)!>0 {
                let itemRef = chatRef?.childByAutoId()
                let messageItem:NSDictionary = [
                    "name": userName!,
                    "message":textField.text!,
                    ]
        
                itemRef?.setValue(messageItem)
        }
        textField.resignFirstResponder()
        textField.text = ""
    }

    
//    func updateTime(){
//        
//        
//        if  teatArry.count > 0 {
//            let uuid = UUID().uuidString
//           // let str = teatArry[count] as? String
//            self.randomLabel(text:uuid,font: 14)
//           // count = count + 1
//          //  teatArry.removeObject(at: 0)
//            
//        }else{
//            
//            gTimer.invalidate()
//            
//        }
//    }
    
    
    
// MARK: Auto width label
    func getLabWidth(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize(width: 900, height: height)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
        
        return strSize.width
    }

// MARK: Rand Label
    func randomLabel(text:String,font:CGFloat){
        
        
        let width = self.getLabWidth(labelStr: text, font: UIFont.systemFont(ofSize: font), height: font)
        let index = self.randomYwithoutDouble()
        
        if(index >= 0){
            let Y = screenHeight/CGFloat(speedWayCount) * CGFloat(index)
            let label = UILabel(frame:CGRect(x:screenWidth,y:Y,width:width,height:font))
        
            label.text = text as String
            let color = UIColor.init(colorLiteralRed:arc4RandomColor(), green:arc4RandomColor(), blue: arc4RandomColor(), alpha:1)
            label.textColor = color
            label.font = UIFont.systemFont(ofSize: font)
            label.numberOfLines = 1
            label.sizeToFit()
            self.view .addSubview(label)
            let animate = Double(arc4random()%10+3)
            self.animation(label: label ,speedWay:index ,animate: animate)
        }else{
            
        }
    }
    
    func arc4RandomColor()->Float {
        
        let cgFloat = arc4random()%256
        
        return Float(cgFloat)/255.0
    }
// MARK: Rand Y for label
    func randomYwithoutDouble() -> Int {
        if(speedWayArry.count>0){
            let arryCount = UInt32(speedWayArry.count)
            let index = Int(arc4random()%arryCount)
            let speedWay = speedWayArry.object(at:index) as? Int
                print(speedWayArry)
                print("#\(speedWay) start running")
                speedWayArry.removeObject(at: index)
                return speedWay!
        }else{
            return -1
        }
    }
// MARK: Maquree Animation
    func animation(label:UILabel,speedWay:Int,animate:Double){
        
        
        
        UIView.animate(withDuration: animate, delay:0, options: ([.curveLinear]), animations: {() -> Void in
            
                label.center = CGPoint(x:0 - label.bounds.size.width / 2,y:label.center.y)
                
            }, completion:
            
            { _ in
                label.removeFromSuperview()
                print("#\(speedWay) stop run")
                self.speedWayArry.add(speedWay)
                self.setDataArry(text:"")
            })

    }

}