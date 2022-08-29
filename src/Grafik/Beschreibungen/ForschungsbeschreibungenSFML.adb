pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Rassentexte;
with ForschungKonstanten;
with GlobaleTexte;
with TextnummernKonstanten;

package body ForschungsbeschreibungenSFML is

   function BeschreibungKurz
     (IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      case
        IDExtern
      is
         when ForschungKonstanten.LeerForschungAnforderung =>
            return To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextnummernKonstanten.ZeugKeines));
            
         when others =>
            return To_Wide_Wide_String (Source => Rassentexte.Forschungen (RasseExtern, IDExtern, 1));
      end case;
      
   end BeschreibungKurz;
   
   
   
   function BeschreibungLang
     (IDExtern : in ForschungenDatentypen.ForschungID;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Rassentexte.Forschungen (RasseExtern, IDExtern, 2));
      
   end BeschreibungLang;

end ForschungsbeschreibungenSFML;
