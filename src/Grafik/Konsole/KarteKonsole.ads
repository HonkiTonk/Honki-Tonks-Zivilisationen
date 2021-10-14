pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with GlobaleVariablen;
with KartenDatentypen;
with KartenRecords;

package KarteKonsole is

   procedure AnzeigeKarteKonsole
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);
   
private

   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure NeueZeileKartenform
     (XAchseExtern : in KartenDatentypen.Kartenfeld);

end KarteKonsole;
