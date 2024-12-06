# HootHealth

## How to build

1. Open the project in Visual Studio Code
2. Run `flutter pub get` in the terminal to install dependencies
3. Run `flutter run` to build the app

## Project Structure

1. All other reflection markdown files are located in a folder called docs
2. Within /lib:

- /helpers
  - a folder for API querying files
- /models
  - the Isar generated .g.dart files
  - pet game animation config and state files
  - helper classes to represent a single GoalSetting entry or weather condition
- /providers
  - all the Provider classes where we pull data
  - includes Goal, Health, Position, and Weather providers
- /views
  - all the visible widgets that come together to assemble the main app

## Data Design

The application is designed using **Provider** for state management, focusing on reactivity and efficient data propagation across the UI. Below are the key data structures:

### HealthProvider

- **Purpose**: Tracks and updates user's health metrics such as calories burned, sleep hours, steps, and overall wellbeing score.
- **Key Data Fields**:
  - `_caloriesBurned`: Tracks calories burned.
  - `_sleepHours`: Tracks hours of sleep.
  - `_steps`: Tracks the number of steps.
  - `_wellbeingScore`: Derived score based on goals and health metrics.
  - `_goals`: Instance of `GoalSetting` specifying health goals.
- **Features**:
  - Uses health-related permissions.
  - Automatically updates health data periodically.
  - Calculates and classifies the wellbeing score into Good, Okay, or Poor.

### GoalProvider

- **Purpose**: Manages health goals for sleep, steps, and calorie targets.
- **Key Data Fields**:
  - `goals`: Instance of `GoalSetting` representing user-defined targets.
- **Features**:
  - Fetches and updates user goals persistently using Isar database.
  - Notifies listeners on goal updates.

### PositionProvider

- **Purpose**: Handles geolocation to determine the user’s current position.
- **Key Data Fields**:
  - `_latitude` and `_longitude`: Geographical coordinates of the user.
- **Features**:
  - Checks and requests location permissions.
  - Provides current device position.

### WeatherProvider

- **Purpose**: Tracks and updates weather conditions.
- **Key Data Fields**:
  - `tempInfahrenheit`: Current temperature.
  - `condition`: Enum for weather condition (e.g., sunny, gloomy).
  - `hasWeatherData`: Indicates whether weather data is available.
  - `error`: Stores error messages.
- **Features**:
  - Updates weather data and handles errors reactively.

## Data Flow

The app follows a reactive architecture facilitated by the **Provider** package. Each provider class extends `ChangeNotifier` to propagate state changes to the UI.

### Initialization

- Providers are initialized with required dependencies (e.g., `HealthProvider` with `Isar` database).
- Initial values are fetched from local storage or external APIs.

### State Management

- Providers manage their state independently:
  - `HealthProvider` updates health metrics periodically and recalculates the wellbeing score.
  - `GoalProvider` persists and retrieves user goals.
  - `PositionProvider` interacts with geolocation services for positional data.
  - `WeatherProvider` handles weather updates and error reporting.
- Changes in state trigger `notifyListeners()` to inform the UI to rebuild.

### UI Updates

- The `Consumer` widgets wrap UI components to listen to changes.
- For example:
  - A widget displaying steps listens to `HealthProvider` for `_steps` updates.
  - A weather widget observes `WeatherProvider` for condition changes.

### Reactivity

- The architecture ensures that:
  - Updates in health data (e.g., steps or calories) automatically propagate to all dependent UI widgets.
  - Weather updates reflect instantly without manual intervention.
  - Location permissions or errors are handled gracefully, keeping the UI informed.
