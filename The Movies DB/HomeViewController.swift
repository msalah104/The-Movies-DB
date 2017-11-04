//
//  HomeViewController.swift
//  The Movies DB
//
//  Created by Mohamed Salah on 11/3/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit
import SDWebImage


protocol SearchView {
}


class HomeViewController: UIViewController {

    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var peoplTableView: UITableView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorLable: UILabel!
    
    // UI
    let CELL_ID = "cellID"
    let CELL_HEIGHT = 90.0
    
    
    // Vars
    var actors:[Actor] = [Actor]()
    var homePresenter:HomeViewActions = HomePresenter()
    var hud:YBHud?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchText.delegate = self
        self.peoplTableView.delegate = self
        self.peoplTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        // No UI
        if actors.count == 0 {
            self.peoplTableView.isHidden = true
        }
        
        homePresenter.attachView(self as HomeViewDelegate)
//        self.peoplTableView.register(UINib(nibName: "PlaceTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_ID)
        self.homePresenter.viewFirstLauch()
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
        
        // Reload popular actors
        self.homePresenter.reloadPopActors()
    }
    
    

}

extension HomeViewController : HomeViewDelegate {
    // Loading
    func startLoading() {
        if actors.count == 0 {
            hud = YBHud(hudType: .triplePulse)
            hud?.dimAmount = 0.7
            hud?.show(in: self.view, animated: true)
        }
    }
    
    func finishLoading(){
        hud?.dismiss(animated: true)
    }
    
    // Error
    func someThingWrongHappend(){
        if actors.count == 0 {
            
            self.peoplTableView.isHidden = true
            self.errorImage.image = #imageLiteral(resourceName: "error")
            self.errorLable.text = "Somthing went wrong!!"
        }
    }
    
    func noActors(){
        self.peoplTableView.isHidden = true
        self.errorImage.image = #imageLiteral(resourceName: "no result")
        self.errorLable.text = "No data found!!"
    }
    
    func error(){
        
    }
    
    
    // UpdateData
    func clearActorsList(){
        self.actors = [Actor]()
        self.peoplTableView.reloadData()
    }
    
    func readyToReciveData(){
        
    }
    
    func requestFinished(){
        
    }
    
    
    func insertActors(_ actors: [Actor]){
        
        if actors.count > 0 {
            self.peoplTableView.isHidden = false
        }
        self.actors.append(contentsOf: actors)
        self.peoplTableView.reloadData()
    }
}


extension HomeViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return actors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: CELL_ID)
        }
        
        let actor = actors[indexPath.row]
        
        cell?.textLabel?.text = actor.name
        if !actor.profilePth.isEmpty {
            cell?.imageView?.contentMode = .scaleAspectFit
            cell?.imageView?.sd_setImage(with: URL(string: MoviesDBImageApi.getIconImageOfPath(actor.profilePth)), placeholderImage: UIImage(named: "placeholder.png"))
        } else {
            cell?.imageView?.image = nil
        }
        
        return cell!
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = actors.count - 5
        if  indexPath.row == lastElement {
            self.homePresenter.lastItemWillReach()
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // Fire seach request
        homePresenter.searchForActorName(textField.text!)
        return true
    }
    
}
