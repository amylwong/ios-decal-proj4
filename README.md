# Curiocity

## Authors
* Amy Wong

## Purpose
* Curiocity is a trip planner app for users to create a travel plan within a 
city.

## Features
* Ability to map out destinations in a single view
* Find popular tourist attractions
* Group destinations according to location

## Control Flow
* Users are initially presented with a screen where they can start a travel 
plan for a city of their choosing or view a travel plan they have already made.
* When a new plan for a city is created, a list of recommended attractions are 
presented in a checklist and the user can choose which attractions to add to 
their plan.
* Users can also add attractions that were not on the checklist.
* Tapping to go to the next page shows a map with all the pins of locations 
previously selected. The locations appear as pins of different colors, so if 
locations are closer to each other, they will have the same color pin.
* The next page shows the list of locations based on pin color, and it will 
show the opening/closing hours and the Yelp ratings.

## Implementation
### Model
* CityPlan
* LocationDetailsCell

### View
* CityListTableView
* AttractionsListTableView
* MapView
* LocationDetailsTableView

### Controller
* CityListTableViewController
* AttractionsListTablieViewController
* MapViewController
* LocationDetailsTableViewController
