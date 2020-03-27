//
//  CreateComponentViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 4/6/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit
import Charts
import PickledSwift


//protocol CreateComponentDelegate {
//    func editComponent(for row : Int, name : String, weight : Int)
//}

class CreateComponentViewController: LazyAViewController {
    
    @IBOutlet weak var sectionTableView: UITableView!
    @IBOutlet weak var classTitleLabel: LazyALabel!
    @IBOutlet weak var goalValueLabel: LazyALabel!
    
    
    func editComponent(for row: Int, name: String, weight: Int) {
        self.viewModel.editComponent(for: row, name: name, weight: weight)
    }
    
    var viewModel : CreateComponentViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CreateComponentViewModel()
        self.classTitleLabel.text = viewModel.courseName
        
        sectionTableView.register( cell : TextNumTableViewCell.self)
    }

    @IBAction func addComponent(_ sender: Any) {
        self.viewModel.createNewComponent()
        self.sectionTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    @IBAction func nextCourse(_ sender: Any) {
        self.viewModel.nextCourse()
        if viewModel.currentCourse != nil {
            self.classTitleLabel.text = viewModel.courseName
            self.sectionTableView.reloadData()
        } else {
            LazyAStoryboard.TabContainer.launch()
        }
    }
    
    @IBAction func skipForNow(_ sender: Any) {
        self.viewModel.nextCourse()
        self.sectionTableView.reloadData()
    }
    
    @IBAction func nextWithNoSections(_ sender: Any) {
        self.viewModel.currentCourse?.hasCatagories = false
        self.viewModel.nextCourse()
        self.sectionTableView.reloadData()
    }
}


extension CreateComponentViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextNumTableViewCell.name) as! TextNumTableViewCell
        cell.textField.text = viewModel.components[indexPath.row].name
        cell.numberPicker.value = viewModel.components[indexPath.row].weight
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numComponents
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            viewModel.deleteComponent(at: indexPath.row)
            self.sectionTableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        default: return
        }
    }
}

extension CreateComponentViewController : TextNumTableViewCellDelegate {
    func textNumTableViewCell(didUpdateCellAt indexPath: IndexPath, text: String, num: Int) {
        let component = self.viewModel.componentFor(row: indexPath.row)
        component?.name = text
        component?.weight = num
    }
}
