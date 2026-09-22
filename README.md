# CS Coders — Activity 04: Flutter Widget Wars

## Team Members

| Member | Student ID |
| --- | --- |
| Myles Miller | 002753776 |
| Zachari Taylor | 002855653 |

## How to Run

Install Flutter, then run `flutter pub get` and `flutter run` from this folder. Use `flutter test` to run the interaction checks. The app is a self-contained Flutter project with no external services or assets.

## Build Challenge

We chose **Viral Content Studio**. Its four tactile actions model a post's likes, comments, shares, and saves. Each action changes a visible count and adds a different number of engagement points: like +1, comment +2, share +3, and save +2. At 20 points, the app displays **TRENDING NOW** and changes the page background. The boost slider provides another visible state change, and the app bar control switches the whole app between light and dark themes. Each action pad depresses on touch and activates on release.

**State variables:** The content screen owns `likes`, `comments`, `shares`, `saves`, `streak`, `boostLevel`, `lastAction`, and `previousAction`. Each tactile button owns its own `isPressed`. The app root owns `isDark` because `MaterialApp` uses it to choose the global theme.

**Condition:** `isTrending` becomes true when the weighted `engagementScore` reaches 20 or more.

**Changed-state screenshot:** [CS-Coders-Round3-ChangedState.png](evidence/CS-Coders-Round3-ChangedState.png) was captured from the running Android app after six shares and one save. The 20-point trending banner and updated counts are visible.

## State Defense

`StudioHeader` and `MetricTile` are stateless because they only display values handed to them. `ContentStudioScreen` is stateful because the score, action counts, slider, and status change while the app runs. `TactileActionButton` is also stateful: each button must remember whether its own surface is currently pressed so touching one pad does not depress all four.

The private state fields live in the widgets that use or coordinate them. `_ViralContentStudioAppState` owns `isDark` because the `MaterialApp` theme depends on it. `_ContentStudioScreenState` owns the engagement values and calculates the weighted score and trending condition from them. `_TactileActionButtonState` owns `isPressed` only for that button. The underscore on these Dart names keeps implementation details private to the library.

`setState` runs when an action is released, when the boost slider moves, when a button is pressed or canceled, and when the theme changes. Flutter rebuilds the affected stateful widget's subtree to show the new values; changing a field alone would not tell Flutter to redraw. The action pads invoke a callback so the content screen updates its own counts, while the theme control invokes a callback so the app root updates the global theme.

## Round 1 Findings

The team reported a **6 / 6** score in the timed State Identification Blitz. Their answers were:

| Scenario | Team answer | Result |
| --- | --- | --- |
| 1. PriceTag | Stateless | Correct |
| 2. LikeToggle | Stateful | Correct |
| 3. MenuActionTile | Stateless | Correct |
| 4. SearchField | Stateful | Correct |
| 5. StatBadge | Stateless | Correct |
| 6. PulsingDot | Stateful | Correct |

These are the team's supplied findings, not AI-generated quiz answers. The team's [6/6 score screenshot](evidence/CS-Coders-Round1-Quiz.png) is included; it shows the score but not the report text or team name, which are recorded here.

## Round 2 Bug Fixes

1. **Bug #1 — shared press state:** Moved `isPressed` into each `TactileActionButton` so one touch affects only one pad.
2. **Bug #2 — frozen slider:** Put the slider value update inside `setState` so its thumb and label visibly update.
3. **Bug #3 — backward shadows:** Pressed pads use shallow shadows with offsets of 2; released pads use deeper shadows with offsets of 8.
4. **Bug #4 — premature action:** `onTapDown` changes only the visual state, `onTapUp` triggers the action, and `onTapCancel` restores the pad without triggering it.

The original `// 🐛 BUG #` markers remain next to the fixes in `lib/main.dart` for review. The [Bug #1 VS Code screenshot](evidence/CS-Coders-Round2-Bug1-VSCode.jpg) shows the local pressed-state fix, Myles Miller and Zachari Taylor, and the running app in one frame.

## Submission Evidence

The [Round 1 score screenshot](evidence/CS-Coders-Round1-Quiz.png), [Round 2 Bug #1 VS Code screenshot](evidence/CS-Coders-Round2-Bug1-VSCode.jpg), [changed-state app screenshot](evidence/CS-Coders-Round3-ChangedState.png), and [26-second Android demo](evidence/CS-Coders-Demo.mp4) are included. The live two-minute defense must be delivered by the team. Code and tests are included in this repository.
