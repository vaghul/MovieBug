//
//  MovieListViewController.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 12/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

class MovieListViewController: BaseViewController {
	
	var model: MovieListModel!
	var myView: MovieListView! { return self.view as! MovieListView }
	var expandedCell:IndexPath = IndexPath(row: -1, section: 0)
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view = MovieListView(frame:  UIScreen.main.bounds)
		model = MovieListModel()
		model?.delegate = self
		//myView?.delegate = self
		startLoading()
	}
	
	func startLoading(){
		model.fetchFromApi(page: "1")
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
	}
}
