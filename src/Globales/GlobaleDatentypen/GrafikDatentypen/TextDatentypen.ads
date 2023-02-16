package TextDatentypen is
   pragma Pure;

   type Schriftgröße_Enum is (
                                Überschrift_Enum, Standard_Enum, Klein_Enum
                               );
      
   type Schriftfarbe_Enum is (
                              Überschrift_Enum, Standard_Enum, Ausgewählt_Enum, Mensch_Enum, KI_Enum, Sonstiges_Enum
                             );

end TextDatentypen;
