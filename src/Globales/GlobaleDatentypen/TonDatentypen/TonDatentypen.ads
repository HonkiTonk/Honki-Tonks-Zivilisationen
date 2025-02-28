package TonDatentypen is
   pragma Pure;

   -- Musik
   type AnzahlLieder is range 1 .. 1;
   
   type Musikart_Enum is (
                          Musik_Pause_Enum,
                                        
                          Musik_Intro_Enum,
                                        
                          Musik_Spiel_Enum,
                                        
                          Musik_Forschung_Enum,
                                       
                          Musik_Ende_Enum
                         );
   
   subtype Musikart_Vorhanden_Enum is Musikart_Enum range Musikart_Enum'Succ (Musikart_Enum'First) .. Musikart_Enum'Pred (Musikart_Enum'Last);
   -- Musik
   
   
   
   -- Sound   
   type Sound_Enum is (
                       Sound_Pause_Enum,
                                        
                       Sound_Klick_Enum, Sound_Einheitenbewegung_Enum,
                                        
                       Sound_Ende_Enum
                      );
   
   subtype Sound_Vorhanden_Enum is Sound_Enum range Sound_Enum'Succ (Sound_Enum'First) .. Sound_Enum'Pred (Sound_Enum'Last);
   -- Sound

end TonDatentypen;
