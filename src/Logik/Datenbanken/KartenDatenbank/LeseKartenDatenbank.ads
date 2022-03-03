pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with KartenDatentypen;
with EinheitStadtDatentypen;
with SystemKonstanten;

with DatenbankRecords;

package LeseKartenDatenbank is

   function Passierbarkeit
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean;
   
   function Bewertung
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   function Wirtschaft
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   function Kampf
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemKonstanten.LeerSpielerKonstante);
   
   function GanzerEintrag
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
      return DatenbankRecords.KartenListeRecord;

end LeseKartenDatenbank;
