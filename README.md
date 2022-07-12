#  TAP 2023 GDS ACE Tech Assessment (Submission)

## Background : Assessment Prompt
It’s the time of the year again when Govtech holds its annual football championship where 12 teams will compete for the grand prize of honour and glory. The teams will be split into 2 groups of 6 where each team will play a match against every other team within the same group. The top 4 teams of each group will then qualify for the next round. The ranking of the teams for each group will be evaluated using these metrics in the following order:

1. Highest total match points. A win is worth 3 points, a draw is worth 1 point, and a loss is worth 0 points.
2. If teams are tied, highest total goals scored.
3. If teams are still tied, highest alternate total match points. A win is worth 5 points, a draw is worth 3 points, and a loss is worth 1 point.
4. If teams are still tied, earliest registration date.

## Instructions
Run on XCode on iOS Simulators.

## Assumptions, Interpretations and Architecture
* UX & UI decisions were assumed to be on mobile iOS.
* List of Teams displayed were to visualize and check the inputted team details.
* Initial assumption was that there were at least 4 sets of teams with different match points per set -> then tie-breakers would only produce one qualifying team per set.
* I then questioned if that was fair in a realistic setting as a team with lower match points would still qualify if a set of teams with higher match points tied with only one of them qualifying.
* So then I simplified the model to filling the quota for qualifying teams up to the required 4. 
* If there were more teams that tied for the remaining spots -> then break tie with deeper level tiebreaker and fill 
* If qualifying team quota has not been filled -> start on next set of tied match point teams.

## License
[MIT](https://choosealicense.com/licenses/mit/)
