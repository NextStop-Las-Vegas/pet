//
//  Helpers.swift
//  Pet-prjct
//
//  Created by Pavel on 01.03.2021.
//

import Foundation
import UIKit

class Helpers : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillshow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardWillshow(notification: NSNotification){
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)? .cgRectValue else{
            return
        }
        guard let activeTF = findFirstResponder(inView: self.view) else{
            return
        }
        var aRect = self.view.frame
        aRect = aRect.minY < 0 ? CGRect(x: aRect.minX, y: 0, width: aRect.width, height: aRect.height) : aRect
        let frame = activeTF.convert(activeTF.bounds, to: self.view)
        aRect.size.height -= keyboardSize.height
        if (!aRect.contains(frame)){
            self.view.frame.origin.y = 0 - keyboardSize.height + 20
        }else{
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        self.view.frame.origin.y = 0
    }
    
    func findFirstResponder(inView view: UIView) -> UIView?{
        for subView in view.subviews{
            if subView.isFirstResponder{
                return subView
            }
            
            if let recursiveSubView = self.findFirstResponder(inView: subView){
                return recursiveSubView
            }
        }
        return nil
    }
}
