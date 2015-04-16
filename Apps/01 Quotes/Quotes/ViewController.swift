//
//  ViewController.swift
//  Quotes
//
//  Created by Riyaz Vali on 3/31/15.
//  Copyright (c) 2015 Riyaz Vali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!

    let messages : [String] = [
                                "may the force be with you",
                                "live long and prosper",
                                "to infinity and beyond",
                                "space is big. you just wont believe how vastly, hugely, mind-bogglingly big it is"
                              ]

    var index : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doButtonTap(sender: AnyObject) {

        println("button touched! \(index) : \(self.messages[index])")

        self.messageLabel.text = self.messages[index++]

        index %= self.messages.count
    }

}

