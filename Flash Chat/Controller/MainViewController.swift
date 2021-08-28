//
//  ViewController.swift
//  Flash Chat
//
//  Created by Fernando González on 26/08/21.
//

import UIKit
import CLTypingLabel

class MainViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        titleLabel.text = ""
//        let titleText: String = "⚡️FlashChat"
//        var charIndex: Double = 0.0
//        for letter in titleText {
//            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { <#Timer#> in
//                self.titleLabel.text?.append(letter)
//            }
//            charIndex += 1
//        }
        
        titleLabel.text = "⚡️FlashChat"
    
    }


}

