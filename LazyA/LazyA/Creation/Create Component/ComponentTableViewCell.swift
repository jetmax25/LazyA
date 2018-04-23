//
//  ComponentTableViewCell.swift
//  LazyA
//
//  Created by Michael Isasi on 4/6/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

class ComponentTableViewCell: UITableViewCell {
    
    var component : Component! {
        didSet {
            self.nameTextField.text = component.name
            self.weightTextField.text = "\(component.weight)"
        }
    }
    
    @IBOutlet weak var weightTextField: UITextField! {
        didSet {
            weightTextField.keyboardType = .numberPad
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    var delegate : CreateComponentDelegate!
    var rowNum : Int!

    var weightNum : Int {
        if let weightString = weightTextField.text, let num = Int(weightString), num > 0 {
            return num
        }
        return 0
    }
    
    @IBAction func editComponent(_ sender: Any) {
        delegate.editComponent(for: rowNum, name: nameTextField.text ?? "", weight: weightNum)
    }
    
    @IBAction func updateComponent(_ sender: Any) {
        delegate.editComponent(for: rowNum, name: nameTextField.text ?? "", weight: weightNum)
        weightTextField.text = "\(weightNum)"
    }
    
}
