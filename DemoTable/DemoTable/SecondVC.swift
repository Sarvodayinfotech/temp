//
//  SecondVC.swift
//  DemoTable
//
//  Created by Vinita Nair on 03/04/20.
//  Copyright © 2020 GLS. All rights reserved.
//  To Load Data to TableView Listing

import UIKit

class SecondVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tblViewData: UITableView!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tblViewData.reloadData()
        super.viewWillAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return appDelegate.arrStudents.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomStuCell") as! CustomStuCell
        let singleStu = appDelegate.arrStudents[indexPath.row]
        
        cell.lblName.text = singleStu.name
        cell.lblNo.text = String(singleStu.no!)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        appDelegate.selectedStuIndex = indexPath.row
        self.performSegue(withIdentifier: "toThirdVC", sender: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        tblViewData.reloadData()
    }
}












