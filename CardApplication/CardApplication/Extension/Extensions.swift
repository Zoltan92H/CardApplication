//
//  Extensions.swift
//  CardApplication
//
//  Created by Hidegkuti Zoltán on 2020. 12. 23..
//


import UIKit
import RxCocoa
import RxSwift


extension UIView {

	func center(inView view: UIView, yConstant: CGFloat? = 0) {
		translatesAutoresizingMaskIntoConstraints = false
		centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
	}

	func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
		translatesAutoresizingMaskIntoConstraints = false
		centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

		if let topAnchor = topAnchor {
			self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
		}
	}



	@IBInspectable var borderColor: UIColor? {
		get {
			return layer.borderColor.map { UIColor(cgColor: $0) }
		}
		set {
			layer.borderColor = newValue?.cgColor
		}
	}

	@IBInspectable var borderWidth: CGFloat {
		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}

	@IBInspectable var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = newValue > 0
		}
	}

	public func roundCorners(corners: UIRectCorner, radius: CGFloat = 8.0) {
		let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		layer.mask = mask
	}

	func roundCorners(_ radius: CGFloat = 8.0) {
		layer.cornerRadius = radius
		layer.masksToBounds = true
	}

	func roundView() {
		layer.cornerRadius = frame.height / 2.0
		layer.masksToBounds = true
	}

	func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) {

		translatesAutoresizingMaskIntoConstraints = false

		if let top = top {
			self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
		}
		if let left = left {
			self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
		}
		if let bottom = bottom {
			bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
		}
		if let right = right {
			rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
		}
		if width != 0 {
			widthAnchor.constraint(equalToConstant: width).isActive = true
		}
		if height != 0 {
			heightAnchor.constraint(equalToConstant: height).isActive = true
		}
	}





	struct AppColors {
		static let Blue = #colorLiteral(red: 0.09653385729, green: 0.1728331447, blue: 0.3025096357, alpha: 1)
		static let Red = #colorLiteral(red: 0.8352941176, green: 0.3921568627, blue: 0.3137254902, alpha: 1)
		static let OffWhite = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		static let lightGray = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		static let new = #colorLiteral(red: 0.3756349087, green: 0.7255837917, blue: 0.8688918948, alpha: 1)
		static let lightGreen = UIColor(rgb: 0xabcc67)
		static let darkGreen = UIColor(rgb: 0x76923c)
	}



}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
	   assert(red >= 0 && red <= 255, "Invalid red component")
	   assert(green >= 0 && green <= 255, "Invalid green component")
	   assert(blue >= 0 && blue <= 255, "Invalid blue component")

	   self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }



   convenience init(rgb: Int) {
	   self.init(
		   red: (rgb >> 16) & 0xFF,
		   green: (rgb >> 8) & 0xFF,
		   blue: rgb & 0xFF
	   )
   }
}

extension UITextView {

	func centerVertically() {
		let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
		let size = sizeThatFits(fittingSize)
		let topOffset = (bounds.size.height - size.height * zoomScale) / 2
		let positiveTopOffset = max(1, topOffset)
		contentOffset.y = -positiveTopOffset
	}

}

extension DateFormatter {
	static let dayDate: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter
	}()
}
