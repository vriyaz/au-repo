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

        if let path = NSBundle.mainBundle().pathForResource("quotes", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                let json = JSON(data: data, options: NSJSONReadingOptions.AllowFragments, error: nil)
                println("jsonData:\(json)")
                let key = "hello"
                let value = json["dict1"][1]["a2"]
                println("\(key)=\(value)")
                //println(NSString(format: "%s=%s", key, value.stringValue)) // doesnt work
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

