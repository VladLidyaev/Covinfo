//
//  NewsViewController.swift
//  ImageLoader
//
//  Created by Vlad on 15.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit
import Foundation

struct Article : Decodable{
    var Title : String
    var Link : String
    var Content : String
    var Timestamp : String
    
    init(dictionary : Dictionary<String,Any>){
        Title = dictionary["Title"] as? String ?? ""
        Link = dictionary["Link"] as? String ?? ""
        Content = dictionary["Content"] as? String ?? ""
        Timestamp = dictionary["Timestamp"] as? String ?? ""
    }
}

class NewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBAction func UpDAte(_ sender: UIButton) {
        GetJson()
        ParseNews()
        self.collectionView.reloadData()
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    var articles : [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "NewsCell")
        self.collectionView.dataSource = self
        GetJson()
        ParseNews()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (articles.count)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let article = articles[indexPath.row]
        cell.setUpCell(article: article)
        return cell
    }
    
    
    func GetJson(){
        guard let url = URL(string: "http://127.0.0.1:8000/articles") else { return  }
        let session = URLSession(configuration: .default)
        
        let downloadTask = session.downloadTask(with: url) { (urlFile, responce, error) in
            if urlFile != nil{
                let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
                let urlPath = URL(fileURLWithPath: path)
                try? FileManager.default.copyItem(at: urlFile ?? url, to: urlPath)
                
            }
        }
        downloadTask.resume()
    }
    
    func ParseNews(){
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
        let urlPath = URL(fileURLWithPath: path)
        
        let data = try? Data(contentsOf: urlPath)
        let array = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Dictionary<String,Any>] ?? []
        var returnArray : [Article] = []
        for dict in array!{
            let newArticle = Article(dictionary: dict)
            returnArray.append(newArticle)
        }
        articles = returnArray
    }
    
    
}















//        self.CollectionView.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "NewsCell")
//        self.CollectionView.dataSource = self
//        self.CollectionView.delegate = self
//        print(GetJson(Number: 1, Element: 1))



//    func ReStr(string : String) -> String{
//        var str = string
//        while str.last == " " || str.first == "/" || str.first == "n"{
//            str.removeLast()
//        }
//        while str.first == " " || str.first == "/" || str.first == "n"{
//            str.removeFirst()
//        }
//        return str
//    }

//    func GetJson(Number : Int, Element : Int) -> (String){
//        var json = [New]()
//        let str = ""
//        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!2")
//        guard let url = URL(string: "http://127.0.0.1:8000/articles") else {return "123"}
//        let session = URLSession.shared
//        session.dataTask(with: url) { ( data, responce, error) in
//            guard let data = data else {return}
//            do {
//                json = try JSONDecoder().decode([New].self, from: data)
////                print(self.ReStr(string: json[1].Link!))
////                print(self.ReStr(string: json[Number-1].Title!))
//            }
//            catch {
//                print (error)
//            }
//        }.resume()
//        return str
//        }



//    func convertAnyObjectToJSONString(from object:Any) -> String? {
//    guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
//        return nil
//    }
//        return String(data: data, encoding: String.Encoding.utf8)}

//}

//extension NewsViewController : UICollectionViewDataSource, UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath)
//        let article = articles[indexPath]
//        Text.text = article.Title
//        return cell
//    }
//}
//
//
//}
