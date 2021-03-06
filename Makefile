setup:
	bash setup.sh $(TAG)

create:
	rm -f oojs-ui/php/themes/CelluloidTheme.php
	rm -rf oojs-ui/src/themes/celluloid
	cd oojs-ui && npx grunt add-theme --name=Celluloid --template=WikimediaUI

convert:
	bash convert.sh

build:
	cd oojs-ui && npx grunt build

copy:
	rm -rf dist/$(TAG)/
	mkdir -p dist/$(TAG)/resources/ooui/themes
	cp oojs-ui/dist/*celluloid* dist/$(TAG)/resources/ooui
	cp -r oojs-ui/dist/images dist/$(TAG)/resources/ooui || true
	cp -r oojs-ui/dist/themes/celluloid dist/$(TAG)/resources/ooui/themes
	mkdir -p dist/$(TAG)/includes/ooui
	cp oojs-ui/php/themes/CelluloidTheme.php dist/$(TAG)/includes/ooui

check-diff:
	bash check-diff.sh
