# PWC_Task
This is COVID-19 dashboard to provide a quick glance of the situation worldwide, with the ability to drill down to the details of a specific country.

# How the app works
1. When the user first enters the app, he will see a dashboard page including a map, worlwide COVID-19 tracking data view and per country COVID-19 tracking data view. 
2. The user can explore in the map using the pin and everytime he passes through a country, the country's COVID-19 tracking data will be updated to the country that the pin is currently located on.
3. The user can tap on the map and he will be able to view the news feed of the country that he tapped on.
4. The news feed will contain articles related to COVID-19 in the country that the user chose.
5. When the user taps on any article, he will be redirected to the link containing the article so that he can read and view it all.
6. If there's no data being returned from the APIs, empty views will be shown in both tracking page and news feed page.
7. When an error occurs, an alert will pop up explaining that an error occured.

# Development

* I have chosen the MVP design pattern as I thought it would be the most appropriate for this task.
* Alamofire was used to make requests, kingfisher to load the image urls for the news feed and SVGKit to load the svg image for the country flags.
* A placeholder was added for the news feed as some articles did not have images.

# Cocoapods Used
- Alamofire
- Kingfisher
- SVGKit
