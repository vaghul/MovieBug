//
//  PopularMoviesRequest.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 12/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

class PopularMoviesRequest: ORMSkeleton {
	
	var sort_by:String = "popularity.desc"
	var api_key:String = ""
	var page:String = ""

}
