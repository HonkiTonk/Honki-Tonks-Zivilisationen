pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleRecords, GlobaleVariablen;
use GlobaleDatentypen;

with Karten;

package VerbesserungenAnlegbarErmitteln is

   function VerbesserungenAnlegbar
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      WelcheVerbesserungExtern : in GlobaleDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum)
      return Boolean
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer
          and
            KoordinatenExtern.YAchse <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
          and
            KoordinatenExtern.XAchse <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

private

   type VerbessserungenArray is array (GlobaleDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range) of Boolean;
   Verbesserungen : VerbessserungenArray;

end VerbesserungenAnlegbarErmitteln;
