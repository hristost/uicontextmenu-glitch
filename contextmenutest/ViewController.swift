//
//  ViewController.swift
//  contextmenutest
//
//  Created by Hristo Staykov on 26/06/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
     
    }
    
    
    @IBAction func didTapButton(sender: UIButton) {
        let tableViewController = TableViewController()
        let navigationController
            = UINavigationController(rootViewController: tableViewController)
        navigationController.modalPresentationStyle = .popover
        navigationController.popoverPresentationController?.sourceView = btn
        navigationController.popoverPresentationController?.sourceRect = btn.bounds
        
        self.present(navigationController, animated: true, completion: nil)
    }


}

