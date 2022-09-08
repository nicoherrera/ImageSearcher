# Valence code challenge

An application that searches images from Pixbay. 

The app is made following the Model View ViewModel pattern, I used reactive programming with RxSwift and RxCocoa.

## Folder structure
```
- 📁 GigZters
  - 📁 Application -> AppDelegate, SceneDelegate, global files.
  - 📁 Supporting Files -> assets.
  - 📁 Models -> All the entities of the app. Try to create subfolders when you have related models.
  - 📁 NetworkingLayer -> Networking managers, Alamofire connection, etc.
  - 📁 Scenes -> Scenes(Screens) of the app.
    - 📁 Scene -> A defined scene (e.g: Transfer).
      - 📁 Cells -> Custom views and Controls related to this specific scene.
      - 💾 ViewController (e.g: ImageSearchViewController).
      - 💾 ViewModel (e.g: ImageSearchViewModel).
      - 💾 Stobyboard (e.g: Main).
  - 📁 Utilities -> All general implementations
    - 📁 Extensions -> Common extensions
    - 📁 UI -> Defined Colors and views.
    - 📁 Helpers -> Common helpers.
- 📁 Products
- 📁 Pods
- 📁 Frameworks
```

## 3rd party frameworks used
1. RxSwift
1. RxCocoa
1. Alamofire - an HTTP networking library
1. Kingfisher - for downloading and caching images
1. iProgressHUD - an indicator loading

## Features
All mandatory features added. Also, I created some extra features like:

1. Additional results are loaded when the user scrolls near the bottom.
1. Responsive layout.
1. A long-press gesture on each cell on the home screen hides the detail.
1. Ability to zoom and scroll photos.
1. Image metadata overlay toggles over the image when tapped or zoomed.

## Future improvements
1. Improve error handling, with better user messages.
1. Add a carousel in DetailViewController to be able to swipe between images.
1. Improve screen rotation handling when an image is zoomed.
1. Create unit tests.
1. Create icons for the app.
