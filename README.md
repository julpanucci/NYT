# NYT
An app that displays New York Times based on your search criteria.

## Installation

#### Clone Repo

```
git clone https://github.com/julpanucci/NYT.git
```

### Carthage

This project uses carthage for a few frameworks. In order for this project to run on your machine, you must have carthage installed.

#### Install dependencies
To install cd into the project directory
```
cd NYT
carthage update --platform iOS
```

If you don't have carthage installed you can install it by using [Homebrew](https://brew.sh/)
#### Homebrew

```
brew install carthage
```

If you don't have Homebrew installed on your machine, you can install it by running the following in your terminal
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Architecture 
For this project, I have decided to user the VIPER design pattern. Viper is a design pattern that implements 'separation of concern' paradigm

## VIPER
Viper is a design pattern that implements 'separation of concern' paradigm  
V - View  
I - Interactor      
P - Presentor  
E - Entity  
R - Router  

View: Class that has all the code to show the app interface to the user and get their responses. Upon receiving a response View alerts the Presenter.

Interactor: Has the business logics of an app. Primarily make API calls to fetch data from a source. Responsible for making data calls but not necessarily from itself.
Router: Does the wire-framing. Listens from the presenter about which screen to present and executes that.
Entity: Model classes used by the interactor.

Presenter : Gets user response from the View and work accordingly. Only class to communicate with all the other components. Calls the router for wire-framing, Interactor to fetch data (network calls or local data calls), view to update the UI.

Entity: Model being used

Router: Does the wire-framing. Listens from the presenter about which screen to present and executes that.


### Testing
Unit testing for this project has been done using BDD, with the help of the Quick and Nimble frameworks.  
Quick and Nimble allows to easily describe how each part of test acts and behaves by describing each unit of code and asserting on the value we expect.

With the consideration of time, this project is not 100% covered by unit tests. I tried to break out the HomeScreenModule as best as possible and fully test the functions for the view, interactor, presentor, and router, in order to demonstrate unit testing knowledge. 

If time allowed, I would continue to unit test the DetailScreenModule, and other views and services contained in this project.


### Xcode
Compiled using Xcode 11.3.1

## Dependencies Used
- [KingFisher](https://github.com/onevcat/Kingfisher)
- [Lottie](https://github.com/airbnb/lottie-ios)
- [SkeletonView](https://github.com/Juanpe/SkeletonView)
- [Reachability](https://github.com/ashleymills/Reachability.swift)

