//
//  MovieListView.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 12/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

protocol MovieListViewDelegate: class {
	func onClickRefresh()
}

class MovieListView: BaseView {

	weak var delegate: MovieListViewDelegate!
	var tableMovieList: CustomLoaderTable!
	var refreshControl:UIRefreshControl!

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.onCreate()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func onCreate() {
		super.onCreate()
		
		tableMovieList = CustomLoaderTable()
		tableMovieList.register(MovieListTableViewCell.self, forCellReuseIdentifier: "MovieCell")
		tableMovieList.separatorStyle = .none
		tableMovieList.decelerationRate = UIScrollViewDecelerationRateFast
		refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)

		addSubview(tableMovieList)
	}
	@objc func refresh(_ refreshControl: UIRefreshControl) {
		delegate?.onClickRefresh()
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		
		tableMovieList.frame = CGRect(x: 0, y: getSafeAreaTop(), width: self.getWidth(), height: self.getHeight() - getSafeAreaTop() - getSafeAreaBottom())
	}
}
