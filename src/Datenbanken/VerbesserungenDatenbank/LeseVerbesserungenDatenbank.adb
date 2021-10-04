pragma SPARK_Mode (On);

with VerbesserungenDatenbank;

package body LeseVerbesserungenDatenbank is

   function VerbesserungGrafik
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
      return Wide_Wide_Character
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).VerbesserungGrafik;
      
   end VerbesserungGrafik;
   
   
   
   function Passierbarkeit
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      WelcheUmgebungExtern : in EinheitStadtDatentypen.Passierbarkeit_Vorhanden_Enum)
      return Boolean
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
      
   
   function VerbesserungWerte
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum;
      RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      WelcherWertExtern : in KartenDatentypen.Bewertung_Werte_Enum)
      return EinheitStadtDatentypen.ProduktionElement
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern).VerbesserungWerte (RasseExtern, WelcherWertExtern);
      
   end VerbesserungWerte;
   
   
   
   function GanzerEintrag
     (VerbesserungExtern : in KartenDatentypen.Karten_Verbesserung_Enum)
      return DatenbankRecords.VerbesserungListeRecord
   is begin
      
      return VerbesserungenDatenbank.VerbesserungListe (VerbesserungExtern);
      
   end GanzerEintrag;

end LeseVerbesserungenDatenbank;
