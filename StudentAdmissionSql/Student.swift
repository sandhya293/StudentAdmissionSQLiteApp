//
//  Student.swift
//  StudentAdmissionSql
//
//  Created by Sandhya Baghel on 11/07/21.
//  Copyright © 2021 Sandhya. All rights reserved.
//

import Foundation

class Student{
    
    var id:Int = 0
    var name:String = ""
    var email:String = ""
    var mobile:String = ""
    var pwd:String = ""
    
    init(id:Int, name:String, email:String, mobile:String ,pwd:String) {
        self.id = id
        self.name = name
        self.email = email
        self.mobile = mobile
        self.pwd = pwd
    }
}
