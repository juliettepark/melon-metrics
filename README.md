# HootHealth

## How to build

Explain how to build and run the project

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


Provide a guide to the layout of your project structure what files/classes

Your README.md should include sections called Data Design and Data Flow that describe the data structures you designed to hold user data, and how you architected your app to use Providers (or another framework, like Bloc) to propagate changes to these data in a reactive way.
