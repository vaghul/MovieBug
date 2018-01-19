//
//  Macros.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 12/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

class Macros: NSObject {
	
	static let sharedInstance = Macros()
	let API_KEY:String = "9f1757537f4996a14e1ac730ad6e6153"
	let THUMBIMAGEPREFIX:String = "https://image.tmdb.org/t/p/w92"
	let POSTERIMAGEPREFIX:String = "https://image.tmdb.org/t/p/w300"
	let LISTPOPULARMOVIEURL:String = "http://api.themoviedb.org/3/discover/movie"
	let PARAMKEYSORT:String = "sort_by"
	let PARAMVALUESORT:String = "popularity.desc"
	let PARAMKEYAPI:String = "api_key"
	let PARAMKEYPAGE:String = "page"
	let FontRegular1: String = "SFUIText-Regular"
	let FontSemiBold1: String = "SFUIText-Semibold"
	let FontMedium1: String = "SFUIText-Medium"
	let FontSize12: CGFloat = 12.0
	let FontSize15: CGFloat = 15.0
	let colorWarmGray: UIColor = UIColor(red: 117.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1)
	let colorPaleGray: UIColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1)
	let appDelegatevalue = UIApplication.shared.delegate as! AppDelegate

}
