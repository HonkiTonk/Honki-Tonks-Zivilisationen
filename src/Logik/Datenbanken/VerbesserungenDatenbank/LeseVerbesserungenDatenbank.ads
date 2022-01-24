pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
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
   
   function Bewertung
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   function Wirtschaft
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   function Kampf
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   function GanzerEintrag
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
      return DatenbankRecords.VerbesserungListeRecord;

end LeseVerbesserungenDatenbank;
