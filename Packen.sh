rm /mnt/Programme/Ada/GitHub/ -r
mkdir /mnt/Programme/Ada/GitHub
cd /mnt/Programme/Ada/GitHub/
mkdir Honki\ Tonks\ Zivilisationen\ Linux
mkdir Honki\ Tonks\ Zivilisationen\ Windows



# Windows
# gprbuild -d -f -P /mnt/Programme/Ada/Zivilisationen/HonkiTonksZivilisationen_Windows_Release26.gpr --target=x86_64-w64-mingw32

cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Grafik/ Honki\ Tonks\ Zivilisationen\ Windows/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Musik/ Honki\ Tonks\ Zivilisationen\ Windows/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Sound/ Honki\ Tonks\ Zivilisationen\ Windows/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Sprachen/ Honki\ Tonks\ Zivilisationen\ Windows/ -r

cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/HonkiTonksZivilisationen.exe Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/LICENSE Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/csfml-audio-2.dll Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/csfml-graphics-2.dll Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/csfml-network-2.dll Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/csfml-system-2.dll Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/csfml-window-2.dll Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/openal32.dll Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/sfml-audio-2.dll Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/sfml-graphics-2.dll Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/sfml-network-2.dll Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/sfml-system-2.dll Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/sfml-window-2.dll Honki\ Tonks\ Zivilisationen\ Windows/

zip -9 -r Honki_Tonks_Zivilisationen_Windows64.zip Honki\ Tonks\ Zivilisationen\ Windows/



# Linux
gprbuild -d -f -P /mnt/Programme/Ada/Zivilisationen/HonkiTonksZivilisationen_Release25.gpr

cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Grafik/Honki\ Tonks\ Zivilisationen\ Linux/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Musik/ Honki\ Tonks\ Zivilisationen\ Linux/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Sound/ Honki\ Tonks\ Zivilisationen\ Linux/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Sprachen/ Honki\ Tonks\ Zivilisationen\ Linux/ -r

cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/HonkiTonksZivilisationen Honki\ Tonks\ Zivilisationen\ Linux/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/LICENSE Honki\ Tonks\ Zivilisationen\ Linux/

tar cfv Honki_Tonks_Zivilisationen_Linux64.tar Honki\ Tonks\ Zivilisationen\ Linux/
bzip2 -9 Honki_Tonks_Zivilisationen_Linux64.tar



gprbuild -d -f -P /mnt/Programme/Ada/Zivilisationen/HonkiTonksZivilisationen25.gpr