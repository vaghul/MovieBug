//
//  MovieListTableViewCell.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 13/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

	private var imageThumb:UIImageView!
	private var labelTitle:UILabel!
	private var labelRating:UILabel!
	private var labelReleaseDate:UILabel!
	private var labelOverview:UILabel!
	private var lineDivider:UIView!
	var CellIndex:IndexPath!

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.onCreate()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func onCreate(){
		
		imageThumb = UIImageView()
		imageThumb.clipsToBounds = true
		imageThumb.contentMode = .scaleAspectFit

		imageThumb.MakeViewRounded()
		contentView.addSubview(imageThumb)
		
		labelTitle = UILabel()
		labelTitle.numberOfLines = 2
		labelTitle.setAttributes(Macros.sharedInstance.FontSemiBold1, fontSize: Macros.sharedInstance.FontSize15, textColor: .black, textAlignment: .left)
		contentView.addSubview(labelTitle)
		
		labelRating = UILabel()
		labelRating.setAttributes(Macros.sharedInstance.FontRegular1, fontSize: Macros.sharedInstance.FontSize12, textColor: Macros.sharedInstance.colorWarmGray, textAlignment: .left)
		contentView.addSubview(labelRating)
		
		labelReleaseDate = UILabel()
		labelReleaseDate.setAttributes(Macros.sharedInstance.FontRegular1, fontSize: Macros.sharedInstance.FontSize12, textColor: Macros.sharedInstance.colorWarmGray, textAlignment: .left)
		contentView.addSubview(labelReleaseDate)
		
		labelOverview = UILabel()
		labelOverview.numberOfLines = 0
		labelOverview.setAttributes(Macros.sharedInstance.FontRegular1, fontSize: Macros.sharedInstance.FontSize15, textColor: .black, textAlignment: .left)
		labelOverview.isHidden = true
		contentView.addSubview(labelOverview)
		
		lineDivider = UIView()
		lineDivider.backgroundColor = UIColor.lightGray
		contentView.addSubview(lineDivider)
		
	}
	func setCellValue(object:PopularMovieORM,showfull:Bool){
		labelTitle.setTextWithSpacing(object.title, space: 0.2)
		labelRating.setTextWithSpacing("Rating : \(object.vote_average)", space: 0.1)
		labelReleaseDate.setTextWithSpacing("Released on \(object.release_date)", space: 0.1)
		labelOverview.setTextWithSpacing(object.overview, space: 0.2)
		labelOverview.isHidden = !showfull
	}
	func setCellThubmailImage(image:UIImage){
		imageThumb.image = image
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		imageThumb.frame = CGRect(x: calculatePercentWidth(6), y: calculatePercentHeight(6) , width: calculatePercentWidth(96), height: calculatePercentHeight(96))
		
		var size = labelTitle.sizeThatFits(CGSize(width: self.getWidth()-(imageThumb.calculateOffSetX() + calculatePercentWidth(5)), height: CGFloat.greatestFiniteMagnitude))
		labelTitle.frame = CGRect(x: imageThumb.calculateOffSetX() + calculatePercentWidth(5), y: imageThumb.getY(), width: self.getWidth() - (imageThumb.calculateOffSetX() + calculatePercentWidth(5)), height: size.height)
		
		labelRating.frame = CGRect(x: imageThumb.calculateOffSetX() + calculatePercentWidth(5), y: labelTitle.calculateOffSetY() + calculatePercentHeight(5), width: self.getWidth() - (imageThumb.calculateOffSetX() + calculatePercentWidth(5)), height: 20)
		
		labelReleaseDate.frame = CGRect(x: imageThumb.calculateOffSetX() + calculatePercentWidth(5), y: labelRating.calculateOffSetY() + calculatePercentHeight(5), width: self.getWidth() - (imageThumb.calculateOffSetX() + calculatePercentWidth(5)), height: 18)
		
		size = labelOverview.sizeThatFits(CGSize(width: self.getWidth()-calculatePercentWidth(12), height: CGFloat.greatestFiniteMagnitude))
		labelOverview.frame = CGRect(x: calculatePercentWidth(6), y: imageThumb.calculateOffSetY() + calculatePercentHeight(6), width: self.getWidth() - calculatePercentWidth(12), height: size.height)
		
		lineDivider.frame = CGRect(x: calculatePercentWidth(16), y: self.getHeight() - 1, width: self.getWidth() - calculatePercentWidth(32), height: 1)
	}
}
