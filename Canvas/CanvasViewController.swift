//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Hye Lim Joun on 4/4/18.
//  Copyright © 2018 hyelim. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

  @IBOutlet weak var trayView: UIView!
  var newlyCreatedFace: UIImageView!
  
  @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
    var trayOriginalCenter: CGPoint!
    let velocity = sender.velocity(in: view)
    let trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    trayDownOffset = 160
    trayUp = trayView.center // The initial position of the tray
    trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset) // The position of the tray transposed down
    
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
                        self.trayView.center = trayDown
        }, completion: nil)
      }
      else if(velocity.y < 0){
        UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                       animations: { () -> Void in
                        self.trayView.center = trayUp
        }, completion: nil)
      }
    }
  
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
