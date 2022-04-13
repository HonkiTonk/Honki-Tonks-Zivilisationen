pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenRecords;
with KartenDatentypen;
with KartenGrundDatentypen;

package KartenGeneratorBerechnungenAllgemein is
   
   type AnzahlGleicherFelder is range 0 .. 8;
   AnzahlGleicherGrundBestimmen : AnzahlGleicherFelder;

   function GleicherGrundAnzahlBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Alle_Felder_Enum;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return AnzahlGleicherFelder;
   
private
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

end KartenGeneratorBerechnungenAllgemein;
