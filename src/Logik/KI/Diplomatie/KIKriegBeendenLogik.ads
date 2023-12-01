package KIKriegBeendenLogik is
   pragma Elaborate_Body;

   function KriegBeenden
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      FeindlicheSpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EigeneSpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => FeindlicheSpeziesExtern) /= GlobaleDatentypen.Leer
               and
                 EigeneSpeziesExtern /= FeindlicheSpeziesExtern
              );

end KIKriegBeendenLogik;
