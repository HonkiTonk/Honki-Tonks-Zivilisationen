pragma SPARK_Mode (On);

with GlobaleDatentypen, KartenRecords, KartenDatentypen;
use GlobaleDatentypen;

package KartenGeneratorBerechnungenAllgemein is
   
   type AnzahlGleicherFelder is range 0 .. 8;
   AnzahlGleicherGrundBestimmen : AnzahlGleicherFelder;

   function GleicherGrundAnzahlBestimmen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in KartenDatentypen.Karten_Grund_Alle_Felder_Enum;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return AnzahlGleicherFelder;
   
private
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

end KartenGeneratorBerechnungenAllgemein;
