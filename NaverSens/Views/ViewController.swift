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
        
    }
    
    @IBAction func requestAuth(_ sender: UIButton) {
        
    }
}
