#!/bin/bash

##
# Disable Apex to save time.
##
sed -Ei "s|^(\s+wikimediaui: 'WikimediaUI'),|\1|g" oojs-ui/Gruntfile.js
sed -Ei "s|^(\s+apex: 'Apex')|//\1|g" oojs-ui/Gruntfile.js

##
# Convert the WikimediaUI theme to use CSS custom properties for colors.
##
base=oojs-ui/src/themes/celluloid

# Add import
sed -Ei "s|'.*wikimedia-ui-base.less'|'../../../../variables.less'|g" $base/common.less

##
# Replace specific variables
##
# sed -Ei 's|^@(border-radius-base):(\s*)[^;]*;|@\1:\2var( --\1 );|g' $base/variables.less

##
# Unusable mixins
##
# mix()
sed -i 's|mix( @color-primary--active, @background-color-filled--disabled, 35% )|@color-primary--active--disabled|g' $base/elements.less
sed -i 's|mix( @color-primary--active, @background-color-filled--disabled, 35% )|@color-primary--active--disabled|g' $base/tools.less

# lighten()
# - function
sed -Ei 's|(.mw-framed-button-colored.*, @active,)|\1 @active-bg,|g' $base/common.less
sed -Ei 's|(.mw-tool-colored.*, @active,)|\1 @active-bg,|g' $base/common.less
# - function content
sed -i 's|lighten( @active, 60% )|@active-bg|g' $base/common.less
# - function calls
sed -Ei 's|(.mw-framed-button-colored.*@color-)(.*)(--active,)|\1\2\3 @background-color-\2,|g' $base/elements.less
sed -Ei 's|(.mw-tool-colored.*@color-)(.*)(--active,)|\1\2\3 @background-color-\2,|g' $base/tools.less

# darken()
sed -i 's|darken( @border-color-base, 14% )|@border-color-base--active|g' $base/widgets.less;

# Convert all images to black, except the white variants
find $base -type f -name '*.json' -exec sed -Ei '/"#fff"/! s|color": "#[^"]*"|color": "#000"|g' {} \;
