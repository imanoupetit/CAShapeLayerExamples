//
//  TableViewController.swift
//  CAShapeLayerExamples
//
//  Created by Imanou on 04/08/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

struct Example {
    let title: String
    let ViewControllerType: UIViewController.Type
}

class TableViewController: UITableViewController {

    let exampleArray = [
        Example(title: "1 - Ring", ViewControllerType: ViewController1.self),
        Example(title: "2 - Fireworks", ViewControllerType: ViewController2.self),
        Example(title: "3 - Clock", ViewControllerType: ViewController3.self),
        Example(title: "4 - Loading bar", ViewControllerType: ViewController4.self),
        Example(title: "5 - Shaking text field", ViewControllerType: ViewController5.self),
        Example(title: "6 - Fading pulse", ViewControllerType: ViewController6.self),
        Example(title: "7 - Rounded ring + pulse", ViewControllerType: ViewController7.self),
        Example(title: "8 - Flashing view", ViewControllerType: ViewController8.self),
        Example(title: "9 - Scrollable ring", ViewControllerType: ViewController9.self),
        Example(title: "10 - Activity indicator #1", ViewControllerType: ViewController10.self),
        Example(title: "11 - Activity indicator #2 (counterclockwise)", ViewControllerType: ViewController11.self),
        Example(title: "12 - Activity indicator #3", ViewControllerType: ViewController12.self),
        Example(title: "13 - Rotation", ViewControllerType: ViewController13.self)
    ]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = exampleArray[indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ViewControllerType = exampleArray[indexPath.row].ViewControllerType
        let viewController = ViewControllerType.init()
        viewController.title = exampleArray[indexPath.row].title
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
