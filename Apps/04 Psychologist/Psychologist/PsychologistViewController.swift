//
//  ViewController.swift
//  Psychologist
//
//  Created by Riyaz VALI on 4/22/15.
//  Copyright (c) 2015 Au Apps. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {

    // programmatic segue
    @IBAction func nothing(sender: UIButton) {
        performSegueWithIdentifier("nothing", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        // because we added a navigation view controller in from of the happiness-view-controller
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }

        if let hvc = destination as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "sad": hvc.happiness = 0
                    case "happy": hvc.happiness = 100
                    case "nothing": hvc.happiness = 25
                    default: hvc.happiness = 60
                }
            }
        }
    }
}

