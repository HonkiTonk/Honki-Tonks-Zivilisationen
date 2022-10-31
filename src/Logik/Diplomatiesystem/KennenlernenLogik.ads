pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

package KennenlernenLogik is
   pragma Elaborate_Body;

   procedure Erstkontakt
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SpielVariablen.Rassenbelegung (EigeneRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (FremdeRasseExtern).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   procedure ErstkontaktMenschMensch
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 SpielVariablen.Rassenbelegung (EigeneRasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (FremdeRasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure ErstkontaktMenschKI
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 EigeneRasseExtern /= FremdeRasseExtern
               and
                 (SpielVariablen.Rassenbelegung (EigeneRasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
                  or
                    SpielVariablen.Rassenbelegung (FremdeRasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum)
              );

end KennenlernenLogik;
