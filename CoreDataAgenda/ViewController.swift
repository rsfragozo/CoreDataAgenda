//
//  ViewController.swift
//  CoreDataAgenda
//
//  Created by vinigodoy on 17/02/16.
//  Copyright © 2016 HSBC. All rights reserved.
//

import UIKit

enum Mode {
    case person, phone
}

class ViewController: UITableViewController {
    @IBOutlet weak var btnChange: UIBarButtonItem!
    var op = Mode.person
    var personRow = 0
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItems!.append(editButtonItem)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if op == .person {
            return DataStore.instance.getPersonList().count
        } else {
            return DataStore.instance.getPhoneList().count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        if op == .person {
            let list = DataStore.instance.getPersonList()
            let person = list[indexPath.row] as Person
            cell!.textLabel?.text = person.name
            cell!.detailTextLabel?.text = "Telefones: \(person.phones!.count)"
        } else {
            let list = DataStore.instance.getPhoneList()
            let phone = list[indexPath.row] as Phone
            cell!.textLabel?.text = phone.number
            cell!.detailTextLabel?.text = "Contato: \(phone.person!.name!)"
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if op == .person {
                DataStore.instance.removePersonAtRow(indexPath.row)
            } else {
                DataStore.instance.removePhoneAtRow(indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (op == .person) {
            personRow = indexPath.row
            performSegue(withIdentifier: "edit", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "edit") {
            let dest = segue.destination as! EditContactViewController
            dest.personRow = personRow
        }
    }
    
    @IBAction func btnChangeClick(_ sender: AnyObject) {
        if btnChange!.title == "Telefones" {
            btnChange.title = "Contatos"
            op = .phone
        } else {
            btnChange.title = "Telefones"
            op = .person
        }
        tableView.reloadData()
    }
}

