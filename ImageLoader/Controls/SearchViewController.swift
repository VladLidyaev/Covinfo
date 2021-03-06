//
//  SearchViewController.swift
//  ImageLoader
//
//  Created by Vlad on 13.09.2020.
//  Copyright © 2020 Vlad. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController{
    
    @IBAction func GoHome(_ sender: UIBarButtonItem) {
        let Text = GetDataBack()
        NotificationCenter.default.post(name: Notification.Name("GoGO"), object: nil, userInfo: ["info": Text])
        dismiss(animated: true)
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    let Regions_List : Array<(a:Int,b:String,c:String)> = [
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
        (67    ," енская область","c_smolenskaya_oblast"),
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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var filtred_regions = [(a:Int,b:String,c:String)]()
    
    private var SearchIsEmpty: (Bool){
        guard let search = searchController.searchBar.text  else {
            return false
        }
        return search.isEmpty
    }
    
    private var isFiltring: Bool{
        return searchController.isActive && !SearchIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Регион"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection number_of_rows_in_section: Int) -> (Int) {
        if isFiltring{
            return filtred_regions.count
        }
        return Regions_List.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let  region : (a:Int,b:String,c:String)
        
        if isFiltring{
            region = filtred_regions[indexPath.row]
        } else{
            region = Regions_List[indexPath.row]
        }
        
        cell.textLabel?.text = region.1
        return cell
        
    }
    
    func GetDataBack() -> (String){
        if let indexpath = tableView.indexPathForSelectedRow{
            let reg : (a: Int,b: String,c: String)
            if isFiltring{
                reg = filtred_regions[indexpath.row]
            }else{
                reg = Regions_List[indexpath.row]
            }
            return(reg.1)
        } else {
            return "Москва"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText : String){
        
        filtred_regions = Regions_List.filter({(filtr : (a:Int,b:String,c:String)) -> Bool in
            return filtr.b.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}
