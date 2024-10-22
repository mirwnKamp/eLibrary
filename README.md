# e-Library
e-Library is an iOS application that leverages Google's Books API to search and view book details. The app is built using the MVVM architecture pattern and incorporates several advanced features to enhance usability and maintainability.

## Features
* **Google Books API Integration:** Search and fetch book details using Google's Books API.
* **MVVM Architecture:** Ensures clean, maintainable, and testable code.
* **Alamofire Networking:** Simplifies networking tasks with Alamofire.
* **Advanced Form Handling:** Utilizes the form architecture described [in this article](https://nimblehq.co/blog/better-form-architecture-for-ios-applications) to manage forms effectively.
* **Custom Pagination:** Load more data dynamically with custom pagination. Fetch up to 20 books at a time.
* **WebView Integration:** Open book URLs directly in the app using WebView for an enhanced reading experience.
* **Coordinator for Navigation:** Manages navigation between screens for a more organized and scalable codebase.
* **SDWebImageSwift:** Loads book cover images efficiently using SDWebImage.
* **Google Authentication:** Allows users to sign in/ sign up by adding an e-mail and password.

### Google Authentication Integration
To enable the login feature, users must create Firebase Authentication for the app and add the GoogleService-Info.plist file to the app folder. Alternatively, users can contact kampourakis.murwn@gmail.com to request the file via email. Users can sign up using an email and password.

### Usage
- **Search for books** by entering keywords in the search bar.
- **View book details** by selecting a book from the search results.
- **Load more books** by scrolling down to the bottom of the search results.
- **Read books online** by tapping the book you want to read, which opens the book's URL in a WebView.

### Architecture
The e-Library app follows the MVVM (Model-View-ViewModel) architecture pattern. This separation of concerns makes the codebase more modular and easier to maintain.

### Networking
* **Alamofire** is used for all API calls to Google's Books API. This simplifies networking code and error handling.
### Form Handling
* The app incorporates advanced form handling techniques inspired by this article. This approach makes form management more straightforward and reusable within the MVVM architecture.
### Pagination
* A custom pagination mechanism is implemented to handle the loading of more data. The API by default returns 10 books per call and gives the ability to call up to 40 books each call and from wich index to start(e.g when the call contains 100 items you can start from the 20 or 54 item), and the app can fetch up to 20 books as the user scrolls.
### Navigation
* A **Coordinator pattern** is used to manage navigation between screens. This improves the organization and scalability of the codebase.
### Image Loading
* **SDWebImageSwiftUI** is used to load book cover images efficiently. This library provides easy integration with Swift and SwiftUI and supports various image formats.

## Acknowledgements
* [Google Books API](https://developers.google.com/books/docs/v1/getting_started)
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI)
* [Nimble's Blog on Better Form Architecture](https://nimblehq.co/blog/better-form-architecture-for-ios-applications)
