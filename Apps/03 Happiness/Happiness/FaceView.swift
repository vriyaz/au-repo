//
//  FaceView.swift
//  Happiness
//
//  Created by Riyaz VALI on 4/19/15.
//  Copyright (c) 2015 Riyaz Vali. All rights reserved.
//

import UIKit

// delegate
protocol FaceViewDataSource: class { // only class will implement, no structs or enum
    func smilinessForFaceView(sender: FaceView) -> Double?  // pass self along
}

@IBDesignable
class FaceView: UIView {

    @IBInspectable var lineWidth: CGFloat = 4.0 { didSet { setNeedsDisplay() } }
    @IBInspectable var color: UIColor = UIColor.redColor() { didSet { setNeedsDisplay() } }
    @IBInspectable var scale: CGFloat = 0.70 { didSet { setNeedsDisplay() } }

    var faceCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }

    var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) * scale / 2
    }

    weak var dataSource: FaceViewDataSource? // deal with cyclic dependencies as the controller also points to FaceView via the heirarchy

    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }

    private enum Eye { case Left, Right }

    func scale(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .Changed {
            scale *= gesture.scale
            gesture.scale = 1
        }
    }

    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio

        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        switch whichEye {
        case .Left: eyeCenter.x -= eyeHorizontalSeparation / 2
        case .Right: eyeCenter.x += eyeHorizontalSeparation / 2
        }

        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        path.lineWidth = lineWidth
        return path
    }

    private func bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio

        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight

        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)

        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }

    override func drawRect(rect: CGRect) {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)

        facePath.lineWidth = lineWidth;
        color.set()
        facePath.stroke()

        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()

        let smiliness = dataSource?.smilinessForFaceView(self) ?? 0.0
        let smilePath = bezierPathForSmile(smiliness)
        smilePath.stroke()
    }

}
