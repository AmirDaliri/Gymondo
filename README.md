# Gymondo App

## Introduction
Gymondo is a comprehensive exercise application designed for iOS, allowing users to browse a collection of exercises, view detailed information, and explore exercise variations. The app employs a mix of UIKit and SwiftUI, leveraging the Combine framework for reactive programming.

## Features
- **List of Exercises**: Display a list of exercises with images or placeholders when no image is available.
- **Exercise Detail**: Show detailed information, images, and variations for each exercise.
- **Exercise Variations**: Navigate through different variations of an exercise with detailed views.
- **Reactive Programming**: Utilize Combine for data streams and updates.
- **Efficient Loading**: Implement `LazyVStack` for on-demand data fetching and view rendering.
- **Unit and UI Testing**: Extensive testing ensures the reliability and performance of the application.
- **Hybrid Architecture**: A harmonious blend of MVVM for UIKit and SwiftUI, with MVC for programmatically created UI components.

## Architecture
The app showcases a robust architecture, integrating UIKit and SwiftUI to demonstrate best practices in iOS development. It adheres to SOLID principles for a maintainable and scalable codebase.

## Design and User Interface
To provide a clear visual direction for the Gymondo app, a comprehensive UI/UX design was created using Figma. This design file, available in the repository, illustrates the app’s layout, color scheme, and overall user experience.

- **Figma Design File**: Explore the detailed visual blueprint for the Gymondo app’s user interface. The design file offers insights into the aesthetic choices and user flow, guiding the development process.

  Access the Figma design file here: [Gymondo Figma Design](https://github.com/AmirDaliri/Gymondo/blob/main/Gymondo.fig).

## Project Structure
- **Network Layer**: Manages network communications and error handling.
- **Scenes**: Features main browsing functionality, detailed views, and view models.
- **Model**: Defines strongly typed models for network responses.
- **View**: Contains UI components and extensions for rendering.
- **Helpers**: Provides utilities like HTML conversion and image loading.
- **Tests**: Includes unit and UI tests for the application's components.

## Dependencies
- **Kingfisher**: For efficient image downloading and caching.
- **SwiftUI**: Employed for crafting modern UI elements.
- **Combine**: Used for managing asynchronous data flow.

## Installation
To run Gymondo, clone the repository, and open the project in Xcode.

```bash
git clone https://github.com/AmirDaliri/Gymondo.git
cd Gymondo
open Gymondo.xcodeproj
