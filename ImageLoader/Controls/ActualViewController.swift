//
//  ViewController.swift
//  ImageLoader
//
//  Created by Vlad on 12.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit
import SwiftSoup

class ActualViewController: UIViewController {
    
    @IBOutlet weak var AppName: UILabel!
    @IBOutlet weak var YourRegionLabel: UILabel!
    @IBOutlet weak var YourLocated: UILabel!{
        didSet{
            self.YourLocated.text = "Москва"
        }
    }
    
    @IBOutlet weak var UpdateButton: UIButton!
    @IBOutlet weak var ChooseRegionButton: UIButton!
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    @IBOutlet weak var StatZarazhLabel: UILabel!
    @IBOutlet weak var TextZarazhLabel: UILabel!
    @IBOutlet weak var StatVizdorovLabel: UILabel!
    @IBOutlet weak var TextVizdorovLabel: UILabel!
    @IBOutlet weak var StatDiedLabel: UILabel!
    @IBOutlet weak var TextDiedLabel: UILabel!
    @IBOutlet weak var WatchGraphButton: UIButton!
    @IBOutlet weak var InfoButton: UIButton!
    @IBOutlet weak var ShareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if SegmentControl.selectedSegmentIndex == 0{ // В зависимости от положения селектора выбираем инфу
            Get_All_Info(text: Get_Region_Stat(region: YourLocated.text ?? "Москва"))
        }
        if SegmentControl.selectedSegmentIndex == 1{
            Get_Today_Info(text: Get_Region_Stat(region: YourLocated.text ?? "Москва"))
        }
        
        let Radius = 15 // Скругление кнопок
        ChooseRegionButton.layer.cornerRadius = CGFloat(Radius)
        InfoButton.layer.cornerRadius = CGFloat(Radius)
        ShareButton.layer.cornerRadius = CGFloat(Radius)
        WatchGraphButton.layer.cornerRadius = CGFloat(Radius)
        UpdateButton.layer.cornerRadius = CGFloat(Radius)
        ChooseRegionButton.titleLabel?.lineBreakMode = .byWordWrapping
        ChooseRegionButton.titleLabel?.numberOfLines = 2
        
        // Получение данных черз NotificationCenter из окна поиска региона
        NotificationCenter.default.addObserver(self, selector: #selector(notiificationReceived), name: Notification.Name("GoGO"), object: nil)
    }
    
    @objc func notiificationReceived(notification : Notification) -> () {
        guard let text = notification.userInfo?["info"] as? String else { return }
        YourLocated.text = text
    }
    
    
    
