//
//  ViewController.swift
//  NaverSens
//
//  Created by 박제형 on 9/12/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var phoneNum: UITextField!
    @IBOutlet weak var verificationNum: UITextField!
    @IBOutlet weak var countryNum: UILabel!
    @IBOutlet weak var countryName: UILabel!
    
    var code: String = ""
    
    var paramName: String = "대한민국"
    var paramCode: String = "82"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        countryName.text = paramName
        countryNum.text = "+\(paramCode)"
    }
    
    @IBAction func requestSMS(_ sender: UIButton) {
        
        code = randomCode()
        let content = "[호두] 본인 확인 인증번호 [\(code)] 입니다"
        
        if phoneNum.text?.isEmpty == true {
            print("number is empty")
            return
        } else {
            CountryService().naverSensRequest(to: phoneNum.text!, content: content, countryCode: paramCode)
        }
    
    }
    
    @IBAction func requestAuth(_ sender: UIButton) {
        
        if verificationNum.text?.isEmpty == true {
            print("number is empty")
            return
        } else {
            if verificationNum.text != code {
                print("not correct code")
                return
            }
        }
    }
    
    func randomCode() -> String {
        let code = Int.random(in: 100000...999999)
        return String(code)
    }
    
    
}
