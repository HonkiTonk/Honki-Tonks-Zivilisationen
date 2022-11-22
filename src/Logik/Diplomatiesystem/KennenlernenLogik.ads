with RassenDatentypen;

with LeseRassenbelegung;

package KennenlernenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   use type RassenDatentypen.Rassen_Enum;

   procedure Erstkontakt
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EigeneRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => FremdeRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EigeneRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 LeseRassenbelegung.Belegung (RasseExtern => FremdeRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure ErstkontaktMenschKI
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 (LeseRassenbelegung.Belegung (RasseExtern => EigeneRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
                  or
                    LeseRassenbelegung.Belegung (RasseExtern => FremdeRasseExtern) = RassenDatentypen.Mensch_Spieler_Enum)
              );

end KennenlernenLogik;
