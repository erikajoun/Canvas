//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Hye Lim Joun on 4/4/18.
//  Copyright © 2018 hyelim. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
  var newlyCreatedFace: UIImageView!
  var newlyCreatedFaceOriginalCenter: CGPoint!
  
  @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
    if(sender.state == .began) {
      var imageView = sender.view as! UIImageView
      newlyCreatedFace = UIImageView(image: imageView.image)
      view.addSubview(newlyCreatedFace)
      newlyCreatedFace.center = imageView.center
      newlyCreatedFace.center.y += trayView.frame.origin.y
      newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
      
      // Programmatically add gesture recognizer to new face
      let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanEmoji(sender:)))
      newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
      newlyCreatedFace.isUserInteractionEnabled = true
    }
    
    let translation = sender.translation(in: view)
    
    if(sender.state == .changed) {
      newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
    }
    
    if(sender.state == .ended) {
      
    }
  }
  
  @IBOutlet weak var trayView: UIView!
  
  var trayDownOffset: CGFloat!
  var trayUp: CGPoint!
  var trayDown: CGPoint!
  var trayOriginalCenter: CGPoint!
  
  @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
    let velocity = sender.velocity(in: view)
    
    let translation = sender.translation(in: view)
    if(sender.state == .began) {
      trayOriginalCenter = trayView.center
    }
    if(sender.state == .changed) {
      if(trayOriginalCenter != nil) {
        trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
      }
    }
    
    if(sender.state == .ended) {
      if(velocity.y > 0) {  // Tray is moving down
        UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                       animations: { () -> Void in
                        self.trayView.center = self.trayDown
        }, completion: nil)
      }
      else if(velocity.y < 0){
        UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                       animations: { () -> Void in
                        self.trayView.center = self.trayUp
        }, completion: nil)
      }
    }
  }
  
  @IBAction func didPanEmoji(sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    
    if sender.state == .began {
      newlyCreatedFace = sender.view as! UIImageView // to get the face that we panned on.
      newlyCreatedFaceOriginalCenter = newlyCreatedFace.center // so we can offset by translation later.

    } else if sender.state == .changed {
      newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)

    } else if sender.state == .ended {
      
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    trayDownOffset = 160
    trayUp = trayView.center // The initial position of the tray
    trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset) // The position of the tray transposed down
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
