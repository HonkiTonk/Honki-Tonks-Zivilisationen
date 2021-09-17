pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

package KartenGeneratorBerechnungenAllgemein is
   
   type AnzahlGleicherFelder is range 0 .. 8;
   AnzahlGleicherGrundBestimmen : AnzahlGleicherFelder;

   function GleicherGrundAnzahlBestimmen
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Alle_Felder_Enum;
      EbeneExtern : in GlobaleDatentypen.EbeneVorhanden)
      return AnzahlGleicherFelder;
   
private
   
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivRecord;

end KartenGeneratorBerechnungenAllgemein;
