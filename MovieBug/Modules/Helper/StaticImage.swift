//
//  StaticImage.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 13/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

class StaticImage: NSObject {
	static let sharedInstance = StaticImage()
	
	let imagePlaceholder = UIImage(named: "PlaceHolder")

}
