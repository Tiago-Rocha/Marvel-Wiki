import Foundation
import UIKit

extension UIViewController {
    
    func toggleLoading(_ activityColor: UIColor? = .gray, _ backgroundColor: UIColor? = .clear) {
        DispatchQueue.main.async { [unowned self] in
            if let _indicatorView = self.view.viewWithTag(475647) {
                _indicatorView.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
                return
            }
            let backgroundView = UIView()
            backgroundView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
            backgroundView.backgroundColor = backgroundColor
            backgroundView.tag = 475647
            
            var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = .gray
            activityIndicator.color = activityColor
            activityIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
            
            backgroundView.addSubview(activityIndicator)
            self.view.addSubview(backgroundView)
        }
        
    }
}
