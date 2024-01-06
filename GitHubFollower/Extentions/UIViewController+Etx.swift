import UIKit

// This class has been created for all viewControllers, like if any view controller is gonna need an alert pop up, this way we do not repeat ourselves.


extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen // covers the all screen
            alertVC.modalTransitionStyle = .crossDissolve // fades in
            
            self.present(alertVC, animated: true)
            
        }
    }
}
