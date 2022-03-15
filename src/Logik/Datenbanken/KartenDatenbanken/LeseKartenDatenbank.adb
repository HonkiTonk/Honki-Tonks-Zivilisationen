pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatenbank;

package body LeseKartenDatenbank is

   function Passierbarkeit
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return KartenDatenbank.KartenFelderListe (GrundExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
   
   
   function Bewertung
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.BewertungFeld
   is begin
      
      return KartenDatenbank.KartenFelderListe (GrundExtern).Bewertung (RasseExtern);
      
   end Bewertung;
   
   
   
   function Wirtschaft
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WirtschaftArtExtern : in KartenDatentypen.Wirtschaft_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenFelderListe (GrundExtern).Wirtschaft (RasseExtern, WirtschaftArtExtern);
      
   end Wirtschaft;
   
   
   
   function Kampf
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KampfArtExtern : in KartenDatentypen.Kampf_Enum)
      return EinheitStadtDatentypen.KampfwerteAllgemein
   is begin
      
      return KartenDatenbank.KartenFelderListe (GrundExtern).Kampf (RasseExtern, KampfArtExtern);
      
   end Kampf;
   
   
   
   function GanzerEintrag
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum)
      return DatenbankRecords.KartenListeRecord
   is begin
      
      return KartenDatenbank.KartenFelderListe (GrundExtern);
      
   end GanzerEintrag;

end LeseKartenDatenbank;
