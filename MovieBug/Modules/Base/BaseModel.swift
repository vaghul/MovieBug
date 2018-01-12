//
//  BaseModel.swift
//  MovieBug
//
//  Created by Vaghula krishnan on 12/01/18.
//  Copyright © 2018 rentamojo. All rights reserved.
//

import UIKit

class BaseModel: NSObject {


	
	func MakeGetRequest(_ urlstring:String,body:[String:AnyObject],method:String) 	{
		
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
		
		let param = body.stringFromHttpParameters()
		var request = URLRequest(url: URL(string: "\(urlstring)?\(param)")!)
		request.httpMethod = "GET"
		//		request.setValue("6d9f729b765aae27f45e5ef9150fa073f8a61b94", forHTTPHeaderField: "X-AUTHORIZATION")
		do{
			request.timeoutInterval = 60.0
			let session = URLSession(configuration: URLSessionConfiguration.default)
			
			let task:URLSessionDataTask = session.dataTask(with: request, completionHandler: {(
				data , response, error) in
				
				DispatchQueue.main.async(execute: {
					UIApplication.shared.isNetworkActivityIndicatorVisible = false
					if((error == nil)){
						let httpresp:HTTPURLResponse = (response as? HTTPURLResponse)!
						if(httpresp.statusCode==200){
							do{
								let respdata = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
								print("============Web Response==============")
								print(respdata)
								print("======================================")
							}catch{
								print("error \(error)")
								print("Parsing Error");
								self.errorRecieved("error",method: method)
							}
						}else{ // end of status code
							print("status code failure");
							self.errorRecieved("statusfailed",method: method)
						}
					}else{ // end of error
						self.errorRecieved("requestfailed",method: method)
					}
					
				}) // end of main thread
				
			}) // end of session task
			
			task.resume()
		}
		
	} // end of function
	
	func getImageDataFromUrl(_ urlstring:String, completion: @escaping ((_ data: Data?, _ response: URLResponse?, _ error: NSError? ) -> Void)) {
		if urlstring != "" {
			let url = URL(string: urlstring)
			if ImageCache.sharedInstance.hasCacheForKey(urlstring){
				completion(ImageCache.sharedInstance.getCacheForKey(urlstring), nil, nil)
				return
			}
			URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
				if error == nil{
					let httpResponse = response as! HTTPURLResponse
					if httpResponse.statusCode != 200 {
						completion(Data(), response, nil)
					}else{ // end of statuscode
						ImageCache.sharedInstance.setCacheForKey(urlstring, data: data!)
						completion(data, response, error as NSError?)
					}
				}else{ // end of error check
					completion(nil, nil, error as NSError?)
				}
			}).resume()
		} // end of urlstring check
	} // end of function
	
	
	// MARK: - Custom Methods
	
	func convertToData(_ body:NSDictionary) -> NSMutableData {
		let postData = NSMutableData()
		var val:Int = 0
		for (key, value) in body {
			if(val == 0){
				let datastring:String = (key as! String) + "=" + (value as! String)
				postData.append(datastring.data(using: String.Encoding.utf8)!)
				val = 1
			}else{
				let datastring:String = "&"+(key as! String) + "=" + (value as! String)
				postData.append(datastring.data(using: String.Encoding.utf8)!)
			}
		}
		return postData
	}
	func responceRecieved(_ response :[String:AnyObject],method:String)
	{
		
	}
	func errorRecieved(_ response :String,method:String)
	{
		print("error \(response)")
	}
}
