//
//  HomeViewController.swift
//  The Movies DB
//
//  Created by Mohamed Salah on 11/3/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var peoplTableView: UITableView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorLable: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchText.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func refreshDidClicked(_ sender: UIBarButtonItem) {
        
        // Reload populer actors
        
    }
    
    

}


extension HomeViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // Fire seach request
        
        return true
    }
    
}
