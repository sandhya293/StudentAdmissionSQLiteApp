//
//  StudentVC.swift
//  StudentAdmissionSql
//
//  Created by Sandhya Baghel on 11/07/21.
//  Copyright © 2021 Sandhya. All rights reserved.
//

import UIKit

class StudentVC: UIViewController {

    let email = UserDefaults.standard.string(forKey: "email")
    let name = UserDefaults.standard.string(forKey: "name")
    let mobile = UserDefaults.standard.string(forKey: "mobile")
    
    private var studArray = [Student]()
    private var noticeArray = [Notice]()
    
    private let lbl0:UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let lbl1:UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    private let lbl2:UILabel = {
        let label = UILabel()
        label.text = "Email Id"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let lbl3:UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    private let lbl4:UILabel = {
        let label = UILabel()
        label.text = "Mobile No"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let lbl5:UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    private let lbl6:UILabel = {
        let label = UILabel()
        label.text = "Notices"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let lbl7:UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    private let changepwd : UIButton = {
        let pwd = UIButton()
        pwd.setTitle("Change Password", for: .normal)
        pwd.backgroundColor = .init(red: 0.557, green: 0.778, blue: 0.248, alpha: 1)
        pwd.addTarget(self, action: #selector(changepassword), for: .touchUpInside)
        pwd.layer.cornerRadius = 10
        return pwd
    } ()

    @objc private func changepassword()
    {
        let cnt = studArray.count
        for i in 0..<cnt
        {
            if (email == studArray[i].email)
            {
                let ids = Int(self.studArray[i].id)
                let names = self.studArray[i].name
                let emails = self.studArray[i].email
                let mobiles = self.studArray[i].mobile
                
                let alert = UIAlertController(title: "Add New Password", message: "Please Change Your Password", preferredStyle: .alert)
              
                alert.addTextField { (tf) in
                    tf.text = "\(self.studArray[i].pwd)"
                }
                let action = UIAlertAction(title:"Submit", style: .default) { (_) in
                    guard let pwd = alert.textFields?[0].text
                    else{
                        return
                    }
                    let stud = Student(id: ids, name: names, email: emails, mobile: mobiles, pwd: pwd)
                    SQLiteHandler.shared.changepwd(stud: stud) { [weak self] success in
                        if success
                        {
                            let alert = UIAlertController(title: "Updated Successfully", message: "Success !", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "dismiss", style: .cancel,handler: { [weak self] _ in
                                let vc = StudentVC()
                                self?.navigationController?.pushViewController(vc, animated: false)
                            }))
                            DispatchQueue.main.async
                            {
                                self!.present(alert, animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            let alert = UIAlertController(title: "Oops", message: "There Was An Error !", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "dismiss", style: .cancel))
                            DispatchQueue.main.async
                            {
                                self!.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
                alert.addAction(action)

                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        studArray = SQLiteHandler.shared.fetch()
        noticeArray = SQLiteNoticeHandler.shared.fetch()
        title = "Student Profile"
        view.addSubview(lbl0)
        view.addSubview(lbl1)
        view.addSubview(lbl2)
        view.addSubview(lbl3)
        view.addSubview(lbl4)
        view.addSubview(lbl5)
        view.addSubview(lbl6)
        view.addSubview(lbl7)
        view.addSubview(changepwd)
        print(name!)
        print(mobile!)
        print(email!)
        lbl1.text = name
        lbl3.text = email
        lbl5.text = mobile
        
        let ntcnt = noticeArray.count
        for i in 0..<ntcnt
        {
            lbl7.text = noticeArray[i].notice
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lbl0.frame = CGRect(x: 40, y: 80, width: view.width-80, height: 30)
        lbl1.frame = CGRect(x: 40, y: lbl0.bottom + 6, width: view.width-80, height: 30)
        lbl2.frame = CGRect(x: 40, y: lbl1.bottom + 20, width: view.width-80, height: 30)
        lbl3.frame = CGRect(x: 40, y: lbl2.bottom + 6, width: view.width-80, height: 30)
        lbl4.frame = CGRect(x: 40, y: lbl3.bottom + 20, width: view.width-80, height: 30)
        lbl5.frame = CGRect(x: 40, y: lbl4.bottom + 6, width: view.width-80, height: 30)
        lbl6.frame = CGRect(x: 40, y: lbl5.bottom + 20, width: view.width-80, height: 30)
        lbl7.frame = CGRect(x: 40, y: lbl6.bottom + 6, width: view.width-80, height: 60)
        changepwd.frame = CGRect(x: 40, y: lbl7.bottom + 20, width: view.width-80, height: 50)
    }
}
