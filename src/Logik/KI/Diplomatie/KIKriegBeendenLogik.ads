package KIKriegBeendenLogik is
   pragma Elaborate_Body;

   function KriegBeenden
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FeindlicheRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => EigeneRasseExtern) = RassenDatentypen.KI_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => FeindlicheRasseExtern) /= GlobaleDatentypen.Leer
               and
                 EigeneRasseExtern /= FeindlicheRasseExtern
              );

end KIKriegBeendenLogik;
