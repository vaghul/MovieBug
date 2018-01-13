//
//  BaseViewController.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 12/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func showAlert(title:String,message:String){
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
		alert.addAction(action)
		self.present(alert, animated: true, completion: nil)
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
