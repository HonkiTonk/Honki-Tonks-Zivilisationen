pragma SPARK_Mode (On);

with KartenDatenbank;

package body LeseKartenDatenbank is

   function KartenGrafik
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
      return Wide_Wide_Character
   is begin
      
      return KartenDatenbank.KartenListe (GrundExtern).KartenGrafik;
      
   end KartenGrafik;
   
   
      
   function Passierbarkeit
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return KartenDatenbank.KartenListe (GrundExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
   
   
   function FeldWerte
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Bewertung_Werte_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return KartenDatenbank.KartenListe (GrundExtern).FeldWerte (RasseExtern, WelcherWertExtern);
      
   end FeldWerte;
   
   
   
   function GanzerEintrag
     (GrundExtern : in KartenDatentypen.Karten_Grund_Enum)
      return DatenbankRecords.KartenListeRecord
   is begin
      
      return KartenDatenbank.KartenListe (GrundExtern);
      
   end GanzerEintrag;

end LeseKartenDatenbank;
