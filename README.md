# SwiftUI MVVM-C Examples PokedexApp
When developing an app with SwiftUI, there are many architecture options to choose from.     
Here, we will examine examples to explore the strengths and weaknesses of various architectures.    

## Getting Started
- The app is a very simple example with three main features: a basic list, a filtering function for the list, and navigation to a detail screen.      
- The code is written as FirstParty as much as possible and includes test code.
- If you want to focus on the architecture, please pay attention to the PokemonModule.
- architecture pattern may not be perfect and is not the definitive answer. I am a junior iOS developer with only two years of experience.
- Feel free to open an issue if there's something missing or you'd like to discuss further.

## Explanation by Architecture
#### [MVVM-C](https://github.com/DeokHo98/SwiftUI-Various-Architecture-Examples-PokedexApp/tree/main/PokemonDex-MVVM)
    
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
     
### ViewModel
The roles of the ViewModel are as follows     
     
- Process the data from the Model to prepare it for the View, meaning transforming it into data that will be displayed on the screen.     
- Receive events from the View and perform the necessary actions.      
- Execute business logic.       
- Pass screen navigation events to the Coordinator.    
         
It is the object that performs the above roles.      
     
### Coordinator
The Coordinator is responsible for managing screen navigation.      
In traditional MVVM, this role was entirely handled by the View. However, if complex navigation logic is kept in the View, the code can become complicated and maintenance can be challenging.      
Additionally, it becomes difficult to test. To address these drawbacks, the Coordinator is a separate object designed specifically for this purpose.       
      
## Advantages of MVVM-C
By adopting MVVM-C, developers can create more modular, testable, and maintainable iOS applications, particularly beneficial for projects expected to grow in complexity over time.
      
- Clear Separation of Concerns:          
Each component has a well-defined responsibility, making the codebase more organized and maintainable.     
- Improved Testability:        
ViewModels and Coordinators can be easily unit tested without dependencies on UI components.     
- Scalability:      
As the app grows, new features can be added without significantly impacting existing components.    
- Relatively easy:      
Implementation pattern that is not too difficult, with a low learning curve.      
            
## Disadvantage of MVVM-C
While MVVM-C offers many benefits, it's important to consider its potential drawbacks     
      
- Consistency Challenges:     
Not all programmers employ the same MVVM-C pattern.     
This means that different projects may use different variations of the MVVM-C pattern, resulting in some inconsistency.      
- In larger apps, complexity increases:       
In more complex apps, all logic except for rendering the View or handling screen transitions may be offloaded to the ViewModel, potentially leading to a Massive ViewModel.        



