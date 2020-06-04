//
//  ViewController.swift
//  DatabaseConnectivity
//
//  Created by Vinita Nair on 27/04/20.
//  Copyright © 2020 Vinita Nair. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell")!
        var label: UILabel
        label = cell.viewWithTag(1) as! UILabel // Name label
        label.text = students[indexPath.row].name
        
        label = cell.viewWithTag(2) as! UILabel // Batch label
        label.text = students[indexPath.row].batch
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tfName.text = students[indexPath.row].name
        tfBatch.text = students[indexPath.row].batch
        tfSemester.text = students[indexPath.row].semester
        
        selectedStudent = indexPath.row
        
        btnUpdate.isEnabled = true
        btnDelete.isEnabled = true
        
    }

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfBatch: UITextField!
    @IBOutlet weak var tfSemester: UITextField!
    
    @IBOutlet weak var btnInsert: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var studentsTableView: UITableView!
    
    private var students = [StudentModel]()
    private var selectedStudent: Int?
    private var dbView = DatabaseView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dbView.createDB()
        
        students = dbView.GetStudentsData()
        
        btnUpdate.isEnabled = false
        btnDelete.isEnabled = false
        
    }
    
    func clearTextFieldData(){
        tfName.text = ""
        tfBatch.text = ""
        tfSemester.text = ""
        
        btnUpdate.isEnabled = false
        btnDelete.isEnabled = false
    }
    
    @IBAction func insertButtonClicked() {
        let name = tfName.text ?? ""
        let batch = tfBatch.text ?? ""
        let semester = tfSemester.text ?? ""
        
        let student = StudentModel(id: 0, name: name, batch: batch, sem: semester)
        let result = dbView.insertData(model: student)
        if(result){
            students.append(student)
            studentsTableView.insertRows(at: [NSIndexPath(row: students.count-1, section: 0) as IndexPath], with: .fade)
            
           clearTextFieldData()
        }
    }
    @IBAction func updateButtonClicked() {
        if selectedStudent != nil {
            let id = students[selectedStudent ?? 0].id!
            let student = StudentModel(
                id: id,
                name: tfName.text ?? "",
                batch: tfBatch.text ?? "",
                sem: tfSemester.text ?? "")
            
            students.remove(at: selectedStudent!)
            students.insert(student, at: selectedStudent!)
            let result = dbView.UpdateData(model: student)
            if(result){
                studentsTableView.reloadData()
                clearTextFieldData()
            }
            
        } else {
            print("No item selected")
        }
    }
    @IBAction func deleteButtonClicked() {
        
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete this student ?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            print("Handle YES logic here")
            
            if self.selectedStudent!>=0 && self.selectedStudent!<self.students.count {
                
                let student = self.students[self.selectedStudent!]
                let result = self.dbView.DeleteFromID(ID: student.id)
                
                if(result){
                    self.students.remove(at: self.selectedStudent!)
                    self.studentsTableView.deleteRows(at: [NSIndexPath(row: self.selectedStudent ?? 0, section: 0) as IndexPath], with: .fade)
                    
                    self.clearTextFieldData()
                }
                
            } else {
                print("No student selected")
            }
        }))

        alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            print("Handle NO logic here")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }


}

