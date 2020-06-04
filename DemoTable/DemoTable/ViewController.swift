//
//  ViewController.swift
//  DemoTable
//
//  Created by Vinita Nair on 03/04/20.
//  Copyright © 2020 GLS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtFieldNo: UITextField!
    @IBOutlet weak var txtFieldName: UITextField!
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func actionSave(sender: AnyObject)
    {
        let no = txtFieldNo.text
        let name = txtFieldName.text
        
        //set values to NSObject Student
        let stu = Student()
        stu.no = Int(no!)
        stu.name = name
        appDelegate.arrStudents.append(stu)
        
        txtFieldNo.text = ""
        txtFieldName.text = ""
        
        txtFieldNo.becomeFirstResponder() // to bring focus on txtFieldNo
        let alert = UIAlertController(title: "Alert", message: "Data Saved Successfully", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

