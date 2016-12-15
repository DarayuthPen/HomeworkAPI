//
//  ArticleTableViewController.swift
//  HomeworkAPI
//
//  Created by Pen DaraYuth on 13/12/16.
//  Copyright © 2016 Pen DaraYuth. All rights reserved.
//

import UIKit
import Alamofire

class ArticleTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
//        self.tableView.delegate = self
//        self.tableView.dataSource = self

        getAllData()
        //postData()
        
    }
    
    func getAllData(){
        
        let url = "http://120.136.24.174:1301/v1/api/articles?page=1&limit=15"
    
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="]).responseJSON { (response) in
            
            if response.result.value != nil{
                
                
                
                print("Success")
                print(response.result.value!)
            }else{
                print("Fail")
                print(response.result.error!)
            }

            
        }
        
    }
    

    
    
//    func getAllData(){
//        
//        let url = URL(string: "http://120.136.24.174:1301/v1/api/articles?page=1&limit=15")!
//
//        var request = URLRequest(url:url)
//        request.setValue("Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=", forHTTPHeaderField: "Authorization")
//        request.httpMethod = "GET"
//        
//        let getTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if error != nil{
//                print(error!)
//            }else{
//                
//                if let urlContent = data{
//                    do{
//                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
//                        
//                        print(jsonResult)
//                       
//                        
//                        
//                        //                      print(jsonResult["name"]!!)
//                        
//                        //                        let weathers = jsonResult["weather"] as! [Any]
//                        //                        let weather = weathers[0] as! [String: Any]
//                        //                        let id = weather["id"] as! Int
//                        //                        print(id)
//                        
//                        //                        let weather = jsonResult["weather"] as! [Any]
//                        //                        let item1 = weather[1] as! [String: Any]
//                        //                        let item2 = item1["description"] as! String
//                        //                        print(item2)
//                        
//                    }catch{
//                        print("JSON Processing Failed")
//                    }
//                }
//            }
//        }
//        getTask.resume()
//    }
    
//    func postData(){
//        
//        let url = URL(string: "http://120.136.24.174:1301/v1/api/articles")!
//        
//        var request = URLRequest(url:url)
//        request.setValue("Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        request.httpMethod = "POST"
//        
//        let postString = ["TITLE": "Chair", "DESCRIPTION":"Wood", "AUTHOR":1, "CATEGORY_ID":1, "STATUS": 1, "IMAGE": "123456789.jpg"] as [String : Any]
//        
//        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options: [])
//        
//        let postTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            if error != nil{
//                print(error!)
//            }else{
//                print(data!)
//                print(response!)
//            }
//            
//        }
//        postTask.resume()
//    }
//
//    
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       
//        return 1
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
//
//
//        return cell
//    }
    

    
}
