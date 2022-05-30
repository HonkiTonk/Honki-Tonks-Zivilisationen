pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with KartenDatentypen;
with KartenRecords;

package KarteKonsole is

   procedure AnzeigeKarteKonsole
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum);
   
private

   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure NeueZeileKartenform
     (XAchseExtern : in KartenDatentypen.Kartenfeld);

end KarteKonsole;
