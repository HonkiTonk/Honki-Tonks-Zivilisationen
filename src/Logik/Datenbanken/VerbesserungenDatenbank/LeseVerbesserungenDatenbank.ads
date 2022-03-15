pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with KartenDatentypen;
with EinheitStadtDatentypen;
with SystemKonstanten;
with KartenVerbesserungDatentypen;

with DatenbankRecords;

package LeseVerbesserungenDatenbank is

   function Passierbarkeit
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean;
   
   function Bewertung
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   function Wirtschaft
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   function Kampf
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   function GanzerEintrag
     (VerbesserungExtern : in KartenVerbesserungDatentypen.Karten_Verbesserung_Enum)
      return DatenbankRecords.VerbesserungListeRecord;

end LeseVerbesserungenDatenbank;
