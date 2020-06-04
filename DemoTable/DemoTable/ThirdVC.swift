//
//  ThirdVC.swift
//  DemoTable
//
//  Created by Vinita Nair on 03/04/20.
//  Copyright © 2020 GLS. All rights reserved.
//  To Update the Cell on which User Clicks

import UIKit

class ThirdVC: UIViewController {
    @IBOutlet weak var txtFieldName: UITextField!

    @IBOutlet weak var txtFieldNo: UITextField!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()


        txtFieldNo.text = String(appDelegate.arrStudents[appDelegate.selectedStuIndex].no)
        txtFieldName.text = appDelegate.arrStudents[appDelegate.selectedStuIndex].name
        
    }
    @IBAction func actionUpdate(sender: AnyObject)
    {
        appDelegate.arrStudents[appDelegate.selectedStuIndex].no = Int(txtFieldNo.text!)

        appDelegate.arrStudents[appDelegate.selectedStuIndex].name = txtFieldName.text!
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
