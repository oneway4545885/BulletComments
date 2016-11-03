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
       // var array = [50,31,44,60,32,20,90,10,70,50,31]
//
//    print(threeSum([-1,0,1,2,-1]))
//        
//    mainView.layer.cornerRadius = 5
//    mainView.layer.shadowOffset = CGSizeMake(5, 5)
//    mainView.layer.shadowOpacity = 0.9
//    mainView.layer.shadowRadius = 5
//    mainView.layer.shadowColor = UIColor(red: 183/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1).CGColor
//    mainView.layer.borderColor = UIColor.blackColor().CGColor
//    mainView.layer.borderWidth = 1
        
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
    
    
    
    
    
    
    
    
//MARK : Bubble Sort
    func bubbleSort(_ array:NSArray)->NSArray{
        
        let sortArry = NSMutableArray.init(array: array)
        
        for i in 0..<sortArry.count-1{
            for j in 0..<sortArry.count-1-i{
                let x = sortArry[j] as!Int
                let y = sortArry[j+1] as!Int
                if x  < y  {
                    sortArry.replaceObject(at: j, with:y)
                    sortArry.replaceObject(at: j+1, with:x)
                }
            }
        }
        return NSArray.init(array: sortArry)
    }
//MARK : Cocktail Sort
    func cocktailSort(_ array:NSArray)->NSArray{
        let sortArry = NSMutableArray.init(array: array)
        var left = 0
        var right = sortArry.count-1
        
        while(left<right){
            
            for i in 0..<right{
                let x = sortArry[i] as!Int
                let y = sortArry[i+1] as!Int
                if(x<y){
                    sortArry.replaceObject(at: i, with:y)
                    sortArry.replaceObject(at: i+1, with:x)
                }
            }
            right -= 1
            
            for j in left+1...right{
                let x = sortArry[j-1] as!Int
                let y = sortArry[j] as!Int
                if(x<y){
                    sortArry.replaceObject(at: j-1, with:y)
                    sortArry.replaceObject(at: j, with:x)
                }
            }
            left += 1
        }
        
        return NSArray.init(array: sortArry)
        
    }
// MARK: Roman -> Int
    func romanToInt(_ s: String) -> Int {
        let arry = NSMutableArray()
        
        for i in 0..<s.characters.count{
            
           let nsString = NSString(string:s)
           let string =
            nsString.substring(with: NSRange(location: i, length: 1))
            
            arry.add(romanNumber(string))
        }
        
        var sum = Int(arry.lastObject as!NSNumber)
        
        for j in 0..<arry.count-1 {
            let x = Int(arry[j] as!NSNumber)
            let y = Int(arry[j+1] as!NSNumber)
            
            if(x<y){
                sum = sum+(-x)
            }else{
                sum = sum+(x)
            }
            
        }
        return sum
    }
    func romanNumber(_ string:String)->NSNumber{
        switch string {
        case "I":
            return 1
        case "V":
            return 5
        case "X":
            return 10
        case "L":
            return 50
        case "C":
            return 100
        case "D":
            return 500
        case "M":
            return 1000
        default:
            return 0
        }
    }
// MARK: Int -> Roman
    func intToRoman(_ num: Int) -> String {
        let string = String(num)
        let numString = NSString(string:string)
        var sum:String = ""
        for i in (0..<string.characters.count).reversed(){
            
            let value =
                numString.substring(with: NSRange(location: (string.characters.count-1)-i, length: 1))
            let str = getRomanNumber(value, index:i)
            sum = sum + str
        }
        return sum
    }
        
    func getRomanNumber(_ value:String , index:Int) -> String {
        
        let thousands = ["M","MM","MMM"]
        let hundreds = ["C","CC","CCC","CD","D","DC","DCC","DCCC","CM"]
        let tens = ["X","XX","XXX","XL","L","LX","LXX","LXXX","XC"]
        let ones = ["I","II","III","IV","V","VI","VII","VIII","IX"]
        if(value != "0"){
        switch index {
        case 0:
            
            return ones[Int(value)!-1] 
        case 1:
            return tens[Int(value)!-1] 
        case 2:
            return hundreds[Int(value)!-1]
        case 3:
            let num = Int(value)!
            return thousands[num-1]
        default:
            return ""
        }
        
        }
        return ""
    }
//MARK:lengthOfLongestSubstring - Not yet
    func lengthOfLongestSubstring(_ s: String) -> Int {
       let arry  = NSMutableArray()
       let counts = NSMutableArray()

        for char in s.characters {
           let sChar = String(char)
           let nsChar = NSString(string:sChar)
            arry .add(nsChar)
        }
        
        for i in 0..<arry.count{
            let temp = NSMutableArray()
            for j in i..<arry.count{
                
                if(j == i){
                    temp.add(arry[j])
                }else{
                    var bo = true
                    for text in temp {
                        let x = text as! NSString
                        let y = arry[j] as! NSString
                        if x == y {
                          bo = false
                          break
                        }
                    }
                    if(bo == true){
                       temp.add(arry[j])
                    }
                }
            }
            counts.add(temp.count)
        }
        
        

        for i in stride(from: 0,to:counts.count-1, by: 1){
            for j in stride(from: (i+1),to:counts.count, by:1){
                let x = counts[i]as!NSNumber
                let y = counts[j]as!NSNumber
                if Int(x) > Int(y){
                    let temp = counts[i]as!NSNumber
                    counts.replaceObject(at: i, with: counts[j])
                    counts.replaceObject(at: j, with: temp)
                }
            }
        }
        
        
      return Int(counts.lastObject as!NSNumber)
}
    
//MARK:reverse
    func reverse(_ x: Int) -> Int {
        let xString = String(x)
        let arry = NSMutableArray()
        for char in xString.characters {
            let xNSChar = NSString(string:String(char))
            arry.add(xNSChar)
        }
        
        if(x>=0&&xString.characters.count>=2){
            var result:String = ""
            for i in (0..<arry.count).reversed(){
             result = result + (arry[i] as! String)
            }
            return Int(result as String)!
        }else if(x<=0&&xString.characters.count>=2){
            var result:NSString = "-"
            for i in (1..<arry.count).reversed(){
                result = String(format:"%@%@",result,arry[i]as!NSString) as NSString
            }
            return Int(result as String)!
        }
        return x
    }
//MARK:three Sum
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let result = NSMutableArray()
        for i in 0..<nums.count-2 {
            for j in (1+i)..<nums.count-1{
                for k in (1+j)..<nums.count{
                    let a = nums[i]
                    let b = nums[j]
                    let c = nums[k]
                    if(a+b+c == 0){
                        let temp = [a,b,c]
                    if(checkArry(result, temps:temp as NSArray)){
                        result.add(temp)
                       }
                    }
                    
                }
            }
        }
        
        return NSArray.init(array: result) as! [[Int]]
    }
    
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
