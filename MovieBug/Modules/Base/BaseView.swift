//
//  BaseView.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 12/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

class BaseView: UIView {
	private var overlayView:UIView!
	private var myActivityIndicator:UIActivityIndicatorView!
	private var viewInternetConnevtivity:UIView!
	private var labelInternetConnevtivity:UILabel!

	func onCreate(){
		self.backgroundColor = .white
		overlayView = UIView()
		overlayView.clipsToBounds = true
		overlayView.layer.zPosition = 1
		myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
		myActivityIndicator.activityIndicatorViewStyle = .gray
		
		overlayView.addSubview(myActivityIndicator)
		
		viewInternetConnevtivity = UIView()
		viewInternetConnevtivity.backgroundColor = UIColor.lightGray
		viewInternetConnevtivity.isOpaque = true
		
		labelInternetConnevtivity = UILabel()
		labelInternetConnevtivity.text = "No internet connection"
		labelInternetConnevtivity.textColor = .white
		labelInternetConnevtivity.textAlignment = .center
		labelInternetConnevtivity.alpha = 0.0
		viewInternetConnevtivity.addSubview(labelInternetConnevtivity)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		overlayView.frame = CGRect(x: 0, y: 0, width: self.getWidth(), height: self.getHeight())
		myActivityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
		
		viewInternetConnevtivity.frame = CGRect(x: 0, y: getSafeAreaTop(), width: self.getWidth(), height: calculatePercentHeight(60))
		labelInternetConnevtivity.frame = CGRect(x: 0, y: 0, width: viewInternetConnevtivity.frame.size.width, height: calculatePercentHeight(60))

	}
	
	func showLoader(){
		self.alpha = 0.8
		overlayView.layer.zPosition = 10
		getAppDelegate().window?.addSubview(overlayView)
		myActivityIndicator.startAnimating()
	}
	func removeLoader(){
		self.alpha = 1.0
		myActivityIndicator.stopAnimating()
		overlayView.removeFromSuperview()
	}
	
	func internetAvailable(_ flag:Bool){
		if flag{
			labelInternetConnevtivity.alpha = 0.0
			viewInternetConnevtivity.removeFromSuperview()
			labelInternetConnevtivity.removeFromSuperview()
		}else{
			viewInternetConnevtivity.addSubview(labelInternetConnevtivity)
			addSubview(viewInternetConnevtivity)
			labelInternetConnevtivity.alpha = 1.0
		}
	}
	
	func calculatePercentWidth(_ val:CGFloat) -> CGFloat {
		let width = UIScreen.main.bounds.width
		return ((width * ((val * 100) / 375))/100)
	}
	
	func calculatePercentHeight(_ val:CGFloat) -> CGFloat {
		let height = UIScreen.main.bounds.height
		return ((height * ((val * 100) / 667))/100)
	}
	
	func getSafeAreaTop()-> CGFloat{
		if #available(iOS 11.0, *) {
			return self.safeAreaInsets.top
		} else {
			// Fallback on earlier versions
			return 0.0
		}
	}
	
	func getSafeAreaBottom()-> CGFloat{
		if #available(iOS 11.0, *) {
			return self.safeAreaInsets.bottom
		} else {
			// Fallback on earlier versions
			return 0.0
		}
	}
	
}
