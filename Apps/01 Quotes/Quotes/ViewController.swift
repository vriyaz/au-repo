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
    var quotes : [String] = []
    var index : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("quotes", ofType: "txt")
        if let content = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil) {
            for quote in content.componentsSeparatedByString("\n\n") {
                if quote != "" && !quote.hasPrefix("#"){
                    println("\(quote)")
                    quotes.append(quote.stringByReplacingOccurrencesOfString(":", withString: ":\n", options: NSStringCompareOptions.LiteralSearch, range: nil))
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doButtonTap(sender: AnyObject) {

        println("button touched! \(index) : \(self.quotes[index])")

        self.messageLabel.text = self.quotes[index++]

        index %= self.quotes.count
    }

}

