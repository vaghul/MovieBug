//
//  MovieListView.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 12/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

class MovieListView: BaseView {

	var tableMovieList: CustomLoaderTable!
	
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
		addSubview(tableMovieList)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		tableMovieList.frame = CGRect(x: 0, y: getSafeAreaTop(), width: self.getWidth(), height: self.getHeight() - getSafeAreaTop() - getSafeAreaBottom())
	}
}
