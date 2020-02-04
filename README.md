# City Search assignment

## Project

The project is an iOS app using Xcode 11.2.1 and Swift 5. 

## Design pattern:
**MVVM**, which allows to separate business logic from controller and increases testablity.

## View Controllers

There are two view controllers, **CitySearchViewController** and **MapViewController**.

### CitySearchViewController

It contains a _SearchController_ to perform the searches and a _TableView_ to show the results.
it also contains _ViewModel_  which manages the data to be shown on view
It performs a segue to the **MapViewController** to show the map of the selected city. 

### MapViewController

Standard _ViewController_ with a MKMapView. It gets the city as a parameter passed from **CitySearchViewController**.


## View Model
**CitySearchViewModel** contains all the business logic and data the needs to be shown on **CitySearchViewController**

## Utilities

**FilterUtil** class is a helper class to filter data based on search criteria using binary search.
Data is loaded from _JSON_ file  and the items are sorted and binary search is applied to filter data.

### Algorithm for Searching
Sorted the given  200,000+ items and used **binary search** to find the start and last index  (range) of the prefix match with given search word.

binary search is efficient for search in a sorted array, with worst case complexity of  O(log n)  comparisions.

## Model Classes

There are two data clases: **City** and **Coordinates**:
* **City** is a _Decodable_ struct that contains the necessary fields for the project.  like name, country and searchkey
* **Coordinates** is in a struct that contains the latitude and longitude of the city. _City_ contains a property ```coordinate``` that uses the _lat_ and _lon_ values to return a proper ```CLLocationCoordinate2D``` object.

## Data
Data is fetched from cities.json file.

## Tests

Testcases are written in  _BackBaseCitySearchTests_ class which tests the viewModel for valid and invalid city searches

## Dependencies

There are no external dependencies to the project.

Thank you!

