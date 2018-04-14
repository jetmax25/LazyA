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
    
    var viewModel : CreateComponentViewModel!
    
    var cellName : String {
        return "ComponentCell"
    }
    
    var addCellName : String {
        return "AddComponent"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numComponents + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == viewModel.numComponents {
            return tableView.dequeueReusableCell(withIdentifier: addCellName)!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName) as! ComponentTableViewCell
        cell.delegate = self
        cell.rowNum = indexPath.row
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.viewModel = CreateComponentViewModel()
        weightChart.data = viewModel.chartData
        let description = Description.init()
        description.text = "Class Breakdown"
        weightChart.chartDescription = description
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addComponent(_ sender: Any) {
        self.viewModel.createNewComponent()
        self.tableView.insertRows(at: [IndexPath(row: viewModel.numComponents - 1, section: 0)], with: .automatic)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
}
