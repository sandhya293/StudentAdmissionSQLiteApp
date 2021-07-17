//
//  AdminVC.swift
//  StudentAdmissionSql
//
//  Created by Sandhya Baghel on 11/07/21.
//  Copyright © 2021 Sandhya. All rights reserved.
//

import UIKit

class AdminVC: UIViewController {

    private let StudentList : UIButton = {
        let btn = UIButton()
        btn.setTitle("Student List", for: .normal)
        btn.backgroundColor = .init(red: 0.157, green: 0.157, blue: 0.157, alpha: 1)
        btn.addTarget(self, action: #selector(StudentLists), for: .touchUpInside)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    @objc private func StudentLists()
    {
        let vc = StudentListVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private let NoticeList : UIButton = {
        let btn = UIButton()
        btn.setTitle("Notice List", for: .normal)
        btn.backgroundColor = .init(red: 0.157, green: 0.157, blue: 0.157, alpha: 1)
        btn.addTarget(self, action: #selector(NoticeLists), for: .touchUpInside)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    @objc private func NoticeLists()
    {
        let vc = NoticeBoardVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Admin Panel"
        view.backgroundColor = .init(red: 0.557, green: 0.778, blue: 0.248, alpha: 1)
        view.addSubview(StudentList)
        view.addSubview(NoticeList)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        StudentList.frame = CGRect(x: 60, y: 120, width: 130, height: 100)
        NoticeList.frame = CGRect(x: view.width-190, y: 120, width: 130, height: 100)
    }
}
