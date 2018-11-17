//
//  CreateComponentViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 4/6/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit
import Charts


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
        self.sectionTableView.insertRows(at: [IndexPath(row: viewModel.numComponents, section: 0)], with: .automatic)
    }
    
    @IBAction func nextCourse(_ sender: Any) {
        self.sectionTableView.reloadData()
        self.viewModel.nextCourse()
        if viewModel.currentCourse != nil {
            self.classTitleLabel.text = viewModel.courseName
            self.sectionTableView.reloadData()
        } else {
            print("done")
        }
    }
    
    @IBAction func skipForNow(_ sender: Any) {
    }
    
    @IBAction func nextWithNoSections(_ sender: Any) {
    }
}


extension  CreateComponentViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextNumTableViewCell.name) as! TextNumTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numComponents
    }
}
