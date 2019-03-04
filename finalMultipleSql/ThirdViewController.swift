//
//  ThirdViewController.swift
//  finalMultipleSql
//
//  Created by Admin on 4/3/2562 BE.
//  Copyright © 2562 Admin. All rights reserved.
//

import UIKit
import SQLite3

class ThirdViewController: UIViewController {

    @IBOutlet weak var idEdit: UITextField!
    @IBOutlet weak var nameEdit: UITextField!
    
    @IBOutlet weak var phoneEdit: UITextField!
    @IBOutlet weak var dateEdit: UIDatePicker!
    let fileName = "db.sqlite"
    let fileManager = FileManager .default
    var dbPath = String()
    var sql = String()
    var db: OpaquePointer?
    var stmt: OpaquePointer?
    var pointer: OpaquePointer?
    @IBAction func editData(_ sender: Any) {
        guard let id = Int32(idEdit.text!)else{
            return
        }
        let name = nameEdit.text! as NSString
        let phone = phoneEdit.text! as NSString
        let currentDate = dateEdit.date
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "YYYY-MM-dd"
        let thaiLocale = NSLocale(localeIdentifier: "TH_th")
        myFormatter.locale = thaiLocale as Locale!
        let currentDateText = myFormatter.string(from: currentDate)
        self.sql = "UPDATE people " +
            "SET name =  ?, date = ?, phone = ?  " +
        "WHERE id = ?"
        sqlite3_prepare(self.db, self.sql, -1, &self.stmt, nil)
        sqlite3_bind_text(self.stmt, 1, name.utf8String, -1, nil)
        sqlite3_bind_text(self.stmt, 2, phone.utf8String, -1, nil)
        sqlite3_bind_text(self.stmt, 3, currentDateText, -1, nil)
        sqlite3_bind_int(self.stmt, 4, id)
        sqlite3_step(self.stmt)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let dbURL = try! fileManager .url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
            .appendingPathComponent(fileName)
        
        let opendb = sqlite3_open(dbURL.path, &db)
        if opendb != SQLITE_OK {
            print("Opening Database Error")
            return
        }
        else {
            print("Opening Database")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
