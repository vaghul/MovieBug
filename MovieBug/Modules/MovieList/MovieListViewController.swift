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
	var dbhelper:DatabaseHelper!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view = MovieListView(frame:  UIScreen.main.bounds)
		model = MovieListModel()
		model?.delegate = self
		dbhelper = DatabaseHelper()
		dbhelper.initDatabase()
		NotificationCenter.default.addObserver(self, selector: #selector(internetConnectionChanged), name: NSNotification.Name(rawValue: "INTERNET"), object: nil)

		//myView?.delegate = self
		startLoading()
	}
	
	func startLoading(){
		let val = dbhelper.getDetails()
		if val?.count == 0 {
			if (self.myView.constants.appDelegatevalue.networkstatus == .notReachable || self.myView.constants.appDelegatevalue.networkstatus == .unknown) {
				self.myView.internetAvailable(false)
				showAlert(title: "No internet Connection", message: "Please check your internet connection")
			}else{
				self.myView.internetAvailable(true)
				myView.showLoader()
				model.fetchFromApi(page: "1")
			}
		}else{
			if Storage.sharedInstance.isValueStored(key: "currentpage"){
				model.currentpage = Storage.sharedInstance.retriveValue(key: "currentpage")
			}
			model.arrayPopularMovie = val! as [AnyObject]
			myView.tableMovieList.delegate = self
			myView.tableMovieList.dataSource = self
			myView.tableMovieList.reloadData()
			myView.tableMovieList.LoadedRows = model.arrayPopularMovie.count

		}
	}
	@objc func internetConnectionChanged(){
		DispatchQueue.main.async {
			if (self.myView.constants.appDelegatevalue.networkstatus == .notReachable || self.myView.constants.appDelegatevalue.networkstatus == .unknown) {
				self.myView.internetAvailable(false)
			}else{
				self.myView.internetAvailable(true)
				//self.loadScreenData()
			}
		}
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
