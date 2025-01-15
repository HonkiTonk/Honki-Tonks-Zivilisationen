rm /mnt/Programme/Ada/GitHub/ -r
mkdir /mnt/Programme/Ada/GitHub
mkdir /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Linux
mkdir /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows
cd /mnt/Programme/Ada/GitHub/



# Windows
gprbuild -d -f -P /mnt/Programme/Ada/Zivilisationen/HonkiTonksZivilisationen_Windows_Release.gpr --target=x86_64-w64-mingw32

cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Grafik/ /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Musik/ /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Sound/ /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Sprachen/ /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/ -r

cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/honkitonkszivilisationen.exe /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/LICENSE /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/csfml-audio-2.dll /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/csfml-graphics-2.dll /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/csfml-network-2.dll /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/csfml-system-2.dll /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/csfml-window-2.dll /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/openal32.dll /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/sfml-audio-2.dll /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/sfml-graphics-2.dll /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/sfml-network-2.dll /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/sfml-system-2.dll /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/sfml-window-2.dll /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Windows/

zip -9 -r Honki_Tonks_Zivilisationen_Windows64.zip Honki\ Tonks\ Zivilisationen\ Windows/



# Linux
gprbuild -d -f -P /mnt/Programme/Ada/Zivilisationen/HonkiTonksZivilisationen_Release.gpr

cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Grafik/ /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Linux/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Musik/ /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Linux/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Sound/ /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Linux/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Sprachen/ /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Linux/ -r

cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/HonkiTonksZivilisationen /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Linux/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/LICENSE /mnt/Programme/Ada/GitHub/Honki\ Tonks\ Zivilisationen\ Linux/

tar cfv Honki_Tonks_Zivilisationen_Linux64.tar Honki\ Tonks\ Zivilisationen\ Linux/
bzip2 -9 Honki_Tonks_Zivilisationen_Linux64.tar