//
//  CreateComponentViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 4/6/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit
import Charts


protocol CreateComponentDelegate {
    func editComponent(for row : Int, name : String, weight : Int)
}

class CreateComponentViewController: UIViewController, CreateComponentDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func editComponent(for row: Int, name: String, weight: Int) {
        self.viewModel.editComponent(for: row, name: name, weight: weight)
        self.weightChart.data = viewModel.chartData
    }
    
    @IBOutlet weak var weightChart: PieChartView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var viewModel : CreateComponentViewModel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numComponents
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AppStrings.tablecells.componentCell.rawValue) as! ComponentTableViewCell
        cell.delegate = self
        cell.component = viewModel.componentFor(row: indexPath.row)
        cell.rowNum = indexPath.row
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = CreateComponentViewModel()
        self.nameLabel.text = viewModel.courseName
    }
    
    func setUpChart() {
        weightChart.data = viewModel.chartData
        let description = Description.init()
        description.text = "Class Breakdown"
        weightChart.chartDescription = description
    }
    
    @IBAction func addComponent(_ sender: Any) {
        self.viewModel.createNewComponent()
        self.tableView.insertRows(at: [IndexPath(row: viewModel.numComponents, section: 0)], with: .automatic)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    @IBAction func nextCourse(_ sender: Any) {
        self.tableView.reloadData()
        self.viewModel.nextCourse()
        if viewModel.currentCourse != nil {
            self.nameLabel.text = viewModel.courseName
            self.tableView.reloadData()
        } else {
            print("done")
        }
    }
}
