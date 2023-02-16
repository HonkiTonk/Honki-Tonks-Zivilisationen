package TonDatentypen is
   pragma Pure;

   -- Musik
   type AnzahlLieder is range 1 .. 1;
   
   type Musik_Aktuelle_Auswahl_Enum is (
                                        Musik_Pause_Enum, Musik_Intro_Enum,
                                       
                                        Musik_Ende_Enum
                                       );
   -- Musik
   
   
   
   -- Sound
   type AnzahlSounds is range 1 .. 1;
   
   type Sound_Aktuelle_Auswahl_Enum is (
                                        Sound_Pause_Enum,
                                        
                                        Sound_Ende_Enum
                                       );
   -- Sound

end TonDatentypen;
