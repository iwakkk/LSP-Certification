# LSP Certification iOS App

## Main Features

* Display a list of books from Supabase
* MVVM (Model-View-ViewModel) architecture
* Asynchronous data loading using `async/await`
* Unit testing using the Swift `Testing` framework

---

## Technologies Used

* Swift
* SwiftUI
* Xcode
* Supabase (backend service)
* Swift Testing Framework

---

## Project Structure (Simplified)


---

## Unit Testing

This project includes a unit test to verify that book data is successfully loaded from Supabase.

Test example:

* `testLoadBooks()`

  * Calls the `loadBooks()` function in `CatalogViewModel`
  * Verifies that the books list is not empty after loading

---

## How to Run the Project

1. Open `LSP Certification.xcodeproj` using Xcode
2. Make sure the Supabase configuration (URL & API Key) is correctly set
3. Select a simulator or physical device
4. Click **Run (▶︎)**

---

## How to Run Tests

1. Open the project in Xcode
2. Press **Cmd + U** or select **Product > Test**
3. Ensure all tests pass successfully

---

## Notes

* This project uses `async/await`, therefore it requires **iOS 15+**
* An active internet connection is required when running the app or tests

---

## Author

Created by **Edward Suwandi**

---

## License

This project is created for learning and certification purposes.
