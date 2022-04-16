pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package TonDatentypen is

   -- Musik
   type AnzahlLieder is new Integer range 1 .. 10;
   
   type Musik_Aktuelle_Auswahl_Enum is (
                                        Musik_Konsole_Enum, Musik_SFML_Enum, Musik_Intro_Enum,
                                       
                                        Musik_Ende_Enum
                                       );
   -- Musik
   
   
   
   -- Sound
   type AnzahlSounds is new Integer range 1 .. 10;
   
   -- Sound in der Konsole drin lassen? Piepsound kann sie ja theoretisch? Als zukünftiges Feature?
   -- Wahrscheinlich einfach nur sinnlos und wird niemals eingebaut werden.
   type Sound_Aktuelle_Auswahl_Enum is (
                                        Sound_Konsole_Enum, Sound_SFML_Enum,
                                        
                                        Sound_Ende_Enum
                                       );
   -- Sound

end TonDatentypen;
