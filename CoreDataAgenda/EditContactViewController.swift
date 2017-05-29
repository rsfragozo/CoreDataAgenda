//
//  EditContactViewController.swift
//  CoreDataAgenda
//
//  Created by vinigodoy on 17/02/16.
//  Copyright © 2016 HSBC. All rights reserved.
//

import UIKit

class EditContactViewController : UIViewController {
    
    @IBOutlet weak var txtName: UITextField!

    var personRow : Int!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let list = DataStore.instance.getPersonList()
        let person = list[personRow]
        txtName.text = person.name
    }
    
    @IBAction func btnSaveClick(_ sender: AnyObject) {
        DataStore.instance.updatePerson(txtName.text!, row: personRow)
        navigationController?.popViewController(animated: true)
    }
}