    @IBAction func ChooseRegionAction(_ sender: UIButton) {
    }
    @IBAction func SegmentAction(_ sender: UISegmentedControl) {
    }
    @IBAction func ShowGraphAction(_ sender: UIButton) {
    }
    @IBAction func InfoAction(_ sender: UIButton) {
    }
    @IBAction func ShareAction(_ sender: UIButton) {
        
        let arrayOfStat = (Get_Region_Stat(region: YourLocated.text ?? "Москва")).split(separator: " ")
        
        let shareController = UIActivityViewController.init(activityItems: arrayOfStat, applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }
    
    
    @IBAction func UpdateAction(_ sender: UIButton) {
        if SegmentControl.selectedSegmentIndex == 0{
            Get_All_Info(text: Get_Region_Stat(region: YourLocated.text ?? "Москва"))
        }
        if SegmentControl.selectedSegmentIndex == 1{
            Get_Today_Info(text: Get_Region_Stat(region: YourLocated.text ?? "Москва"))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) { // Передаем данные через Segue для отрисовки диаграмы
        if segue.identifier == "GoGraph"{
            let destinationVC : GraphViewController = segue.destination as! GraphViewController
            destinationVC.TextOfLabel = GetStatForGraph(region: YourLocated.text ?? "Москва")
        }
    }

    let Virus_Stat_URL : String = "https://coronavirusstat.ru"
    let StatForGraphUrl : String = "https://coronavirusstat.ru/country/"
    let Regions_List : Array<(a:Int,b:String,c:String)> = [ // Массив соответствия Субъекта РФ и класса из HTML сайта, с которого парсим
        (22    ,"Алтайский край","c_altayskiy_kray"),
        (28    ,"Амурская область","c_amurskaya_oblast"),
        (29    ,"Архангельская область","c_arkhangelskaya_oblast"),
        (30    ,"Астраханская область","c_astrakhanskaya_oblast"),
        (31    ,"Белгородская область","c_belgorodskaya_oblast"),
        (32    ,"Брянская область","c_bryanskaya_oblast"),
        (33    ,"Владимирская область","c_vladimirskaya_oblast"),
        (34    ,"Волгоградская область","c_volgogradskaya_oblast"),
        (35    ,"Вологодская область","c_vologodskaya_oblast"),
        (36    ,"Воронежская область","c_voronezhskaya_oblast"),
        (77    ,"Москва","c_moskva"),
        (79    ,"Еврейская автономная область","c_evreyskaya_avtonomnaya_oblast"),
        (75    ,"Забайкальский край","c_zabaykalskiy_kray"),
        (37    ,"Ивановская область","c_ivanovskaya_oblast"),
        (38    ,"Иркутская область","c_irkutskaya_oblast"),
        (7    ,"Кабардино-Балкарская Республика","c_kabardino_balkarskaya_respublika"),
        (39    ,"Калининградская область","c_kaliningradskaya_oblast"),
        (40    ,"Калужская область","c_kaluzhskaya_oblast"),
        (41    ,"Камчатский край","c_kamchatskiy_kray"),
        (09    ,"Карачаево-Черкесская Республика","c_karachaevo_cherkesskaya_respublika"),
        (42    ,"Кемеровская область","c_kemerovskaya_oblast_kuzbass"),
        (43    ,"Кировская область","c_kirovskaya_oblast"),
        (44    ,"Костромская область","c_kostromskaya_oblast"),
        (23    ,"Краснодарский край","c_krasnodarskiy_kray"),
        (24    ,"Красноярский край","c_krasnoyarskiy_kray"),
        (45    ,"Курганская область","c_kurganskaya_oblast"),
        (46    ,"Курская область","c_kurskaya_oblast"),
        (47    ,"Ленинградская область","c_leningradskaya_oblast"),
        (48    ,"Липецкая область","c_lipetskaya_oblast"),
        (49    ,"Магаданская область","c_magadanskaya_oblast"),
        (50    ,"Московская область","c_moskovskaya_oblast"),
        (51    ,"Мурманская область","c_murmanskaya_oblast"),
        (83    ,"Ненецкий автономный округ","c_nenetskiy_avtonomnyy_okrug"),
        (52    ,"Нижегородская область","c_nizhegorodskaya_oblast"),
        (53    ,"Новгородская область","c_novgorodskaya_oblast"),
        (54    ,"Новосибирская область","c_novosibirskaya_oblast"),
        (55    ,"Омская область","c_omskaya_oblast"),
        (56    ,"Оренбургская область","c_orenburgskaya_oblast"),
        (57    ,"Орловская область","c_orlovskaya_oblast"),
        (58    ,"Пензенская область","c_penzenskaya_oblast"),
        (59    ,"Пермский край","c_permskiy_kray"),
        (25    ,"Приморский край","c_primorskiy_kray"),
        (60    ,"Псковская область","c_pskovskaya_oblast"),
        (1    ,"Республика Адыгея","c_respublika_adygeya"),
        (4    ,"Республика Алтай","c_respublika_altay"),
        (2    ,"Республика Башкортостан","c_respublika_bashkortostan"),
        (3    ,"Республика Бурятия","c_respublika_buryatiya"),
        (5    ,"Республика Дагестан","c_respublika_dagestan"),
        (6    ,"Республика Ингушетия","c_respublika_ingushetiya"),
        (8    ,"Республика Калмыкия","c_respublika_kalmykiya"),
        (10    ,"Республика Карелия","c_respublika_kareliya"),
        (11    ,"Республика Коми","c_respublika_komi"),
        (91    ,"Республика Крым","c_respublika_krym"),
        (12    ,"Республика Марий Эл","c_respublika_mariy_el"),
        (13    ,"Республика Мордовия","c_respublika_mordoviya"),
        (14    ,"Республика Саха (Якутия)","c_respublika_sakha_yakutiya"),
        (15    ,"Республика Северная Осетия - Алания","c_respublika_severnaya_osetiya_alaniya"),
        (16    ,"Республика Татарстан","c_respublika_tatarstan"),
        (17    ,"Республика Тыва","c_respublika_tyva"),
        (19    ,"Республика Хакасия","c_respublika_khakasiya"),
        (61    ,"Ростовская область","c_rostovskaya_oblast"),
        (62    ,"Рязанская область","c_ryazanskaya_oblast"),
        (63    ,"Самарская область","c_samarskaya_oblast"),
        (78    ,"Санкт-Петербург","c_sankt_peterburg"),
        (64    ,"Саратовская область","c_saratovskaya_oblast"),
        (65    ,"Сахалинская область","c_sakhalinskaya_oblast"),
        (66    ,"Свердловская область","c_sverdlovskaya_oblast"),
        (92    ,"Севастополь","c_sevastopol"),
        (67    ,"Смоленская область","c_smolenskaya_oblast"),
        (26    ,"Ставропольский край","c_stavropolskiy_kray"),
        (68    ,"Тамбовская область","c_tambovskaya_oblast"),
        (69    ,"Тверская область","c_tverskaya_oblast"),
        (70    ,"Томская область","c_tomskaya_oblast"),
        (71    ,"Тульская область","c_tulskaya_oblast"),
        (72    ,"Тюменская область","c_tyumenskaya_oblast"),
        (18    ,"Удмуртская Республика","c_udmurtskaya_respublika"),
        (73    ,"Ульяновская область","c_ulyanovskaya_oblast"),
        (27    ,"Хабаровский край","c_khabarovskiy_kray"),
        (86    ,"Ханты-Мансийский автономный округ - Югра","c_khanty_mansiyskiy_avtonomnyy_okrug_yugra"),
        (74    ,"Челябинская область","c_chelyabinskaya_oblast"),
        (20    ,"Чеченская Республика","c_chechenskaya_respublika"),
        (21    ,"Чувашская Республика","c_chuvashskaya_respublika"),
        (87    ,"Чукотский автономный округ","c_chukotskiy_avtonomnyy_okrug"),
        (89    ,"Ямало-Ненецкий автономный округ","c_yamalo_nenetskiy_avtonomnyy_okrug"),
        (76    ,"Ярославская область","c_yaroslavskaya_oblast")]
    
    func Get_All_Info(text: String) -> (){ //Инфа за все время эпидемии
        let TextArray = text.components(separatedBy: " ")
        let count : Int = TextArray.count
        print(count)
        print(TextArray)
        for i in 0..<count{
            if TextArray[i] == "Активных"{
                StatZarazhLabel.text = String(TextArray[i+1])
            }
            if TextArray[i] == "Вылечено"{
                StatVizdorovLabel.text = String(TextArray[i+1])
            }
            if TextArray[i] == "Умерло"{
                StatDiedLabel.text = String(TextArray[i+1])
            }
        }
    }
    
    func Get_Today_Info(text: String) -> (){ //Прирост за сегодня
        let TextArray = text.components(separatedBy: " ")
        let count : Int = TextArray.count
        print(TextArray)
        
        var Str1 = "-/-"
        var Str2 = "-/-"
        var Str3 = "-/-"
        
        for i in 0..<count{
            if TextArray[i] == "Активных" && TextArray[i+4] == "Вылечено"{
                Str1 = String(TextArray[i+2])
            }
            if TextArray[i] == "Вылечено" && TextArray[i+3] == "Умерло"{
                Str2 = String(TextArray[i+2])
            }
            if TextArray[i] == "Умерло" && TextArray[i+3] == "Летальность*"{
                Str3 = String(TextArray[i+2])
            }
        }
        StatZarazhLabel.text = Str1
        StatVizdorovLabel.text = Str2
        StatDiedLabel.text = Str3
    }
    
    func Get_Region_Stat(region: String) -> (String){ 
        guard let my_URL = URL(string: Virus_Stat_URL) else
        {return "Error"}
        func GetId(region : String) -> (String){
            var i = 1
            while region != Regions_List[i].1 {
                i += 1
            }
            return Regions_List[i].2
        }
        
        do {
            let my_HTML : String = try String(contentsOf: my_URL, encoding: .utf8 )
            let content_HTML = my_HTML
            
            do{
                let doo = try SwiftSoup.parse(content_HTML)
                do{
                    let element = try doo.getElementById(GetId(region: region))
                    do{
                        let text = try element?.text() ?? ""
                        return text
                    }
                } catch {
                }
            }
        } catch let error {
            print("Error23: \(error)")
        }
        return "Error21"
    }
    
    func GetStatForGraph(region: String) -> [String] {
        func GetId(region : String) -> (String){
            var i = 1
            while region != Regions_List[i].1 {
                i += 1
            }
            var txt = Regions_List[i].2
            for _ in 1...2{
                txt.remove(at: txt.startIndex)
            }
            return txt
        }
        
        let URLForStat = URL(string : (StatForGraphUrl + String(GetId(region: region)) + "/"))
        do {
            let my_HTML : String = try String(contentsOf: URLForStat!, encoding: .utf8 )
            let content_HTML = my_HTML
            do{
                let doo = try SwiftSoup.parse(content_HTML)
                do{
                    let element = try doo.getElementsByClass("d-none d-sm-block")
                    do{
                        let text = try element.text()
                        
                        let ArrayData = text.split(separator: " ")
                        var FinishArray : [String] = []
                        for i in 0..<(ArrayData.count){
                            if (ArrayData[i].contains("%")) == false && (ArrayData[i].contains("+")) == false{
                                FinishArray.append(String(ArrayData[i]))
                            }}
                        FinishArray.remove(at: 0)
                        return FinishArray}
                } catch {
                }}} catch {
        };return ["Error"]}
}

