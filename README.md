#  DKB task by Mostafa Elbutch

## The task waas written on Xcode version 13.1 with swift version 5.5.
## The task is implemented in MVVM-C (A coordination pattern was added to handle the navigation between the screens). 
## Repositories was also introduced as layer between the view model and the APIClient.
## If I had to save some data locally (in a database or in UserDefaults for example) I would also introduce data stores, its aim will be to take the decision from which repository(remote or local repository) the data should be fetched.
## I also tried to cover as much code as I could (due to the limited time) with unit tests.

# Things that can be improved.
## 1. The external dependency on 'Reusable' library could have been avoided by writing my own views, custom cells and ViewControllers extensions.

## 2. There is a UIKit import in `PhotoDetailsViewModel` which is not recommended (to include UI related modules in the view model).
## It could have been avoided by calling the downloadPhoto in the view controller.

## 3.The method `showErrorAlert` in `PhotosListViewController` could have been added to the coordinator as a navigation case which can be presented on the top most view controller or in a baseViewController.
