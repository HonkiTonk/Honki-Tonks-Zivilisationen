pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with DatenbankRecords;

package LeseVerbesserungenDatenbank is

   function VerbesserungGrafik
     (VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum)
      return Wide_Wide_Character;
   
   function Passierbarkeit
     (VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum;
      WelcheUmgebungExtern : in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean;
   
   function VerbesserungWerte 
     (VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in GlobaleDatentypen.Bewertung_Werte_Enum)
      return GlobaleDatentypen.ProduktionElement
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   function GanzerEintrag
     (VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum)
      return DatenbankRecords.VerbesserungListeRecord;

end LeseVerbesserungenDatenbank;
