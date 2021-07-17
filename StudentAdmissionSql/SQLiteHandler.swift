//
//  SQLiteHandler.swift
//  StudentAdmissionSql
//
//  Created by Sandhya Baghel on 11/07/21.
//  Copyright © 2021 Sandhya. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteHandler
{
    static let shared = SQLiteHandler()
    
    let dbPath = "studDB.sqlite"
    var db:OpaquePointer?
    
    private init(){
        db = openDatabase()
        createTable()
    }
    
    func openDatabase() -> OpaquePointer?
    {
        let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = docURL.appendingPathComponent(dbPath)
        
        var database:OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &database) == SQLITE_OK
        {
            print("Connection Opened")
            return database
        }
        else{
            print("Error connection")
            return nil
        }
    }
    
    func createTable()
    {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        mobile TEXT,
        pwd TEXT);
        """
        
        var createTableStatement:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("successfully created table")
            }
            else
            {
                print("Error in created table")
            }
        }
        else
        {
            print("Create table statement could not be prepared")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(stud:Student , completion: @escaping ((Bool) -> Void)) {
        let insertStatementString = "INSERT INTO students (name, email, mobile, pwd) VALUES(?, ?, ?, ?);"
        var insertStatement:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_text(insertStatement, 1, (stud.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (stud.email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (stud.mobile as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (stud.pwd as NSString).utf8String, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE
            {
                print("successfully inserted")
                completion(true)
            }
            else
            {
                print("not successfully inserted")
                completion(false)
            }
        }
        else
        {
            print("Insert statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(insertStatement)
    }
    
    func update(stud:Student , completion: @escaping ((Bool) -> Void))
    {
        let updateStatementString = "UPDATE students SET name = ?, email = ?, mobile = ?, pwd = ? WHERE id = ?;"
        var updateStatement:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_text(updateStatement, 1, (stud.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (stud.email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (stud.mobile as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (stud.pwd as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 5, Int32(stud.id))
            if sqlite3_step(updateStatement) == SQLITE_DONE
            {
                print("successfully Updated")
                completion(true)
            }
            else
            {
                print("not successfully Updated")
                completion(false)
            }
        }
        else
        {
            print("Update statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(updateStatement)
    }
    
    func changepwd(stud:Student , completion: @escaping ((Bool) -> Void))
    {
        let updateStatementString = "UPDATE students SET pwd = ? WHERE id = ?;"
        var updateStatement:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_text(updateStatement, 1, (stud.pwd as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 2, Int32(stud.id))
            if sqlite3_step(updateStatement) == SQLITE_DONE
            {
                print("successfully Updated")
                completion(true)
            }
            else
            {
                print("not successfully Updated")
                completion(false)
            }
        }
        else
        {
            print("Update statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(updateStatement)
    }
    
    func fetch()->[Student]
    {
        let fetchStatementString = "SELECT * FROM students;"
        var fetchStatement:OpaquePointer? = nil
        
        var stud = [Student]()
        
        if sqlite3_prepare_v2(db, fetchStatementString, -1, &fetchStatement, nil) == SQLITE_OK
        {
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(fetchStatement, 0))
                let name = String(cString: sqlite3_column_text(fetchStatement, 1))
                let email = String(cString: sqlite3_column_text(fetchStatement, 2))
                let mobile = String(cString: sqlite3_column_text(fetchStatement, 3))
                let pwd = String(cString: sqlite3_column_text(fetchStatement, 4))
                stud.append(Student(id: id, name: name, email: email, mobile: mobile, pwd: pwd))
                
                print("Query Result:")
                print("\(id) \t \(name) \t \(email) \t \(mobile) \t \(pwd)")
            }
        }
        else
        {
            print("Select statement could not be prepared")
        }
        sqlite3_finalize(fetchStatement)
        return stud
    }
    
    func delete(for id:Int ,completion: @escaping ((Bool) ->Void))
    {
        let deleteStatementString = "DELETE FROM students WHERE id = ?;"
        var deleteStatement:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE
            {
                print("successfully deleted")
                completion(true)
            }
            else
            {
                print("not successfully deleted")
                completion(false)
            }
        }
        else
        {
            print("delete statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(deleteStatement)
    }
}
