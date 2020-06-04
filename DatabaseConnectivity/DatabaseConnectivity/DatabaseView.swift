//
//  DatabaseView.swift
//  DatabaseConnectivity
//
//  Created by Vinita Nair on 27/04/20.
//  Copyright © 2020 Vinita Nair. All rights reserved.
//
import Foundation
import UIKit
import SQLite3

//Expense table
let TBL_STUDENTS = "Students"
let FLD_AUTO_STUDENTS_ID = "stud_Id"
let FLD_NAME = "stud_Name"
let FLD_BATCH = "stud_Batch"
let FLD_SEM = "stud_sem"


class DatabaseView: NSObject {
    
    var fileManager: FileManager?
    var databasePath: String = ""
    private var database: OpaquePointer? = nil
    private var statement: OpaquePointer? = nil
    
    override init() {
        // Searching documents directory path and appending students database file
        fileManager = FileManager.default
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsPath = paths[0]
        databasePath = URL(fileURLWithPath: docsPath).appendingPathComponent("Students").absoluteString
        print("DB Path : \(databasePath)")
    }
    
    func openDatabaseConnection() -> Bool {
        if sqlite3_open(databasePath, &database) == SQLITE_OK {
            return true
        }
        
        return false
    }
    
    func closeDatabaseConnection() {
        sqlite3_close(database)
    }
    
    func createDB() {
        if fileManager?.fileExists(atPath: databasePath) == false {
            createTable()
        } else {
            if fileManager?.fileExists(atPath: databasePath) == true {
                print("Database Already Exists.")
               // createTable()
            } else {
                print("Error : \(String(describing: sqlite3_errmsg(database)))")
                print("Database Not Created / Opened.")
            }
        }
    }
    
    func createTable() {
//        defer {
//            closeDatabaseConnection()
//        }
        do {
            if openDatabaseConnection() {
                // Expense table
                let CREATE_TABLE = "CREATE TABLE IF NOT EXISTS \(TBL_STUDENTS) (\(FLD_AUTO_STUDENTS_ID) INTEGER PRIMARY KEY AUTOINCREMENT, \(FLD_NAME) TEXT, \(FLD_BATCH) TEXT, \(FLD_SEM) TEXT)"
                print(CREATE_TABLE)
                if sqlite3_exec(database, CREATE_TABLE, nil, nil, nil) != SQLITE_OK {
                    print("CREATE_TABLE Table Error : \(String(describing: sqlite3_errmsg(database)))")
                } else {
                    print("CREATE_TABLE Table Created")
                }
            }
        }
        closeDatabaseConnection()
    }
    
    func clearDatabase() {
        if fileManager?.fileExists(atPath: databasePath) == true {
            let error: Error? = nil
            try? fileManager?.removeItem(atPath: databasePath)
            assert(error == nil, "Assertion: SQLite file deletion shall never throw an error.")
            if error == nil {
                createDB()
            }
        }
    }
    
    func insertData(model: StudentModel) -> Bool {
        var result = false
//        defer {
//            closeDatabaseConnection()
//        }
        do {
            if openDatabaseConnection() {
                var Data_stmt: String? = nil
                Data_stmt = "INSERT INTO \(TBL_STUDENTS) (\(FLD_NAME),\(FLD_BATCH),\(FLD_SEM)) VALUES (\'\(model.name)\',\'\(model.batch)\',\'\(model.semester)\')"
                print(Data_stmt as Any)
                sqlite3_prepare_v2(database, Data_stmt, -1, &statement, nil)
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("insert sucessfully")
                    result = true
                } else {
                    print("insert not sucessfully")
                    result = false
                }
                sqlite3_reset(statement)
            }
        }
        closeDatabaseConnection()
        return result
    }
    
    
    func GetStudentsData() -> [StudentModel] {
        var arr = [StudentModel]()
//        defer {
//            closeDatabaseConnection()
//        }
        do {
            if openDatabaseConnection() {
                let select_stmt = "SELECT * FROM \(TBL_STUDENTS)"
                print(select_stmt)
                if sqlite3_prepare_v2(database, select_stmt, -1, &statement, nil) == SQLITE_OK {
                    while sqlite3_step(statement) == SQLITE_ROW {
                        let model = StudentModel()
                        model.id = Int(sqlite3_column_int(statement, 0))
                        model.name = String(cString: sqlite3_column_text(statement, 1)!)
                        model.batch = String(cString: sqlite3_column_text(statement, 2)!)
                        model.semester = String(cString: sqlite3_column_text(statement, 3)!)
                        arr.append(model)
                    }
                    sqlite3_reset(statement)
                }
                return arr
            }
            closeDatabaseConnection()
            return arr
        }
    }
    
    func UpdateData(model: StudentModel) -> Bool {
        var result = false
//        defer {
//            closeDatabaseConnection()
//        }
        do {
            if openDatabaseConnection() {
                let Data_stmt = "UPDATE \(TBL_STUDENTS) SET \(FLD_NAME) = \'\(model.name)\', \(FLD_BATCH) = \'\(model.batch)\', \(FLD_SEM) = \'\(model.semester)\' WHERE \(FLD_AUTO_STUDENTS_ID) = \(model.id ?? 0)"
                print(Data_stmt)
                sqlite3_prepare_v2(database, Data_stmt, -1, &statement, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Data Updated.")
                    result = true
                } else {
                    print("Data Not Updated. Error \(String(describing: sqlite3_errmsg(database)))")
                    result = false
                }
                sqlite3_reset(statement)
                return result
            }
            closeDatabaseConnection()
            return result
        }
    }
    
    
    func DeleteFromID(ID: Int?) -> Bool {
        var result = false
//        defer {
//            closeDatabaseConnection()
//        }
        do {
            if openDatabaseConnection() {
                let Data_stmt = "DELETE FROM \(TBL_STUDENTS) WHERE \(FLD_AUTO_STUDENTS_ID) = \(ID ?? 0)"
                print(Data_stmt)
                sqlite3_prepare_v2(database, Data_stmt, -1, &statement, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Data deleted.")
                    result = true
                } else {
                    print("Data Not deleted. Error \(String(describing: sqlite3_errmsg(database)))")
                    result = false
                }
                sqlite3_reset(statement)
                return result
            }
            closeDatabaseConnection()
            return result
        }
    }
}
