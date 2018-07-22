//
//  ViewController1.swift
//  TimerButtonApp
//
//  Created by Imanou on 21/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    let button = TimerButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetTimer))
        button.addTarget(self, action: #selector(toggleTimer), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc func toggleTimer(_ sender: UIButton) {
        button.toggleProgress()
    }

    @objc func resetTimer(_ sender: UIBarButtonItem) {
        button.reset()
    }

}
