//
//  TextViewController.swift
//  Psychologist
//
//  Created by Riyaz VALI on 4/22/15.
//  Copyright (c) 2015 Au Apps. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
        }
    }

    var text: String = "" {
        didSet {
            textView?.text = text
        }
    }

    // to tighten up the popover
    override var preferredContentSize: CGSize {
        get {
            if textView != nil && presentingViewController != nil {
                //return textView.sizeThatFits(presentingViewController!.view.bounds.size)
                return super.preferredContentSize
            } else {
                return super.preferredContentSize
            }
        }
        set { super.preferredContentSize = newValue }
    }
}
