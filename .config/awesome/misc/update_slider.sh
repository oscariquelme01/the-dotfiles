# This is meant to be an script that will fetch the git version of the wibox slider widget and update your awesomewm slider file
# This is necessary since the awesome package on arch has no bar_active_color property
# Its probably not the best solution but it works!

#!/bin/bash

# Awesomewm is usually installed under /usr
PATH_TO_SLIDER=$(find /usr -name "slider.lua" 2>&-)
echo "Found the slider file at $PATH_TO_SLIDER"

# Get content of the git slider.lua file
URL="https://raw.githubusercontent.com/awesomeWM/awesome/master/lib/wibox/widget/slider.lua"
UPDATED_CONTENT=$(curl ${URL})

# Update the content of the slider file
echo "$UPDATED_CONTENT" > "$PATH_TO_SLIDER"
