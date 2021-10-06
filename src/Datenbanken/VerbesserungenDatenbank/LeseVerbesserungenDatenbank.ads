pragma SPARK_Mode (On);

with SonstigeDatentypen; use SonstigeDatentypen;
with GlobaleVariablen;
with KartenDatentypen;
with EinheitStadtDatentypen;

with DatenbankRecords;

package LeseVerbesserungenDatenbank is

   function VerbesserungGrafik
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
      return Wide_Wide_Character;
   
   function Passierbarkeit
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean;
   
   function VerbesserungWerte
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Bewertung_Werte_Enum)
      return EinheitStadtDatentypen.ProduktionElement
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SonstigeDatentypen.Leer);
   
   function GanzerEintrag
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
      return DatenbankRecords.VerbesserungListeRecord;

end LeseVerbesserungenDatenbank;
