//
//  GraphViewController.swift
//  ImageLoader
//
//  Created by Vlad on 14.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    var TextOfLabel : [String] = [""]

    @IBOutlet weak var SubText: UILabel!
    
    @IBOutlet weak var S1: UILabel!
    @IBOutlet weak var S2: UILabel!
    @IBOutlet weak var S3: UILabel!
    @IBOutlet weak var S4: UILabel!
    @IBOutlet weak var S5: UILabel!
    @IBOutlet weak var S6: UILabel!
    @IBOutlet weak var S7: UILabel!
    @IBOutlet weak var S8: UILabel!
    @IBOutlet weak var S9: UILabel!
    @IBOutlet weak var S10: UILabel!
    
    @IBOutlet weak var TextOutput: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateGraph()
        TextOutputGo()
    }
    
    @IBAction func UpDate(_ sender: UIButton) {
        UpdateGraph()
    }
    
    func TextOutputGo() -> (){
        var Text : String
        Text = "Данные (за 10 предыдущих дней). На диаграме представлен прирост числа зараженных в данном регионе. Общее число зараженных в данном регионе: \n"
        for i in 1...10{
            Text += "\(i) : " + TextOfLabel[i-1] + "\n"
        }
        TextOutput.text = Text
    }
    
    func UpdateGraph() -> (){
        var a = 0
        S1.frame = CGRect(x: GetCoord(Number: a, TextArray: TextOfLabel).0 , y: GetCoord(Number: a, TextArray: TextOfLabel).1, width: GetCoord(Number: a, TextArray: TextOfLabel).2, height: GetCoord(Number: a, TextArray: TextOfLabel).3)
        
        a = 1
        S2.frame = CGRect(x: GetCoord(Number: a, TextArray: TextOfLabel).0 , y: GetCoord(Number: a, TextArray: TextOfLabel).1, width: GetCoord(Number: a, TextArray: TextOfLabel).2, height: GetCoord(Number: a, TextArray: TextOfLabel).3)
        
        a = 2
        S3.frame = CGRect(x: GetCoord(Number: a, TextArray: TextOfLabel).0 , y: GetCoord(Number: a, TextArray: TextOfLabel).1, width: GetCoord(Number: a, TextArray: TextOfLabel).2, height: GetCoord(Number: a, TextArray: TextOfLabel).3)
        
        a = 3
        S4.frame = CGRect(x: GetCoord(Number: a, TextArray: TextOfLabel).0 , y: GetCoord(Number: a, TextArray: TextOfLabel).1, width: GetCoord(Number: a, TextArray: TextOfLabel).2, height: GetCoord(Number: a, TextArray: TextOfLabel).3)
        
        a = 4
        S5.frame = CGRect(x: GetCoord(Number: a, TextArray: TextOfLabel).0 , y: GetCoord(Number: a, TextArray: TextOfLabel).1, width: GetCoord(Number: a, TextArray: TextOfLabel).2, height: GetCoord(Number: a, TextArray: TextOfLabel).3)
        a = 5
        S6.frame = CGRect(x: GetCoord(Number: a, TextArray: TextOfLabel).0 , y: GetCoord(Number: a, TextArray: TextOfLabel).1, width: GetCoord(Number: a, TextArray: TextOfLabel).2, height: GetCoord(Number: a, TextArray: TextOfLabel).3)
        a = 6
        S7.frame = CGRect(x: GetCoord(Number: a, TextArray: TextOfLabel).0 , y: GetCoord(Number: a, TextArray: TextOfLabel).1, width: GetCoord(Number: a, TextArray: TextOfLabel).2, height: GetCoord(Number: a, TextArray: TextOfLabel).3)
        a = 7
        S8.frame = CGRect(x: GetCoord(Number: a, TextArray: TextOfLabel).0 , y: GetCoord(Number: a, TextArray: TextOfLabel).1, width: GetCoord(Number: a, TextArray: TextOfLabel).2, height: GetCoord(Number: a, TextArray: TextOfLabel).3)
        a = 8
        S9.frame = CGRect(x: GetCoord(Number: a, TextArray: TextOfLabel).0 , y: GetCoord(Number: a, TextArray: TextOfLabel).1, width: GetCoord(Number: a, TextArray: TextOfLabel).2, height: GetCoord(Number: a, TextArray: TextOfLabel).3)
        a = 9
        S10.frame = CGRect(x: GetCoord(Number: a, TextArray: TextOfLabel).0 , y: GetCoord(Number: a, TextArray: TextOfLabel).1, width: GetCoord(Number: a, TextArray: TextOfLabel).2, height: GetCoord(Number: a, TextArray: TextOfLabel).3)
    }
    
    func GetCoord(Number : Int, TextArray: [String]) -> (Int,Int,Int,Int){
        
        func StrToInt(str: [String]) -> [Int]{
            var IntArray : [Int] = [0,0,0,0,0,0,0,0,0,0]
            for i in 0..<str.count{
                autoreleasepool{
                    IntArray[i] = Int(str[i]) ?? 0
                }}
            return IntArray}
        
        func NewMass(array: [Int]) -> ([Int]){
            var min = array[0]
            var New : [Int] = [0,0,0,0,0,0,0,0,0,0]
            for i in 0..<array.count{
                autoreleasepool{
                    New[i] = (array[i] - min)
                    min = array[i]
                }}
            return New}
        
        func GetMax(Array: [Int]) -> (Int){
            var Max = 0
            for i in 0..<Array.count{
                autoreleasepool{
                    if Array[i]>Max{
                        Max = Array[i]
                    }}
            }
            if Max == 0{
                Max = 1
            }
            return Max}
        
        let Array = NewMass(array: StrToInt(str: TextArray).reversed())

        let X = Number*29
        let wight = 27
        let height = (((Array[Number])*150) / GetMax(Array: Array)) + 10
        let Y = (160 - height)
        
        return(X,Y,wight,height)
    }
}
