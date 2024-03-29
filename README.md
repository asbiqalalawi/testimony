# Testimonial App

This Flutter application (version 3.19.3) allows users to browse testimonials, perform searches, and switch between English and Indonesian languages.

## Features

1. **Homepage**:
   - Displays testimonials in Card format.
   - Each Card shows the name, avatar, content, and number of likes.
   - Supports pagination to load 5 testimonials per request.
   - Automatically loads more data when users scroll to the bottom of the page.
   - Displays "All data have been loaded" or "Semua data berhasil dimuat" when there is no more data to load.

2. **Search Functionality**:
   - Provides search functionality to find testimonials by name or content.

3. **Language Switching**:
   - Allows users to switch between English (default) and Indonesian languages.

## Project Structure

The project is structured as follows:

- `lib/`: Contains the Dart code for the application.
  - `cubit/`: Cubit classes for specific features.
  - `l10n/`: multilanguage dictionary.
  - `model/`: Includes models specific to each feature.
  - `service/`: Services specific to each feature, such as API calls.
  - `view/`: User interface components specific to each feature.
 
## How to Run

1. Clone the repository: `git clone <repository-url>`
2. Navigate to the project directory: `cd testimony`
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run` to launch the app on your device or emulator.
