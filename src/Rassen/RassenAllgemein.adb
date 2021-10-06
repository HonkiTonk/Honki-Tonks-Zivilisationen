pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with SonstigesKonstanten;
with EinheitStadtDatentypen;

package body RassenAllgemein is
   
   -- Die Rassenbelegung woanders hin verschieben?
   function RassenBelegungAnfang
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BelegterGrund
   is begin
   
      return KartenDatentypen.BelegterGrund (SonstigeDatentypen.Rassen_Verwendet_Enum'Pos (RasseExtern)) * SonstigesKonstanten.RassenMulitplikationWert;
   
   end RassenBelegungAnfang;
   
   
   
   function RassenBelegungEnde
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BelegterGrund
   is begin
   
      return KartenDatentypen.BelegterGrund (SonstigeDatentypen.Rassen_Verwendet_Enum'Pos (RasseExtern)) * SonstigesKonstanten.RassenMulitplikationWert
        + KartenDatentypen.BelegterGrund (EinheitStadtDatentypen.MaximaleStädte'Last);
   
   end RassenBelegungEnde;

end RassenAllgemein;
