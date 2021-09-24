pragma SPARK_Mode (On);

with GlobaleDatentypen, KartenRecords;
use GlobaleDatentypen;

package KartenGeneratorBerechnungenAllgemein is
   
   type AnzahlGleicherFelder is range 0 .. 8;
   AnzahlGleicherGrundBestimmen : AnzahlGleicherFelder;

   function GleicherGrundAnzahlBestimmen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum;
      EbeneExtern : in GlobaleDatentypen.EbeneVorhanden)
      return AnzahlGleicherFelder;
   
private
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

end KartenGeneratorBerechnungenAllgemein;
