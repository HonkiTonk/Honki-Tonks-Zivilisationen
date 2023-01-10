with SpeziesDatentypen;

with LeseSpeziesbelegung;

package KennenlernenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type SpeziesDatentypen.Spezies_Enum;

   procedure Erstkontakt
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      FremdeSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 EigeneSpeziesExtern /= FremdeSpeziesExtern
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EigeneSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => FremdeSpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

private

   procedure ErstkontaktMenschMensch
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      FremdeSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 EigeneSpeziesExtern /= FremdeSpeziesExtern
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EigeneSpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => FremdeSpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   procedure ErstkontaktMenschKI
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      FremdeSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 EigeneSpeziesExtern /= FremdeSpeziesExtern
               and
                 (LeseSpeziesbelegung.Belegung (SpeziesExtern => EigeneSpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
                  or
                    LeseSpeziesbelegung.Belegung (SpeziesExtern => FremdeSpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum)
              );

end KennenlernenLogik;
