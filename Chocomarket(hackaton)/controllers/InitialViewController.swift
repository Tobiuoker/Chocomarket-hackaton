//
//  InitialViewController.swift
//  Chocomarket(hackaton)
//
//  Created by Khaled on 02.05.2020.
//  Copyright © 2020 Khaled. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Bubbles.png")!)
        signUpButton.layer.cornerRadius = 30
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
