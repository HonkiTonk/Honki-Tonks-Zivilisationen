package SpielDatentypen is
   pragma Pure;

   type Schwierigkeitsgrad_Enum is (
                                    Schwierigkeitsgrad_Leicht_Enum, Schwierigkeitsgrad_Mittel_Enum, Schwierigkeitsgrad_Schwer_Enum
                                   );
   pragma Ordered (Schwierigkeitsgrad_Enum);

end SpielDatentypen;
