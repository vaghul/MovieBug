//
//  ORMSkeleton.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 12/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

class ORMSkeleton: NSObject {

	init(initDict dict: [String:AnyObject]) {
		super.init()
		
		let key = Array(dict.keys)
		for val in key {
			if self.responds(to: Selector(val)){
				if dict[val] is String{
					self.setValue(dict[val], forKey: val)
				}else if dict[val] is NSArray{
					self.setValue(dict[val], forKey: val)
				}else if dict[val] is NSDictionary{
					self.setValue(dict[val], forKey: val)
				}else if dict[val] is NSNumber{
					self.setValue(dict[val], forKey: val)
				}
			}
		}
		
		
	}
	override init() {
		super.init()
		
	}
	
	func convertToDict() -> [String:AnyObject] {
		let mirrorval = Mirror(reflecting: self)
		var dict = [String:AnyObject]()
		//mirrorval.children.count
		for (_, attr) in mirrorval.children.enumerated() {
			if let property_name = attr.label as String! {
				if attr.value is String {
					dict[property_name] = attr.value as? String as AnyObject?
				}else{
					dict[property_name] = attr.value as? [AnyObject] as AnyObject?
				}
			}
			
			
		}
		return dict
	}
}

