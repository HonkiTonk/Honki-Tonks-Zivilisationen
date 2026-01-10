rm /mnt/Programme/Ada/GitHub/ -r
mkdir /mnt/Programme/Ada/GitHub
cd /mnt/Programme/Ada/GitHub/
mkdir Honki\ Tonks\ Zivilisationen\ Linux
mkdir Honki\ Tonks\ Zivilisationen\ Windows



# Windows
# A/C/SFML 2.5.X
gprbuild -d -f -P /mnt/Programme/Ada/Zivilisationen/HonkiTonksZivilisationen_Windows_Release25.gpr --target=x86_64-w64-mingw32

cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Grafik/ Honki\ Tonks\ Zivilisationen\ Windows/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Musik/ Honki\ Tonks\ Zivilisationen\ Windows/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Sound/ Honki\ Tonks\ Zivilisationen\ Windows/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Sprachen/ Honki\ Tonks\ Zivilisationen\ Windows/ -r
cp /mnt/Programme/Ada/Zivilisationen/DLL/CSFML2.5.2_SFML2.5.1/. Honki\ Tonks\ Zivilisationen\ Windows -r

cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/LICENSE Honki\ Tonks\ Zivilisationen\ Windows/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Honki\ Tonks\ Zivilisationen.exe Honki\ Tonks\ Zivilisationen\ Windows/

zip -9 -r Honki_Tonks_Zivilisationen_Windows64_SFML25.zip Honki\ Tonks\ Zivilisationen\ Windows/



read -p "Warte auf Eingabe" -n1 -s



# A/C/SFML 2.6.X
# gprbuild -d -f -P /mnt/Programme/Ada/Zivilisationen/HonkiTonksZivilisationen_Windows_Release26.gpr --target=x86_64-w64-mingw32

# cp /mnt/Programme/Ada/Zivilisationen/DLL/CSFML2.6.1_SFML2.6.2/. Honki\ Tonks\ Zivilisationen\ Windows -r

# cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Honki\ Tonks\ Zivilisationen.exe Honki\ Tonks\ Zivilisationen\ Windows/

# zip -9 -r Honki_Tonks_Zivilisationen_Windows64_SFML26.zip Honki\ Tonks\ Zivilisationen\ Windows/



# Linux
# A/C/SFML 2.5.X
gprbuild -d -f -P /mnt/Programme/Ada/Zivilisationen/HonkiTonksZivilisationen_Release25.gpr

cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Grafik/ Honki\ Tonks\ Zivilisationen\ Linux/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Musik/ Honki\ Tonks\ Zivilisationen\ Linux/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Sound/ Honki\ Tonks\ Zivilisationen\ Linux/ -r
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Sprachen/ Honki\ Tonks\ Zivilisationen\ Linux/ -r

cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/LICENSE Honki\ Tonks\ Zivilisationen\ Linux/
cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Honki\ Tonks\ Zivilisationen Honki\ Tonks\ Zivilisationen\ Linux/

tar cfv Honki_Tonks_Zivilisationen_Linux64_SFML25.tar Honki\ Tonks\ Zivilisationen\ Linux/
bzip2 -9 Honki_Tonks_Zivilisationen_Linux64_SFML25.tar



read -p "Warte auf Eingabe" -n1 -s



# A/C/SFML 2.6.X
# gprbuild -d -f -P /mnt/Programme/Ada/Zivilisationen/HonkiTonksZivilisationen_Release26.gpr

# cp /mnt/Programme/Ada/Zivilisationen/Honki\ Tonks\ Zivilisationen/Honki\ Tonks\ Zivilisationen Honki\ Tonks\ Zivilisationen\ Linux/

# tar cfv Honki_Tonks_Zivilisationen_Linux64_SFML26.tar Honki\ Tonks\ Zivilisationen\ Linux/
# bzip2 -9 Honki_Tonks_Zivilisationen_Linux64_SFML26.tar



# gprbuild -d -f -P /mnt/Programme/Ada/Zivilisationen/HonkiTonksZivilisationen25.gpr
