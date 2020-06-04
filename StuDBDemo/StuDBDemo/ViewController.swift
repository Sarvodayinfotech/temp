//
//  ViewController.swift
//  StuDBDemo
//
//  Created by Vinita Nair on 04/04/20.
//  Copyright © 2020 GLS. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldID: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func actionViewFromDB(sender: AnyObject){
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDel.managedObjectContext
        
        var studentsArr = [NSManagedObject]()
        
        //2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        
        //3
        do {
            
            studentsArr = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            print("---Count-----")
            print(studentsArr.count)
            print("----------")
            
            for i in 0...studentsArr.count-1 {
                print(studentsArr[i].value(forKey: "name")!)
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    @IBAction func actionSaveToDB(sender: AnyObject)
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDel.managedObjectContext


        //2
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)
        //3
        
        let stuObj = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        stuObj.setValue(txtFieldName.text!, forKey: "name")
        stuObj.setValue(txtFieldID.text!, forKey: "id")
        
        do{
            try managedContext.save()
            
            txtFieldID.text = ""
            txtFieldName.text = ""
            
            txtFieldID.becomeFirstResponder()
            
            let alert = UIAlertController(title: "Alert", message: "Data Saved in DB Successfully", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        catch let err as NSError{
            print("err:\(err)")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

