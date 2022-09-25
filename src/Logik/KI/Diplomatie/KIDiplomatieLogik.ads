pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

package KIDiplomatieLogik is

   procedure Diplomatie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

   procedure DiplomatieKIMensch
     (RasseMenschExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseKIExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseMenschExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (RasseKIExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

   procedure DiplomatieKIKI
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseKIExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (EigeneRasseExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
               and
                 SpielVariablen.Rassenbelegung (FremdeRasseKIExtern).Belegung = RassenDatentypen.KI_Spieler_Enum
              );

end KIDiplomatieLogik;
