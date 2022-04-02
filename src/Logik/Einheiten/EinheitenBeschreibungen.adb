pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with GlobaleTexte;

with Auswahl;

package body EinheitenBeschreibungen is

   function BeschreibungKurz
     (IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return Wide_Wide_String
   is begin
          
      Textnummer := 2 * Positive (IDExtern) - 1;
               
      BeschreibungText := GlobaleTexte.Einheiten (Textnummer);
      
      return To_Wide_Wide_String (Source => BeschreibungText);
         
   end BeschreibungKurz;
   
   
   
   function BeschreibungLang
     (IDExtern : in EinheitStadtDatentypen.EinheitenID)
      return Wide_Wide_String
   is begin
      
      -- Bei lang muss aktuell immer die zweite Spalte aufgerufen werden, deswegen fehlt hier auch das -1.
      Textnummer := 2 * Positive (IDExtern);
               
      BeschreibungText := GlobaleTexte.Einheiten (Textnummer);
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungLang;
   
   
   
   function Beschäftigung
     (ArbeitExtern : in AufgabenDatentypen.Einheiten_Aufgaben_Enum)
      return Wide_Wide_String
   is begin
      
      BeschäftigungText := GlobaleTexte.Beschäftigungen (2 * AufgabenDatentypen.Einheiten_Aufgaben_Enum'Pos (ArbeitExtern) + 1);
         
      return To_Wide_Wide_String (Source => BeschäftigungText);
      
   end Beschäftigung;
   
      

   function BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen
     (WelcheAuswahlExtern : in Natural)
      return Boolean
   is begin
         
      case
        Auswahl.AuswahlJaNein (FrageZeileExtern => WelcheAuswahlExtern)
      is
         when SystemDatentypen.Ja_Enum =>
            return True;
            
         when others =>
            return False;
      end case;
      
   end BeschäftigungAbbrechenVerbesserungErsetzenBrandschatzenEinheitAuflösen;

end EinheitenBeschreibungen;
