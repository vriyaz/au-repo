//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Riyaz VALI on 4/19/15.
//  Copyright (c) 2015 Riyaz Vali. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {

    @IBOutlet weak var faceView: FaceView! { // good place to add gesture recognizers
        didSet {
            faceView.dataSource = self
            // gesture handling #1
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }

    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }

    // gesture handling #2 - a different way of doing it
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)

            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }

    var happiness: Int = 50 { // 0 = sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
            println("happiness = \(happiness)")
            updateUI()
            title = "\(happiness)"
        }
    }

    func updateUI() {
        // outlets are not set when preparing segue, hence faceView is optional
        faceView?.setNeedsDisplay()
    }

    func smilinessForFaceView(sender: FaceView) -> Double? {
        // interpret the model for the view
        return Double(happiness - 50)/50
    }

    @IBAction func changeScaleViaSlider(sender: UISlider) {
        faceView.scale = CGFloat(sender.value)
    }
    
    @IBAction func changeHappinessViaSlider(sender: UISlider) {
        println("sliderValue: \(sender.value)")
        happiness = Int(sender.value)
    }
}
