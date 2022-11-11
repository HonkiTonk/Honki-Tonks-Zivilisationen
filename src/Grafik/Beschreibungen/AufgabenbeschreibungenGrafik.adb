with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Kartentexte;

package body AufgabenbeschreibungenGrafik is

   function KurzbeschreibungVerbesserung
     (KartenVerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Kartentexte.Verbesserungen (2 * KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Pos (KartenVerbesserungExtern) - 1));
      
   end KurzbeschreibungVerbesserung;
   
   
   
   function LangbeschreibungVerbesserung
     (KartenVerbesserungExtern : in KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Kartentexte.Verbesserungen (2 * KartenverbesserungDatentypen.Karten_Verbesserung_Vorhanden_Enum'Pos (KartenVerbesserungExtern)));
      
   end LangbeschreibungVerbesserung;
   
   

   function KurzbeschreibungWeg
     (KartenWegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Kartentexte.Wege (2 * KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos (KartenWegExtern) - 1));
      
   end KurzbeschreibungWeg;
   
   

   function LangbeschreibungWeg
     (KartenWegExtern : in KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Kartentexte.Wege (2 * KartenverbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Pos (KartenWegExtern)));
      
   end LangbeschreibungWeg;

end AufgabenbeschreibungenGrafik;
