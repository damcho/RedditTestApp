# Reddit posts app

## Arquitecture MVVM

### App structure:
#### RedditApiConnector: class to connect with the reddit api and retrieve posts. uses singleton pattern to instantiate connector

#### RedditsListViewModel, RedditsDetailViewModel, RedditsCellViewModel:
#### Viewmodels for each view controller

### Views folder:
#### Contains view controllers and views

### Models folder:
#### Contains all model objects
#### ReddistContainer: contains list of RedditModel
#### RedditModel: reddit post model
#### RedditQueryObject: model for API Uri creation


## Devices iPhone and iPad

## Things to improve or implement:
- Router for handling app navigation
- Unit testing
- improve API error handling
- UI in general( activity indicator, animations, alerts )
- app state preservation / restoration
- save pictures to gallery

## How to install:
- clone or download
- open RedditTestApp.project
