//
//  ViewController.swift
//  TradePwd
//
//  Created by LL on 2019/12/10.
//  Copyright © 2019 hxxxxs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        TradePassword.show { (event, pwd) in
            print("event: \(event)")
            print("passowrd: \(pwd)")
        }
    }


}

