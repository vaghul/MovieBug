# MovieBug
Single paged iOS application that houses a infinity movie scroll using the https://www.themoviedb.org/documentation/api

# Sites & Descriptions
This Mobile Application list the popular movies from this api support (https://www.themoviedb.org/documentation/api/discover). based on the requirment of forcasting the infinite scroll project smooth user experience.
This Application use the MVC-ICE Software Design pattern (Model View Controller Inheritance Components Extension). This software pattern was devised and reitered on based on my years of hands on experience in build a stable product from scratch. This model has a close working model as the VIPER Pattern.

# Working
1.The App consumes and pulls the Popular movie list for the API 


2.The list paginates when the user scrolls to **80%** of the content to enrich the UX as the wait time for the user to see the next list is minimal


3.Is stores the results locally for offline viewing mode (it uses the **SQLLITE** database for storage and retrival


4.Incase of No internet connections or Already stored movie list. The app fetchs the result for the internal database and does not make a API calls which helps is saving **Power** and **Data** consumption and also provides a much quicker **load time**.


5.The loaded list (paginated list) is give a smooth load effect. Only the **Delta** values are refreshed in the list rather than the whole list


6.On clicking on a movie in the list, the movie expands to show a small description about the **storyline** of the movie 


7.The app supports **Responsive UI**

# Project Structure

[Fonts](https://github.com/vaghul/MovieBug/tree/master/MovieBug/Fonts)
Holds the Custom fonts 

[Modules](https://github.com/vaghul/MovieBug/tree/master/MovieBug/Modules)
Houses all the logical structure 

[ObjC-Helper](https://github.com/vaghul/MovieBug/tree/master/MovieBug/Modules/ObjC-Helper)
 Contains the Objective - C Helpers


[ObjectRelationalModel](https://github.com/vaghul/MovieBug/tree/master/MovieBug/Modules/ObjectRelationModel)
House all the Custom ORM for request and response structure along with a skeleton 


[MovieList](https://github.com/vaghul/MovieBug/tree/master/MovieBug/Modules/MovieList)
The main screen with all functional and logical elements (Model,View,Controller,Extensions)


[Helper](https://github.com/vaghul/MovieBug/tree/master/MovieBug/Modules/Helper)
Contains aux helpers like Image cacher, App macros, User defaults and Static image loader


[Base](https://github.com/vaghul/MovieBug/tree/master/MovieBug/Modules/Base)
    Contains the base functionality for all the components which can be re-used and called for the main modules through inhertaince 

# Tech Stack
The Application is built on **Swift 4.0** with **Coded Design** implementation. The application does not consume any third-party library except (Rechability) for internet connectivity check. 

# Contribution
All the supporting files and architecture was hand designed , tested and improvised soley by [Vaghula Krishnan](https://github.com/vaghul)

# Acknowledgments
* [TheMoviedb](http://themoviedb.org/)

# License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/vaghul/MovieBug/blob/master/LICENSE) file for details
