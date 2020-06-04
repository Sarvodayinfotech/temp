//
//  StudentModel.swift
//  DatabaseConnectivity
//
//  Created by Vinita Nair on 27/04/20.
//  Copyright © 2020 Vinita Nair. All rights reserved.
//

import Foundation
class StudentModel {
    var id: Int?
    var name: String
    var batch: String
    var semester: String
    
    init() {
        id = 0
        name = ""
        batch = ""
        semester = ""
    }
    
    init(id: Int) {
        self.id = id
        name = ""
        batch = ""
        semester = ""
    }
    
    init(id: Int, name: String, batch: String, sem: String) {
        self.id = id
        self.name = name
        self.batch = batch
        self.semester = sem
    }
}
