package BetriebssystemDatentypenHTSEB is
   pragma Pure;

   type Betriebssystem_Enum is (
                                Linux_Enum,
                                
                                Windows_Enum
                               );
   subtype Betriebsystem_Zeichenabzug_Enum is Betriebssystem_Enum range Windows_Enum .. Windows_Enum;

   type Kodierung_Enum is (
                           UTF8_Enum, UTF16BE_Enum, UTF16LE_Enum
                          );

end BetriebssystemDatentypenHTSEB;
