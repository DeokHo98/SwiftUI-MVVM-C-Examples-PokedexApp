# MVVM-C

## Explanation of MVVM-C (Model-View-ViewModel-Coordinator)
MVVM architecture has likely been the most popular since the UIKit days     
and is commonly used in apps of moderate size.     
     
The MVVM-C architecture extends the MVVM architecture, which consists of     
Model-View-ViewModel, by introducing a Coordinator object responsible for      
screen navigation, thus separating the responsibilities that were previously      
handled by the View.     
     
Let’s take a look at the roles each object plays.     

### Model
Simply put, the Model represents the data.    
It can be data received from external sources (e.g., data parsed from JSON received from a server)    
or data created and stored within the app itself (e.g., data from CoreData).    
     
### View
The View is responsible for drawing the interface.     
In UIKit, it also handled tasks like Delegate processing.      
However, in SwiftUI, these responsibilities have been removed, allowing the View to focus more solely on rendering the interface.   
Originally, the View was also responsible for screen navigation, but in this architecture, it is handled by the Coordinator, which will be discussed later.    
Additionally, the View passes user events to an object called ViewModel, which will be discussed later, and it also displays the data provided by the ViewModel on the screen.         
