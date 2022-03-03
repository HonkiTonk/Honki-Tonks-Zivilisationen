pragma SPARK_Mode (On);

with KartenDatenbank;

package body LeseKartenDatenbank is

   function Passierbarkeit
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return KartenDatenbank.KartenListe (GrundExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
   
   
   function Bewertung
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return KartenDatenbank.KartenListe (GrundExtern).Bewertung (RasseExtern);
      
   end Bewertung;
   
   
   
   function Wirtschaft
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (GrundExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end Wirtschaft;
   
   
   
   function Kampf
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.KartenListe (GrundExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end Kampf;
   
   
   
   function GanzerEintrag
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
      return DatenbankRecords.KartenListeRecord
   is begin
      
      return KartenDatenbank.KartenListe (GrundExtern);
      
   end GanzerEintrag;

end LeseKartenDatenbank;
