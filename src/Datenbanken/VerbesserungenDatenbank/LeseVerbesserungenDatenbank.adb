pragma SPARK_Mode (On);

with VerbesserungenDatenbank;

package body LeseVerbesserungenDatenbank is

   function VerbesserungGrafik
     (VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum)
      return Wide_Wide_Character
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).VerbesserungGrafik;
      
   end VerbesserungGrafik;
   
   
   
   function Passierbarkeit
     (VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum;
      WelcheUmgebungExtern : in GlobaleDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
      
   
   function VerbesserungWerte 
     (VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in GlobaleDatentypen.Bewertung_Werte_Enum)
      return GlobaleDatentypen.ProduktionElement
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).VerbesserungWerte (RasseExtern, WelcherWertExtern);
      
   end VerbesserungWerte;
   
   
   
   function GanzerEintrag
     (VerbesserungExtern : in GlobaleDatentypen.Karten_Verbesserung_Enum)
      return DatenbankRecords.VerbesserungListeRecord
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern);
      
   end GanzerEintrag;

end LeseVerbesserungenDatenbank;
