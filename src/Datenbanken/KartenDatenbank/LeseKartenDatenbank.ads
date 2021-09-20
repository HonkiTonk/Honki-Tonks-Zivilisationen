pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with DatenbankRecords;

package LeseKartenDatenbank is

   function KartenGrafik
     (GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum)
      return Wide_Wide_Character;
      
   function Passierbarkeit
     (GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      WelcheUmgebungExtern : in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean;
   
   function FeldWerte
     (GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in GlobaleDatentypen.Bewertung_Werte_Enum)
      return GlobaleDatentypen.ProduktionElement
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   function GanzerEintrag
     (GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum)
      return DatenbankRecords.KartenListeRecord;

end LeseKartenDatenbank;
