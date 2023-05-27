
# MovieMagic

MovieMagic is an iOS app built using SwiftUI, Combine, and MVVM architecture that allows users to explore movies and access information about them using the MovieDB API. This README file provides an overview of the project and guides you through the setup process.

## Features

- Browse popular,upcoming,trending,top rated movies.
- Search for movies by title or keyword.
- Users can filter movies to discover movies within specific categories.
- View detailed information about movies/tvshow, including overview, rating.

## Screenshots

[[Screenshots1]](https://github.com/OranLevi/MovieMagic/blob/dev/Screenshots/Screenshot1.png?raw=true) , [[Screenshots2]](https://github.com/OranLevi/MovieMagic/blob/dev/Screenshots/Screenshot2.png?raw=true) , [[Screenshots3]](https://github.com/OranLevi/MovieMagic/blob/dev/Screenshots/Screenshot3.png?raw=true)


## Architecture

MovieMagic follows the MVVM (Model-View-ViewModel) architectural pattern. Here's a brief explanation of the different components:

**Model**: Contains the data models used in the app.<br>
**View**: Defines the user interface components and their layout using SwiftUI.<br>
**ViewModel**: Acts as an intermediary between the View and Model, providing data and handling user interactions. It also abstracts the API calls and data processing logic using Combine.<br>
**Service**: Handles network requests to the MovieDB API and provides data to the ViewModel.<br>

## Folder Structure

The project is organized as follows:

**Models**: Contains the data models used in the app.<br>
**Views**: Contains the SwiftUI view files.<br>
**ViewModels**: Contains the ViewModel files.<br>
**Services**: Contains the networking code to interact with the MovieDB API.<br>
**Utilities**: Contains utility classes.<br>
**Extensions**: Contains Swift extensions that add extra functionality to existing classes or types.

## Getting Started

To get started with MovieMagic, follow the instructions below:

1. Clone the repository:

```sh
git clone https://github.com/OranLevi/MovieMagic.git
```
2. Open the MovieMagic.xcodeproj file in Xcode.

3. Obtain an API key from The MovieDB and replace the placeholder value in ConstantsTemplate.swift file:

```sh
static var API_KEY = ""
```
Build and run the app in the Xcode simulator or on a physical device.

## Contact
Contributions are always welcome! If you have any ideas for features, bug fixes, or other improvements, please submit a pull request.
