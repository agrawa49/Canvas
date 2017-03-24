//
//  CanvasViewController.swift
//  AnimationsAndGestures
//
//  Created by Akhil Agrawal on 11/7/16.
//  Copyright © 2017 Akhil Agrawal. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    @IBOutlet weak var trayView: UIView!
    
    var originalTrayCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newFace: UIImageView!
    var newFaceOriginalCenter: CGPoint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            
            originalTrayCenter = trayView.center
            
        } else if sender.state == .changed {
            
            trayView.center = CGPoint(x: originalTrayCenter.x, y: originalTrayCenter.y + translation.y)
            
            
        } else if sender.state == .ended {
            
            //velocity > 0 -> down
            //else -> up
            
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.4, animations: {
                    self.trayView.center = self.trayDown
                })
            } else {
                UIView.animate(withDuration: 0.4, animations: {
                    self.trayView.center = self.trayUp
                })
            }
            
        }
        
    }
    
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        let imageView = sender.view as! UIImageView

        
        if sender.state == .began {
            
            newFace = UIImageView(image: imageView.image)
            view.addSubview(newFace)
            newFace.center = imageView.center
            newFace.center.y += trayView.frame.origin.y
            newFaceOriginalCenter = newFace.center
            
            newFace.isUserInteractionEnabled = true
            
            
            //Animate
            UIView.animate(withDuration: 0.2, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
            
            
        } else if sender.state == .changed {
            
            newFace.center = CGPoint(x: newFaceOriginalCenter.x + translation.x, y: newFaceOriginalCenter.y + translation.y)
            
            
        } else if sender.state == .ended {
            
            //Animate
            UIView.animate(withDuration: 0.2, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
