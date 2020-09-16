//
//  NewsCell.swift
//  ImageLoader
//
//  Created by Vlad on 16.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell { // Объявление класса ячейки CollectionView
    
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Content: UILabel!
    @IBOutlet weak var Link: UILabel!
    
    override func awakeFromNib() { // Увеличение размеров полей вывод
        super.awakeFromNib()
        Title.lineBreakMode = .byWordWrapping
        Title.numberOfLines = 0
        Content.lineBreakMode = .byWordWrapping
        Content.numberOfLines = 0
        Link.lineBreakMode = .byWordWrapping
        Link.numberOfLines = 0
    }
    
    func setUpCell(article: Article){ // Метод для вывода данных
        self.Title.text = article.Title
        self.Content.text = ReStr(string: article.Content)
        self.Link.text = article.Link
    }
    
    func ReStr(string : String) -> String{ // Функция очищает инфу из json от лишних ' ' и /n
        var str = string
        while str.last == " " || str.first == "/" || str.first == "n"{
            str.removeLast()
        }
        while str.first == " " || str.first == "/" || str.first == "n"{
            str.removeFirst()
        }
        return str
    }
    
}
