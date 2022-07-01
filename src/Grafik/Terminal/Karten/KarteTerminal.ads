pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SpielVariablen;

private with KartenRecords;

private with Karten;

package KarteTerminal is

   procedure AnzeigeKarteTerminal
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private

   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure NeueZeileKartenform
     (XAchseExtern : in KartenDatentypen.Kartenfeld)
     with
       Pre => (
                 XAchseExtern <= Karten.Karteneinstellungen.Kartengröße.XAchse
              );

end KarteTerminal;
