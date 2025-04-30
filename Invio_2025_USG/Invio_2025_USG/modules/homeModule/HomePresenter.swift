//
//  HomePresenter.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation

enum FavState {
    case favoritee
    case noFavorite
}
// MARK: HomePresenter
final class HomePresenter {
    weak var view : PresenterToViewHomeProtocol?
    private let interactor : PresenterToInteractorHomeProtocol
    private let router : PresenterToRouterHomeProtocol
    
    private var cityList : [CityElement] = []
    var isLoading: Bool = false
    private var currentPage:Int = 1
    private var totalPage:Int? = nil
    private var cityListCount:Int? = nil
    
    init(view: PresenterToViewHomeProtocol?,
         interactor: PresenterToInteractorHomeProtocol,
         router: PresenterToRouterHomeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    /// Fetch data according to current page
    private func fetchData() async {
        await interactor.fetchPage(pageNumber: currentPage)
    }
}

//MARK: HomePresenter : ViewToPresenterHomeProtocol
extension HomePresenter : ViewToPresenterHomeProtocol {
    
    
    func viewDidLoad(rightButtonAction:Selector) {
        view?.setBackColorAble(color: ColorTheme.primaryColor.rawValue)
        view?.setNavigationTitle(title: TextTheme.homeNavTitle.localized)
        view?.hidedBackAble(isHidden: true)
        view?.prepareTableView()
        view?.setNavigationRightButton(
            iconImage:IconTheme.fav.rawValue,
            onTappedAction: rightButtonAction)
        view?.collapseButtonIsHidden(isHidden: true)
    }
    
 
    func getFirstList(page: PageElement) {
        cityList = page.data.map { city in
            var modifiedCity = city
            modifiedCity.isExpend = false
            return modifiedCity
        }
        totalPage = page.totalPage
        
        
        cityListCount = cityList.count
        
        view?.cityCountText(text: TextTheme.count.localized,
                            count: cityListCount ?? 0,isHidden: false)
        
        view?.reloadTableView()
    }
    func onTappedCollapseIconButton() {
        let list =  cityList.map { city in
            var modifiedCity = city
            modifiedCity.isExpend = false
            return modifiedCity
        }
        cityList = list
        view?.reloadTableView()
        view?.collapseButtonIsHidden(isHidden: true)
    }
    
    
    func onTappedNavFavIcon() {
        router.toFavoritesScreen(view: view)
    }
}

//MARK: HomePresenter -> iewToPresenterHomeProtocol  + TableViewActionHomeProtocol
extension HomePresenter {
  
    func numberOfSections() -> Int {
        return cityList.count
    }
    
    func numberOfRowsInSection(in section:Int) -> Int {
        let item = cityList[section]
        guard let isExpend = item.isExpend else {return 0}
        let count = isExpend ? item.locations.count : 0
        return count
    }
    
  
    func cellForItem(at indexPath: IndexPath) ->(element:LocationElement,favState:FavState){
        let section =  indexPath.section
        let row = indexPath.row
        let element = cityList[section].locations[row]
        let favState:FavState
        
        let state = interactor.isEntityExist(id: Int16(element.id))
        favState = !state ? .noFavorite : .favoritee
        
        return (element,favState)
      
    }
    
  
    func viewForHeader(in section: Int) -> (element:CityElement,expendType:ExpendType) {
        let element = cityList[section]
        let expendType:ExpendType
        if element.locations.isEmpty {
            expendType = .none
        } else if let expend = element.isExpend {
            expendType = expend ? .open : .close
        } else {
            expendType = .none
        }
        
        return (element,expendType)
    }
    
   
    func heightForHeaderInSection() -> CGFloat {
        return 40
    }
    
    func onTappedSection(sectionIndex: Int) {
        guard let isExpand = cityList[sectionIndex].isExpend else {return}
        cityList[sectionIndex].isExpend = !isExpand
        let retsult =  cityList.contains { $0.isExpend == false }
        view?.collapseButtonIsHidden(isHidden: !retsult)
        view?.reloadSection(index: sectionIndex)
    }
    

    func onTappedRightArrow(sectionIndex: Int) {
        let city = cityList[sectionIndex]
        router.toCityMap(view: view, cityElement: city)
    }
    
  
    func didSelectRow(at indexPath: IndexPath) {
        let locationElement = cityList[indexPath.section].locations[indexPath.row]
        router.toDetailScreen(view: view, locationData: locationElement)
    }
    

    func scrollViewDidEnd() {
        guard let totalPage = totalPage else {return}
        if currentPage < totalPage {
            currentPage += 1
            Task {
                await fetchData()
            }
        }
    }
    
  
    func onTappedFavIconOnCell(indexPath:IndexPath) {
        
        let location = cityList[indexPath.section].locations[indexPath.row]
      
            let state = interactor.isEntityExist(id: Int16(location.id))
            if state {
                interactor.deleteFav(id: Int16(location.id))
            }else{
                interactor.addToFav(element: location)
            }
            view?.reloadIndexPath(indexPath: indexPath)
            
        
    }
}

//MARK:  HomePresenter : InteractorToPresenterHomeProtocol
extension HomePresenter : InteractorToPresenterHomeProtocol {
  
    func sendPage(page: PageElement) {
        let list =  page.data.map { city in
            var modifiedCity = city
            modifiedCity.isExpend = false
            return modifiedCity
        }
        cityList += list
        view?.reloadTableView()
        
        guard var count = cityListCount else {return}
        count += page.data.count
        cityListCount = count
        view?.cityCountText(text: TextTheme.count.localized, count: count,isHidden: false)
    }
    
    
    func sendError() {
       
        view?.sendError(text: TextTheme.errorMessage.localized, isHidden: false)
    }
}
