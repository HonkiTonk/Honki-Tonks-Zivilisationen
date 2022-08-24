pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package TonDatentypen is

   -- Musik
   type AnzahlLieder is new Integer range 1 .. 10;
   
   type Musik_Aktuelle_Auswahl_Enum is (
                                        Musik_Pause_Enum, Musik_Intro_Enum,
                                       
                                        Musik_Ende_Enum
                                       );
   -- Musik
   
   
   
   -- Sound
   type AnzahlSounds is new Integer range 1 .. 10;
   
   type Sound_Aktuelle_Auswahl_Enum is (
                                        Sound_Pause_Enum,
                                        
                                        Sound_Ende_Enum
                                       );
   -- Sound

end TonDatentypen;
