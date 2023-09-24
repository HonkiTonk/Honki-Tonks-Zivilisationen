with Kartentexte;

package body AufgabenbeschreibungenGrafik is

   function KurzbeschreibungVerbesserung
     (KartenVerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Kartentexte.Verbesserungen (2 * KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Pos (KartenVerbesserungExtern) - 1);
      
   end KurzbeschreibungVerbesserung;
   
   
   
   function LangbeschreibungVerbesserung
     (KartenVerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Kartentexte.Verbesserungen (2 * KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Pos (KartenVerbesserungExtern));
      
   end LangbeschreibungVerbesserung;
   
   

   function KurzbeschreibungWeg
     (KartenWegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Kartentexte.Wege (2 * KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Pos (KartenWegExtern) - 1);
      
   end KurzbeschreibungWeg;
   
   

   function LangbeschreibungWeg
     (KartenWegExtern : in KartenverbesserungDatentypen.Weg_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Kartentexte.Wege (2 * KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Pos (KartenWegExtern));
      
   end LangbeschreibungWeg;

end AufgabenbeschreibungenGrafik;
