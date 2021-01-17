# Civ-Klon
Mein Civilization-Klon, geschrieben in Ada.
Momentan nur unter Linux getestet, sollte aber auch unter anderen Betriebssystemen funktionieren, wenn man es für die jeweilige Plattform kompiliert. Außerdem werden diverse Control Sequence Introducer Befehle verwendet welche nicht in jeder Konsole korrekt funktionieren.

Zum kompilieren muss der Befehl -gnatW8 genutzt werden, da es sonst zu Problemen mit den verwendeten Sonderzeichen kommt.
Außerdem wird SDLAda (https://github.com/Lucretia/sdlada) für zukünftige Funktionen benötigt. Aktuell kann man auch einfach
limited with "SDL/share/gpr/sdlada.gpr";
aus der stream.gpr entfernen, da die SDL noch nicht genutzt wird.

Aktuelle Version: 0.00.6140