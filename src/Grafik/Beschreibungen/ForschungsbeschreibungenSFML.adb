pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleTexte;
with TextnummernKonstanten;
with ForschungKonstanten;

package body ForschungsbeschreibungenSFML is

   function BeschreibungKurz
     (IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      -- RasseExtern wird später benötigt wenn es verschiedene Forschungsbäume gibt.
      if
        RasseExtern = RassenDatentypen.Menschen_Enum
      then
         null;

      else
         null;
      end if;
      
      case
        IDExtern
      is
         when ForschungKonstanten.LeerForschungAnforderung =>
            BeschreibungText := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugKeines);
            
         when others =>
            BeschreibungText := GlobaleTexte.Forschungen (2 * Positive (IDExtern) - 1);
      end case;

      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungKurz;
   
   
   
   function BeschreibungLang
     (IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      -- RasseExtern wird später benötigt wenn es verschiedene Forschungsbäume gibt.
      if
        RasseExtern = RassenDatentypen.Menschen_Enum
      then
         null;

      else
         null;
      end if;
      
      case
        IDExtern
      is
         when ForschungKonstanten.LeerForschungAnforderung =>
            BeschreibungText := GlobaleTexte.Zeug (TextnummernKonstanten.ZeugKeines);
            
         when others =>
            BeschreibungText := GlobaleTexte.Forschungen (2 * Positive (IDExtern));
      end case;

      return To_Wide_Wide_String (Source => BeschreibungText);
      
   end BeschreibungLang;

end ForschungsbeschreibungenSFML;
