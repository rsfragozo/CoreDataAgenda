//
//  AddContactViewController.swift
//  CoreDataAgenda
//
//  Created by vinigodoy on 17/02/16.
//  Copyright © 2016 HSBC. All rights reserved.
//

import UIKit

class AddContactViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var pickPhone: UIPickerView!
    @IBOutlet weak var btnAdd: NSLayoutConstraint!
    
    var phones = [String]()
    
    override func viewDidLoad() {
        pickPhone.delegate = self
        pickPhone.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return phones.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return phones[row]
    }
    
    @IBAction func btnAddClick(_ sender: AnyObject) {
        phones.append(txtPhone.text!)
        txtPhone.text = ""
        txtPhone.resignFirstResponder()
        pickPhone.reloadAllComponents()
    }
    
    @IBAction func btnSaveClick(_ sender: AnyObject) {
        if !DataStore.instance.savePerson(txtName.text!, phones: phones) {
            print("Falha ao salvar contato!")
            return
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
