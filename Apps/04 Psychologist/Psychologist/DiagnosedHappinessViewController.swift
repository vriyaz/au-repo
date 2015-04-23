//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by Riyaz VALI on 4/22/15.
//  Copyright (c) 2015 Au Apps. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate {

    override var happiness: Int {
        // in overrides, the didSet from the parent does get called before this
        didSet {
            diagnosticHistory += [happiness]
        }
    }

    private let defaults = NSUserDefaults.standardUserDefaults()

    var diagnosticHistory: [Int] {
        get {
            return defaults.objectForKey(History.DefaultsKey) as? [Int] ?? []
        }
        set {
            defaults.setObject(newValue, forKey: History.DefaultsKey)
        }
    }

    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnosedHappinessViewController.History"
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
                case History.SegueIdentifier:
                    if let tvc = segue.destinationViewController as? TextViewController {

                        // let the diagnosed-hvc control the popover controller
                        if let ppc = tvc.popoverPresentationController {
                            ppc.delegate = self
                        }

                        tvc.text = "\(diagnosticHistory)"
                    }
                default: break
            }
        }
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!, traitCollection: UITraitCollection!) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

}
