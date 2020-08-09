#!/bin/bash

# I love shell scripts!
# I love Linux!

if [ -n "$1" ]; then
	dt="$1"
	cd /home/brett/Documents/Java/TotalCrafter/builds/Builder
	mkdir build-$dt
	cd build-$dt

	mkdir java
	cp -R /home/brett/Documents/Java/TotalCrafter/src/com java/com

	mkdir build
	mkdir com

	cp -R /home/brett/Documents/Java/TotalCrafter/lib/used/ build/lib/
	cp -R /home/brett/Documents/Java/TotalCrafter/lib/used/ java/lib/

	cd java

	javac -verbose -cp lib/*:. -d ../com/ com/brett/Main.java

	cd ..
	mv com/com/ temp/
	mv temp/brett com/brett
	rm -fr temp/

	echo -e "Manifest-Version: 1.0 \nMain-Class: com.brett.Main \nClass-Path: lib/*:$dt.jar" > MANIFEST.MF;
	jar -cfv0m $dt.jar MANIFEST.MF com/

	rm -fr java/
	rm -fr com/

	cp $dt.jar build/$dt.jar
	cd build

	echo "java -Dfile.encoding=UTF-8 -classpath lib/*:$dt.jar com.brett.Main" > game.sh
	chmod +x game.sh

	cp -R /home/brett/Documents/Java/TotalCrafter/resources/ resources/

else
	echo "Please enter name of this build!"
fi

#dt=$(date +'%Y-%m-%d-%H-%M')

