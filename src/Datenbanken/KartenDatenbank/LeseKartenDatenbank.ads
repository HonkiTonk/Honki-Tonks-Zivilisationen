pragma SPARK_Mode (On);

with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

with DatenbankRecords;

package LeseKartenDatenbank is

   function KartenGrafik
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
      return Wide_Wide_Character;
      
   function Passierbarkeit
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean;
   
   function FeldWerte
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Bewertung_Werte_Enum)
      return EinheitStadtDatentypen.ProduktionElement
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= GlobaleDatentypen.Leer);
   
   function GanzerEintrag
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
      return DatenbankRecords.KartenListeRecord;

end LeseKartenDatenbank;
