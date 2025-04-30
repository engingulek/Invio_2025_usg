//
//  HomeProtocols.swift
//  Invio_2025_USG
//
//  Created by Engin Gülek on 30.04.2025.
//

import Foundation


typealias HomeKits = UIViewAble & SegueAble & NavConUIAble & AlertControllerAble

//MARK: TableViewActionHomeProtocol
protocol TableViewActionHomeProtocol {
    /// number of table view sections
    func numberOfSections() -> Int
    /// number of table view rows
    func numberOfRowsInSection(in section:Int) -> Int
    /// table view cell content
    func cellForItem(at indexPath:IndexPath) -> (element:LocationElement,favState:FavState)
    /// table view section content
    func viewForHeader(in section:Int) -> (element:CityElement,expendType:ExpendType)
    /// table view header height
    func heightForHeaderInSection() -> CGFloat
    // Navigaiton for Detail Screen
    /// It works when the cell is clicked
    func didSelectRow(at indexPath:IndexPath)
    // Change Expand Type
    /// It works when this section is clicked
    func onTappedSection(sectionIndex:Int)
    // Navigation for City Map
    /// It works when this right arrow is clicked
    func onTappedRightArrow(sectionIndex:Int)
    // Add or delete location to favorite
    /// It works when the fav icon on cell is clicked
    func onTappedFavIconOnCell(indexPath:IndexPath)
    // Pull data from the next page
    /// It works when it reaches the end of the page. And
    func scrollViewDidEnd()
}

//MARK: ViewToPresenterHomeProtocol
protocol ViewToPresenterHomeProtocol  : TableViewActionHomeProtocol{
    var isLoading : Bool {get}
    var view : PresenterToViewHomeProtocol? {get}
    /// Interface settings are made
    func viewDidLoad(rightButtonAction:Selector)
    /// Gets the first page from the splash screen
    func getFirstList(page:PageElement)
    // Navigation for Favorites Screen
    /// It works when this fav icon on navigation  is clicked
    func onTappedNavFavIcon()
    /// close all collapse
    func onTappedCollapseIconButton()
}


//MARK: PresenterToViewHomeProtocol
protocol PresenterToViewHomeProtocol : AnyObject,HomeKits {
    /// Prepare for TableView
    func prepareTableView()
    /// It is used when changes are made to the presenter list and to update the table view.
    func reloadTableView()
    /// It is used to update a cell only when a change is made to that cell.
    func reloadIndexPath(indexPath:IndexPath)
    /// It is used to update only that section when a change is made to only one data.
    func reloadSection(index:Int)
    /// Update the city number
    func cityCountText(text:String,count:Int,isHidden:Bool)
    /// Display an error message on the screen in case of an error
    func sendError(text:String,isHidden:Bool)
    /// collapse icon hidden status from presenter
    func collapseButtonIsHidden(isHidden:Bool)
}


//MARK: PresenterToInteractorHomeProtocol
protocol PresenterToInteractorHomeProtocol{
    /// Fetch for page
      /// - Parameters:
      ///   - pageNumber: indicates which page it is
    func fetchPage(pageNumber:Int) async
    /// Checks whether it is added to favorites or not
      /// - Parameters:
      ///   - id: id of city
    func isEntityExist(id:Int16) -> Bool
    /// Delete from favorites
      /// - Parameters:
      ///   - id: id of city
    func deleteFav(id:Int16)
    
    /// Add to favorites
      /// - Parameters:
      ///   - id: id of city
    func addToFav(element:LocationElement)
}

//MARK: InteractorToPresenterHomeProtocol
protocol InteractorToPresenterHomeProtocol : AnyObject{
    /// Sends data when the interactor does not give an error
    func sendPage(page:PageElement)
    /// Sends error when interactor fails
    func sendError()
}

//MARK: PresenterToRouterHomeProtocol
// - Explanation: This extension handles navigation requests sent from the presenter.
protocol PresenterToRouterHomeProtocol {
    /// Navigate to the Favorites screen.
    /// - Parameter view: viewController for SegueAble
    func toFavoritesScreen(view:PresenterToViewHomeProtocol?)
    ///  Navigate to the Detail screen with the given location data.
    /// - Parameters:
    ///   - view:  viewController for SegueAble
    ///   - locationElement:  location data for detail
    func toDetailScreen(view:PresenterToViewHomeProtocol?,locationData:LocationElement)
    
    func toCityMap(view:PresenterToViewHomeProtocol?,cityElement:CityElement)
}
