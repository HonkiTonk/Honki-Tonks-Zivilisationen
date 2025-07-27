package BetriebssystemDatentypenHTSEB is
   pragma Pure;

   type Betriebssystem_Enum is (
                                Linux_Enum,
                                
                                Windows_Enum
                               );

   type Kodierung_Enum is (
                           UTF8_Enum, UTF16BE_Enum, UTF16LE_Enum
                          );
   
   type Standardsprachen_Enum is (
                                  Arabisch_Enum, Chinesisch_Vereinfacht_Enum, Dänisch_Enum, Deutsch_Enum, Englisch_Enum, Spanisch_Enum, Französisch_Enum, Griechisch_Enum, Indonesisch_Enum, Italienisch_Enum,
                                  Japanisch_Enum, Koreanisch_Enum, Niederländisch_Enum, Norwegisch_Enum, Polnisch_Enum, Portugisisch_Enum, Ukrainisch_Enum
                                 );

end BetriebssystemDatentypenHTSEB;
