//
//  ViewController.swift
//  TestSwiftUI
//
//  Created by nguyen tuan dang on 11/13/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ContentViewMac())
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
