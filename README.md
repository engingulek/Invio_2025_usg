# Invio_2025_usg!

### Core Data
Core Data was used to delete favorite areas from the phone's memory.
```swift
//MARK: CoreDataManaging
protocol CoreDataManaging {
    
    associatedtype Entity: NSManagedObject
    associatedtype AddModel : Any
    
    func fetchAll() throws -> [Entity]
    func addEntity(model: AddModel) throws
    func deleteEntity(id: Int16) throws
    func isEntityExist(id: Int16) throws -> Bool
}
```

CoreDataManaging was created in case Core Data is used for different entities in the future.

With this process, the basic operations to be performed have been abstracted.

In addition, thanks to the <b>associatedtype Entity: NSManagedObject</b> definition, classes that implement this protocol specify the entity they are working with. Thus, a single protocol can be reused for all entity types.

Core Data entities are not suitable for being directly transferred to application layers. Therefore, external data containers (DTO, AddModel) are generally used. With the <b>associatedtype AddModel</b>, a different data model can be defined for each entity.

### MapLocationManager
By managing location-related operations with a manager, a more readable and testable structure was created.

``` swift
//MARK: LocationPermissonState
/// Represents the state of location permission.
enum LocationPermissonState {
    case successful   /// User has granted location permission.
    case notDetermined /// User has not made a choice regarding location permission yet.
    case denied ///  User has denied location permission.
}

//MARK: FocusUserLocationState
/// Represents the state of focusing on the user's location.
enum FocusUserLocationState {
    case focus /// Map can focus on user's location.
    case notDetermined /// Permission state is not determined yet.
    case denied /// Cannot focus due to denied permission.
}

//MARK: MapLocationManagerDelegate
/// Protocol to handle location-related delegate callbacks.
protocol MapLocationManagerDelegate: AnyObject {
    
    /// Called when the location permission state changes.
    /// - Parameter state: The current permission state.
    func locationPermisson(state:LocationPermissonState)
    /// Called to indicate the ability to focus on the user's location.
    /// - Parameter state: The current focus state.
    func focusUserLocation(state:FocusUserLocationState)
    /// Called when a new location is received.
    /// - Parameter location: A tuple containing latitude and longitude.
    func didUpdateLocation(_ location: (lat:Double,lng:Double))
}


/// Provides a default implementation to make `didUpdateLocation` optional.
extension MapLocationManagerDelegate {
    func didUpdateLocation(_ location: (lat:Double,lng:Double)){
    }
}
protocol MapLocationManagerProtocol {
    var delegate: MapLocationManagerDelegate? {get set}
    /// Requests location permission from the user.
    func requestLocationAccess()
    /// Checks whether the app can focus on the user's location based on current permission status.
    func focusUserLocationAuthorization()
    /// Calculates the distance between two geographic points.
    /// - Parameters:
    ///   - point: The first coordinate (latitude, longitude).
    ///   - target: The second coordinate (latitude, longitude).
    /// - Returns: The distance in meters.
    func calculateDistance(point:(lat:Double,lng:Double),target:(lat:Double,lng:Double)) -> Double
}
```

### There are 7 Kits
<ul>
  <li>ViewKit</li>
  <li>managerkit</li>
  <li>CoreKit</li>
  <li>FactoryKit</li>
  <li>ViewControllerAbleKit</li>
</ul> 

### There are 4 Modules
<ul>
  <li>SplashModule</li>
  <li>HomeModule</li>
  <li>DetailModule</li>
  <li>FavoritesModule</li>
  <li>LocationMapModule</li>
  <li>CityMapModule</li>
</ul>  

## 3rd Party Frameworkler
<ul>
  <li>Alamofire</li>
  <li>Kingfisher</li>
  <li>SnapKit</li>
</ul>  


## Technical information about the application
<ul>
  <li>VIPER used</li>
  <li>Protocol Oriented Programming</li>
  <li>Unit Test</li>
  <li>MapKit</li>
</ul>  

##Language
<ul>
   <li>Türkçe</li>
  <li>English</li>
</ul> 


## Videos
 <table style"float:right;">
 <tr>
   <td>  <img width="420" height="440" src = "https://github.com/user-attachments/assets/2762ca6e-9b39-4697-930a-7ccc38656a7f">   </td>
   <td>  <img width="420" height="440" src = "https://github.com/user-attachments/assets/6901aa2b-1931-4b00-ab6a-f92a1f6452fd">   </td>
  
 </tr>
 </table>

 <table style"float:right;">
 <tr>
   <td>    <img width="420" height="440" src = "https://github.com/user-attachments/assets/a4acd443-18bc-4acd-bcfe-640aa6c666bd">    </td>
  <td>    <img width="420" height="440" src = "https://github.com/user-attachments/assets/60cc0714-3cf7-4a91-85ed-2d9deade559f">     </td>
 </tr>
 </table>

 <table style"float:right;">
 <tr>
   <td>    <img width="420" height="440" src = "https://github.com/user-attachments/assets/47885568-7dd1-4f54-a78d-a336e3470b10">     </td>
 </tr>
 </table>

 ## Screens (iPhone SE)


 
 <tr>
   <td>  <img width="400" height="440" src = "https://github.com/user-attachments/assets/117885a7-e814-490c-bf7d-c15dc556469c">   </td>
   <td>  <img width="400" height="440" src = "https://github.com/user-attachments/assets/319e2ac9-64a2-4d47-8ec1-65192b4c5dcb">   </td>
 </tr>
 </table>

 <table style"float:right;">
 <tr>
   <td>    <img width="400" height="440" src = "https://github.com/user-attachments/assets/885ea206-fb18-4099-b5d7-a6dc0442b94a">    </td>
  <td>    <img width="400" height="440" src = "https://github.com/user-attachments/assets/41e27838-799b-43ba-8994-243d8badc660">     </td>
 </tr>
 </table>
