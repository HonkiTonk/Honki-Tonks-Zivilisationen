package DiplomatieDatentypen is
   pragma Pure;

   type Status_Untereinander_Enum is (
                                      Unbekannt_Enum, Neutral_Enum, Nichtangriffspakt_Enum, Krieg_Enum
                                     );
   
   subtype Status_Untereinander_Bekannt_Enum is Status_Untereinander_Enum range Neutral_Enum .. Status_Untereinander_Enum'Last;
   
   type Meinung is range -100 .. 100;
   subtype MeinungPositive is Meinung range 1 .. 100;

end DiplomatieDatentypen;
