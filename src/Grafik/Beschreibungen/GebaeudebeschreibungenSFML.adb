pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleTexte;
with TextKonstanten;

package body GebaeudebeschreibungenSFML is

   function BeschreibungKurz
     (IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return Wide_Wide_String
   is begin
      
      case
        IDExtern
      is
         when StadtDatentypen.GebäudeIDMitNullwert'First =>
            BeschreibungText := TextKonstanten.LeerUnboundedString;
            
         when others =>
            BeschreibungText := GlobaleTexte.Gebäude (2 * Positive (IDExtern) - 1);
      end case;
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungKurz;
   
   
   
   function BeschreibungLang
     (IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return Wide_Wide_String
   is begin
      
      case
        IDExtern
      is
         when StadtDatentypen.GebäudeIDMitNullwert'First =>
            BeschreibungText := TextKonstanten.LeerUnboundedString;
            
         when others =>
            BeschreibungText := GlobaleTexte.Gebäude (2 * Positive (IDExtern));
      end case;
      
      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungLang;

end GebaeudebeschreibungenSFML;
