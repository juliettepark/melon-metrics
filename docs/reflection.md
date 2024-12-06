# Reflection

In docs/reflection.md you should
Identify which of the course topics you applied (e.g. secure data persistence) and describe how you applied them. In addition to the list of topics enumerated above, you must also describe how your app design reflects what you learned about the Properties of People.

- Data Persistence with Isar​: 
    Our calendar view and goal settings save the user's data into the Isar database. 

- Stateless & stateful widgets:
    For instance, ProgressBar is a Stateless widget and CalendarView is a Stateful widget

- Accessing sensors (force, GPS, etc.):
    We queried the user's current weather to provide weather-appropriate exercise recommendations.
    (We indirectly accessed the sensors used by step counters, sleep trackers, etc.)

- API Querying/Querying Web Services: ​
    Queried the health API to retrieve health information of the user and the weather API to recommend users exercises based on the weather.
    We also queried the National Weather Service to get the current weather at the user's location.

- Visual Designs and responsive UI​:
    We added animations to our pet and most of our UI features responded witha message when interacted with.

- Data Structure/Storage Design and Multi-Providers​:
    Used a variety of data structures to build our app. For example, in our calendar view each day was mapped to a condition saved which build our calendar with the user's health history.

- SUS/Accessibility Testing:
    Surveyed around 10 people with SUS testing questions to get a score about our app. Used the accessibility inspector on our app to determine any accessibility issues.

**Properties of People:** We designed this app with the user's health in mind. This laid a great foundation to create a an app with
user-centric features. The primary property that we implemented was making use of edges. We ensured that all clickable buttons
had a bordered edge to emphasize that it is interactable.

**Discuss how doing this project challenged and/or deepened your understanding of these topics.**

Doing this project helped deepen our understanding of these topics because we had to develop an app idea based around our interest
and the four requirements for this project. At first we established a concept of our health tracker app and then we found ways to
incorporate topics/concepts from class into our idea. In order to implement these topics, we had to dive deep on how to make it
customizable towards our final ideas.

Since we also had to customize our own data flows, we had to put Isar into practice and think critically about what information we need to persist versus divide into other providers or even what widgets we could get away with to be Stateless!

Describe what changed from your original concept to your final implementation? Why did you make those changes from your original design vision?

A lot changed from our original concept. We decided to change our mascot and name from MelonMetrics to fit a small owlette since we decided
it would've been too time consuming to create/draw the spritesheets to fit our own mascot and implement it with our app.

**Describe two areas of future work for your app, including how you could increase the accessibility and usability of this app**

- Since our audit mentioned that we had low contrast with some of the text and background, we could find a different color scheme or change some of the colors to increase the accessibility of our app.

- An idea that came up during the presentation was to have incorporate a text box for the pet that reflected its condition/feelings. This would help users get an accurate idea of what the pet is feeling at the time by reading a message sent by the pet rather than judging the looks of the pet through its visuals.

- We also had an idea to, if in very critical condition, to make the pet disappear (die). Users would have to surpass their health goals (do 200 pushups!) to revive the owlet.

Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.
Remember to include all online resources such as Stack Overflow, blogs, students in this class, or TAs and instructors who helped you during OH

- https://www.youtube.com/watch?app=desktop&v=6Gxa-v7Zh7I&t=0s (calendar view tutorial)
- ed board
- https://medium.com/@expertappdevs/mastering-flutter-progress-indicators-8606ac1ec788
- https://stackoverflow.com/questions/68539642/how-expanded-widget-works-in-flutter
- https://www.youtube.com/watch?v=uisLoOmtISk (Great video!)
- https://medium.com/kbtg-life/advanced-animation-with-flutter-flame-engine-ep-1-sprite-sheet-24fb45e888cc

**Finally: thinking about CSE 340 as a whole:
What do you feel was the most valuable thing you learned in CSE 340 that will help you beyond this class, and why?**

Marco: I think the most valuable thing I learned in 340 was how to design with accessibility and testing it with strategies
like the WebAim checker and Accessibilty Inspector. It will help me be mindful of UIs or frontend elements that I may contribute
to.

Shangzhen: I think the most valuable thing I learned in CSE 340 was how to develop a cross-platform app using Flutter and making it accessible to all people. This will help me in the future when I develop apps for different platforms and different people.

Juliette: I found the unique mobile capabilities super powerful. Mobile has access to gyroscopes, GPS,
health metrics, camera, and so much more in comparison to what I was used to on the web. This opens up
many opportunities for cooler ideas to take advantage of these readily available resources, and this
class equipped us with the skills to practice bringing whatever we dreamed up into real life!



**If you could go back and give yourself 2-3 pieces of advice at the beginning of the class, what would you say and why? (Alternatively: what 2-3 pieces of advice would you give to future students who take CSE 340 and why?)**

Marco: Use the ed board, Go to OH if you need help, and make your final project a fun idea

Shangzhen: Ask questions on Ed. Don't panic for autograder tests as they are sometimes false negatives. Start early on assignments.

Juliette: Invest some time to understand how layouts work and how widgets work. It takes some getting used to (like passing in so many properties), but it becomes much more natural.
Google around for widgets. Often, someone has already made the widget you want, or a widget you can use
to build on top of. Take at look at the available widgets and do some digging to see what resources you already have!