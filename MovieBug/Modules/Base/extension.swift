//
//  extensions.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 12/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

extension UIView{
	func calculateOffSetY() -> CGFloat{
		return self.getHeight() + self.getY()
	}
	func calculateOffSetX() -> CGFloat{
		return self.getWidth() + self.getX()
	}
	func getWidth() -> CGFloat {
		return self.frame.size.width
	}
	func getHeight() -> CGFloat {
		return self.frame.size.height
	}
	func getX() -> CGFloat {
		return self.frame.origin.x
	}
	func getY() -> CGFloat {
		return self.frame.origin.y
	}
	func getAppDelegate() -> AppDelegate {
		return UIApplication.shared.delegate as! AppDelegate
	}
}

extension UILabel{
	func setAttributes(_ fontFamily:String,fontSize:CGFloat,textColor:UIColor,textAlignment:NSTextAlignment){
		self.font = UIFont(name: fontFamily, size: fontSize)
		self.textColor = textColor
		self.textAlignment = textAlignment
	}
	func setTextWithSpacing(_ value:String,space:Double){
		let text = NSMutableAttributedString(string: value)
		text.addAttribute(NSAttributedStringKey.kern, value: NSNumber(value: space as Double), range: NSMakeRange(0, text.length))
		self.attributedText = text
	}
}
extension UIButton{
	func setAttributes(_ fontFamily:String,fontSize:CGFloat,textColor:UIColor){
		self.titleLabel?.font = UIFont(name: fontFamily, size: fontSize)
		self.setTitleColor(textColor, for: UIControlState())
		self.setTitleColor(.white, for: .highlighted)
	}
}

extension Dictionary {
	
	/// Build string representation of HTTP parameter dictionary of keys and objects
	///
	/// This percent escapes in compliance with RFC 3986
	///
	/// http://www.ietf.org/rfc/rfc3986.txt
	///
	/// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
	
	func stringFromHttpParameters() -> String {
		let parameterArray = self.map { (key, value) -> String in
			let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
			let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
			return "\(percentEscapedKey)=\(percentEscapedValue)"
		}
		
		return parameterArray.joined(separator: "&")
	}
	
}
extension String {
	
	/// Percent escapes values to be added to a URL query as specified in RFC 3986
	///
	/// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
	///
	/// http://www.ietf.org/rfc/rfc3986.txt
	///
	/// :returns: Returns percent-escaped string.
	
	func addingPercentEncodingForURLQueryValue() -> String? {
		let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
		
		return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
	}
	
}

extension UIImageView {
	
	func MakeViewRounded(){
		self.layer.cornerRadius = 5.0
	}
}


