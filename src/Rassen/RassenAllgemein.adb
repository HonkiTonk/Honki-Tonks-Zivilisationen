pragma SPARK_Mode (On);

with GlobaleKonstanten;

package body RassenAllgemein is
   
   -- Die Rassenbelegung woanders hin verschieben?
   function RassenBelegungAnfang
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.BelegterGrund
   is begin
   
      return GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (RasseExtern)) * GlobaleKonstanten.RassenMulitplikationWert;
   
   end RassenBelegungAnfang;
   
   
   
   function RassenBelegungEnde
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.BelegterGrund
   is begin
   
      return GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (RasseExtern)) * GlobaleKonstanten.RassenMulitplikationWert
        + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last);
   
   end RassenBelegungEnde;

end RassenAllgemein;
