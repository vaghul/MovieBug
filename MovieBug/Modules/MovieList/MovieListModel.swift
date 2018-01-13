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
	var arrayPopularMovie = [AnyObject]()
	var totalpages:String = "1"
	var currentpage:String = "1"
	var loadmore:Bool = true
	// MARK: -  SuperClass Overrides
	
	override func responceRecieved(_ responce: [String:AnyObject], method: String)
	{
		if method.contains("popularmovies"){
			if method == "popularmovies"{
				if responce["results"] != nil {
					arrayPopularMovie = responce["results"] as! [AnyObject]
				}
				totalpages = String(responce["total_pages"] as! Int)
				Storage.sharedInstance.storeValue(String(responce["total_pages"] as! Int), key: "totalpage")
			}else {
				if responce["results"] != nil {
					let array = responce["results"] as! [AnyObject]
					arrayPopularMovie.append(contentsOf: array)
				}
			}
			currentpage = String(Int(currentpage)!+1)
			loadmore = true
		}
		delegate?.recievedResponce(responce, method: method)
		
	}
	
	override func errorRecieved(_ response: String, method: String)
	{
		loadmore = true
		delegate?.errorResponce(response, method: method)
		
	}
	
	// MARK: -  Custom Method
	
	func fetchFromApi(page:String){
		let param = PopularMoviesRequest()
		param.api_key = constants.API_KEY
		param.page = page
		if param.page == "1"{
			MakeGetRequest(constants.LISTPOPULARMOVIEURL, body: param.convertToDict(), method: "popularmovies")
		}else{
			MakeGetRequest(constants.LISTPOPULARMOVIEURL, body: param.convertToDict(), method: "popularmoviespagination")
		}
	}
}
