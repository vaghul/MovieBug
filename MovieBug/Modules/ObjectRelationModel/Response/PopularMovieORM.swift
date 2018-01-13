//
//  PopularMovieORM.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 12/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

class PopularMovieORM: ORMSkeleton {
	
	@objc var id:Int = -1
	@objc var vote_average:Int = -1
	@objc var title:String = ""
	@objc var popularity:Int = -1
	@objc var poster_path:String = ""
	@objc var backdrop_path:String = ""
	@objc var overview:String = ""
	@objc var release_date:String = ""
	@objc var page:String = ""
}
