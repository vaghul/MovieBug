//
//  MovieListModel.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 12/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

// MARK: -  Delegate Protocol

protocol MovieListModelDelegate: class {
	
	func recievedResponce(_ value: [String:AnyObject], method: String)
	func errorResponce(_ value: String, method: String)
	
}

class MovieListModel: BaseModel {
	weak var delegate: MovieListModelDelegate?
	
	// MARK: -  SuperClass Overrides
	
	override func responceRecieved(_ responce: [String:AnyObject], method: String)
	{
		
		delegate?.recievedResponce(responce, method: method)
		
	}
	
	override func errorRecieved(_ response: String, method: String)
	{
		delegate?.errorResponce(response, method: method)
		
	}
	
	// MARK: -  Custom Method
	
	func fetchFromApi(page:String){
		let param = PopularMoviesRequest()
		param.api_key = constants.API_KEY
		param.page = page
		MakeGetRequest(constants.LISTPOPULARMOVIEURL, body: param.convertToDict(), method: "popularmovies")
	}
}
