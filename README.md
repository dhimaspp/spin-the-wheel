# Spin-the-Wheel Game

This project is a Spin-the-Wheel game built using Flutter. The application is designed to work on mobile platforms and can also be compiled to run as a standalone JavaScript web app. The project includes unit and functional tests to ensure robustness and consistent behavior across different platforms.

## Table of Contents
1. [Compilation Instructions](#compilation-instructions)
2. [Testing Strategy](#testing-strategy)

## Compilation Instructions

### Compiling the App for Mobile (Flutter)
1. **Clone the Repository**:
    ```bash
    git clone https://github.com/yourusername/spin-the-wheel.git
    cd spin-the-wheel
    ```

2. **Install Dependencies**:
    Ensure that Flutter SDK is installed on your system. Run the following command to install all necessary dependencies:
    ```bash
    flutter pub get
    ```

3. **Build the App**:
    To compile and run the app on a connected device or emulator:
    ```bash
    flutter run
    ```

4. **Build for Release**:
    For Android:
    ```bash
    flutter build apk --release
    ```
    For iOS (macOS required):
    ```bash
    flutter build ios --release
    ```

### Compiling the App for Web (JavaScript)
1. **Ensure Web Support is Enabled**:
    Verify that web support is enabled in your Flutter installation:
    ```bash
    flutter config --enable-web
    ```

2. **Compile to Web**:
    Build the app for web using the following command:
    ```bash
    flutter build web
    ```

3. **Deploy the Web App**:
    The compiled web app will be available in the `build/web` directory. You can serve it locally using a simple server:
    ```bash
    cd build/web
    python3 -m http.server
    ```
    Open a web browser and navigate to http://localhost:8000/index.html to interact with the web version of the app.
    Or you can deploy the contents of `build/web` to any web hosting service.

## Testing Strategy
### Overview
The testing strategy for this project includes both unit and functional tests, which are designed to validate individual components and the overall flow of the game. The tests are written to run in both Flutter (for mobile) and the compiled JavaScript (for web) environments, ensuring consistent behavior across platforms.

### Unit Tests
Unit tests are focused on verifying the correctness of individual components and functions. These include:

1.  Spin Mechanism: Tests that the wheel spins correctly, lands on the expected segment, and that the spinning behavior adheres to the parameters set by the controller.
2.  Hook Triggers: Verifies that the hooks or indicators are triggered appropriately during the spinning process, ensuring they align correctly with the moving wheel.
3.  Dialog Display: Confirms that the correct dialog is displayed when the spin concludes, based on the segment the wheel stops on.

### Running Unit Tests
To execute unit tests, use the following command:

    ```bash
    Copy code
    flutter test
    ```
This command runs all tests within the test/ directory.

### Functional Tests
Functional tests are designed to validate the end-to-end flow of the application, ensuring that the game behaves as expected from a user's perspective. This includes:

Game Flow: Tests the complete interaction flow from starting the game, spinning the wheel, and displaying the result. Ensures that all components work together seamlessly.
