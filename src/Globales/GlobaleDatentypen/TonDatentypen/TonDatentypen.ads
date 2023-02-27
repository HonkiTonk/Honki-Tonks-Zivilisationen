package TonDatentypen is
   pragma Pure;

   -- Musik
   type AnzahlLieder is range 1 .. 1;
   
   type Musik_Aktuelle_Auswahl_Enum is (
                                        Musik_Pause_Enum,
                                        
                                        Musik_Intro_Enum,
                                       
                                        Musik_Ende_Enum
                                       );
   
   subtype Musik_Vorhanden_Enum is Musik_Aktuelle_Auswahl_Enum range Musik_Aktuelle_Auswahl_Enum'Succ (Musik_Aktuelle_Auswahl_Enum'First) .. Musik_Aktuelle_Auswahl_Enum'Pred (Musik_Aktuelle_Auswahl_Enum'Last);
   -- Musik
   
   
   
   -- Sound   
   type Sound_Aktuelle_Auswahl_Enum is (
                                        Sound_Pause_Enum,
                                        
                                        Sound_Klick_Enum, Sound_Einheitenbewegung_Enum,
                                        
                                        Sound_Ende_Enum
                                       );
   
   subtype Sound_Vorhanden_Enum is Sound_Aktuelle_Auswahl_Enum range Sound_Aktuelle_Auswahl_Enum'Succ (Sound_Aktuelle_Auswahl_Enum'First) .. Sound_Aktuelle_Auswahl_Enum'Pred (Sound_Aktuelle_Auswahl_Enum'Last);
   -- Sound

end TonDatentypen;
