package TextDatentypen is
   pragma Pure;

   -- Da noch ein Leer_Enum hinzufügen um auch nicht zu akzeptieren? äöü
   type Schriftgröße_Enum is (
                                Überschrift_Enum, Standard_Enum, Klein_Enum
                               );
      
   type Schriftfarbe_Enum is (
                              Überschrift_Enum,
                              
                              Standard_Enum, Ausgewählt_Enum, Aktiver_Menübereich_Enum,
                              
                              Mensch_Enum, KI_Enum,
                              
                              Sonstiges_Enum
                             );

end TextDatentypen;
