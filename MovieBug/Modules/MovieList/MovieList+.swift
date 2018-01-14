//
//  MovieList+.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 12/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

extension MovieListViewController:MovieListViewDelegate{
	
	func onClickRefresh() {
		startLoading()
	}
}
extension MovieListViewController: MovieListModelDelegate{
	
	func recievedResponce(_ value: [String : AnyObject], method: String) {
		if method == "popularmovies"{
			myView.removeLoader()
			myView.tableMovieList.delegate = self
			myView.tableMovieList.dataSource = self
			myView.tableMovieList.reloadData()
			for i in 0..<model.arrayPopularMovie.count {
				let dict = PopularMovieORM(initDict: model.arrayPopularMovie[i] as! [String:AnyObject])
				dict.page = model.currentpage
				dbhelper.savePoints(dict.convertToDict() as [AnyHashable : Any])
			}
		}else{
			if model.arrayPopularMovie.count > myView.tableMovieList.LoadedRows {
				var array = [IndexPath]()
				for i in myView.tableMovieList.LoadedRows..<model.arrayPopularMovie.count {
					array.append(IndexPath(item: i, section: 0))
					let dict = PopularMovieORM(initDict: model.arrayPopularMovie[i] as! [String:AnyObject])
					dict.page = model.currentpage
					dbhelper.savePoints(dict.convertToDict() as [AnyHashable : Any])
				}
				
				if array.count > 0{
					myView.tableMovieList.beginUpdates()
					myView.tableMovieList.insertRows(at: array, with: .none)
					myView.tableMovieList.endUpdates()
				}
			}
		}
		Storage.sharedInstance.storeValue(model.currentpage, key: "currentpage")
		myView.tableMovieList.removeLoadMore()
		myView.tableMovieList.LoadedRows = model.arrayPopularMovie.count

	}
	func errorResponce(_ value: String, method: String) {
		
	}
}

extension MovieListViewController: UITableViewDelegate,UITableViewDataSource{
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return model.arrayPopularMovie.count
	}
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let Headerview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.getWidth(), height: 40))
		Headerview.backgroundColor = myView.constants.colorPaleGray
		Headerview.isUserInteractionEnabled = true
		let labelTitle = UILabel(frame: CGRect(x: myView.calculatePercentWidth(16), y:  10, width: self.view.getWidth() , height: 20))
		labelTitle.setAttributes(myView.constants.FontRegular1, fontSize: myView.constants.FontSize15, textColor: myView.constants.colorWarmGray, textAlignment: .left)
		labelTitle.text = "Popular Movies"
		Headerview.addSubview(labelTitle)
		return Headerview
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieListTableViewCell
		let Popularobj = PopularMovieORM(initDict: model.arrayPopularMovie[indexPath.row] as! [String:AnyObject])
		cell.setCellThubmailImage(image: StaticImage.sharedInstance.imagePlaceholder!)
		cell.setCellValue(object: Popularobj,showfull: expandedCell == indexPath)
		cell.CellIndex = indexPath
		let imageurl = "\(myView.constants.THUMBIMAGEPREFIX)\(Popularobj.poster_path)"
		if(Popularobj.poster_path.count > 0){
			model.getImageDataFromUrl(imageurl, completion: { (data, response, error) in
				DispatchQueue.main.async(execute: {
					if error == nil {
						if data != nil {
							if((data?.count)! > 0){
								if(cell.CellIndex == indexPath){
									cell.setCellThubmailImage(image: UIImage(data: data! as Data)!)
								}
							}
						}
					}
				})
			}) // end of getdatafrm url
			
		}
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
	
		if expandedCell == indexPath {
			let imageheight = myView.calculatePercentHeight(96)
			let labeltemp = UILabel()
			labeltemp.numberOfLines = 0
			labeltemp.setAttributes(myView.constants.FontRegular1, fontSize: myView.constants.FontSize15, textColor: myView.constants.colorWarmGray, textAlignment: .left)
			let Popularobj = PopularMovieORM(initDict: model.arrayPopularMovie[indexPath.row] as! [String:AnyObject])
			labeltemp.setTextWithSpacing(Popularobj.overview, space: 0.2)
			let size = labeltemp.sizeThatFits(CGSize(width: myView.getWidth() - myView.calculatePercentWidth(12), height: CGFloat.greatestFiniteMagnitude))
			return imageheight + myView.calculatePercentHeight(12) + myView.calculatePercentHeight(12) + 4 + size.height
		}else{
			let contentheight:CGFloat = 24 + 18 + 18 + myView.calculatePercentHeight(10)
			let imageheight = myView.calculatePercentHeight(96)
			let basevalue = ( imageheight > contentheight ) ? imageheight : contentheight
			
			return basevalue + myView.calculatePercentHeight(12) + 2
		}
	}
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		if expandedCell == indexPath {
			let imageheight = myView.calculatePercentHeight(96)
			let labeltemp = UILabel()
			labeltemp.numberOfLines = 0
			labeltemp.setAttributes(myView.constants.FontRegular1, fontSize: myView.constants.FontSize15, textColor: myView.constants.colorWarmGray, textAlignment: .left)
			let Popularobj = PopularMovieORM(initDict: model.arrayPopularMovie[indexPath.row] as! [String:AnyObject])
			labeltemp.setTextWithSpacing(Popularobj.overview, space: 0.2)
			let size = labeltemp.sizeThatFits(CGSize(width: myView.getWidth() - myView.calculatePercentWidth(12), height: CGFloat.greatestFiniteMagnitude))
			return imageheight + myView.calculatePercentHeight(12) + myView.calculatePercentHeight(12) + 4 + size.height
		}else{
			let contentheight:CGFloat = 24 + 18 + 18 + myView.calculatePercentHeight(10)
			let imageheight = myView.calculatePercentHeight(96)
			let basevalue = ( imageheight > contentheight ) ? imageheight : contentheight
			
			return basevalue + myView.calculatePercentHeight(12) + 2
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let previouspath = expandedCell
		if indexPath == expandedCell {
			expandedCell = IndexPath(row: -1, section: 0)
		}else {
			expandedCell = indexPath
		}
		tableView.reloadRows(at: [previouspath,expandedCell], with: .automatic)
	}
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if (self.myView.constants.appDelegatevalue.networkstatus != .notReachable && self.myView.constants.appDelegatevalue.networkstatus != .unknown) {
			if ((indexPath.row != 0) && (indexPath.row > (model.arrayPopularMovie.count * 80/100)) && (model.currentpage != model.totalpages) && (model.loadmore)) {
				model.loadmore = false
				myView.tableMovieList.addLoadMore()
				model.fetchFromApi(page: model.currentpage)
			}
		}
	}
}


