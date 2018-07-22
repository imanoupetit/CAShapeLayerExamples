//
//  ViewController3.swift
//  TimerButtonApp
//
//  Created by Imanou on 21/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

// Source: [collectiveidea.com](https://collectiveidea.com/blog/archives/2017/12/04/cabasicanimation-for-animating-strokes-plus-a-bonus-gratuitous-ui-interaction)

import UIKit

class ViewController4: UIViewController {

    let popView = ProgressView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(popView)
        popView.translatesAutoresizingMaskIntoConstraints = false
        popView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        popView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Animate", style: .plain, target: self, action: #selector(animate))
    }

    @objc func animate() {
        popView.animate()
    }

}
