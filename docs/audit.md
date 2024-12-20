# Audits (2 included)

Name: Hajin Shim


App audited: HootHealth


Commit ID: 062a7ec356386df6a8eea45352645c298307af74


Date/Place of audit: CSE2, 12/02/2024


Devices and settings used: IOS VoiceOver screen reader and WebAim Contrast Checker

Strengths of the app: The app’s home screen has a very cute animation of the character the user can grow as well as clean emotes of sleep, walk, and water intake. There is also a calendar to keep track of progress which is very nice.


Areas of weakness and suggested improvements:
Name/Brief Description - Low Color Contrast of Bar and Button


Testing Method - WebAim Contrast Checker


Evidence -  Guideline violated: 1.4.3 Contrast (Minimum)


Explanation - This app violates success criterion 1.4.3 Contrast. The color contrast between the background and some elements of the app do not meet the required contrast ratio. On the top left of the home screen, the contrast of an empty bar with the background is down to a 1.2:1, which is way lower than the required 3:1. Also some buttons when they are selected have too dark of a background color so that the black icon that is getting selected is hard to see. This can become an issue for users with vision impairments as it could result in the inability to tell what the icon signifies.


Severity - 2


Justification - This app does not have this problem happening frequently. It only happens to some parts of the app, making it not too much of a high priority. However, the impact of this might be big as the app uses icons/emojis instead of text. If an icon is hard to see, there would be no other way to know what the icon is.


Possible Solution - A solution could be to change the icon color so that it becomes brighter when selected or make the on select color lighter, but a color where you can still tell that it is highlighted. As for the bars, I think it would be smart to section them off and make the background color something else so that the white, empty bar does not blend in with the background.

---

Name: Yijia Zhao
App audited: HootHealth
Date/Place: 12/4/24, Apartment
Commit ID: 904ce3bcefb3600e1e179b5c27dfae1cf5f182fe

Device and settings used: iPhone with voice over inspector

Strength
The app's text and buttons are fully accessible with semantic labels, making it easy to use and navigate for users with disabilities. The UI looks pretty and comfortable with no out of place color. I absolutely love the pet feature!!!! Not sure the pixels info is design or not but it still looks pretty good. the health summary (sleep/steps/calories) is beautifully visualized with bars, which is clear and engaging.

Weakness
On the settings page, when users adjust the values for sleep, steps, or calories and press save, it would be helpful to display a confirmation message indicating that the changes have been saved. Otherwise, users might feel uncertain if their updates were successfully applied.