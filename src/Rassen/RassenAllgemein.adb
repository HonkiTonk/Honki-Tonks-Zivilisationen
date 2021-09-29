pragma SPARK_Mode (On);

with SonstigesKonstanten;

package body RassenAllgemein is
   
   -- Die Rassenbelegung woanders hin verschieben?
   function RassenBelegungAnfang
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.BelegterGrund
   is begin
   
      return GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (RasseExtern)) * SonstigesKonstanten.RassenMulitplikationWert;
   
   end RassenBelegungAnfang;
   
   
   
   function RassenBelegungEnde
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.BelegterGrund
   is begin
   
      return GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (RasseExtern)) * SonstigesKonstanten.RassenMulitplikationWert
        + GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.MaximaleStädte'Last);
   
   end RassenBelegungEnde;

end RassenAllgemein;
