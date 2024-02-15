//
//  UIViewController.swift
//  Reciplease
//
//  Created by elodie gage on 15/02/2024.
//    
//

import UIKit

extension UIViewController {
   
    // method to display an alert
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    // method to manage button and activity controller together
    func activityIndicator(activityIndicator: UIActivityIndicatorView, button: UIButton, showActivityIndicator: Bool){
        activityIndicator.isHidden = !showActivityIndicator
        button.isHidden = showActivityIndicator
        if showActivityIndicator == true {
            activityIndicator.startAnimating()
        } else {
        }
    }
    
    // method to display keyboard when tipping
    func initializeHideKeyboard() {
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    
    // method to dismiss keyboard
    @objc func dismissMyKeyboard() {
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
}
