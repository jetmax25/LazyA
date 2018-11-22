//
//  TabContainerViewController.swift
//  LazyA
//
//  Created by Michael Isasi on 11/21/18.
//  Copyright © 2018 Jetmax25. All rights reserved.
//

import UIKit

class TabContainerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    weak var containedTabBarController : UITabBarController?
    
    override func viewDidLoad() {
        if CourseHandler.shared.getAll().count == 0 {
            Storyboard.CreateCourse.launch()
        }
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tabSegue" {
            let vc = segue.destination as! UITabBarController
            vc.delegate = self
            self.containedTabBarController = vc
        }
    }
}

extension TabContainerViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
