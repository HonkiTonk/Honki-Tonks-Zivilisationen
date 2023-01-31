with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Speziestexte;
with ForschungKonstanten;
with Meldungstexte;
with TextnummernKonstanten;

package body ForschungsbeschreibungenGrafik is

   function Kurzbeschreibung
     (IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      case
        IDExtern
      is
         when ForschungKonstanten.LeerAnforderung =>
            return To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugKeines));
            
         when others =>
            return To_Wide_Wide_String (Source => Speziestexte.Forschungen (SpeziesExtern, IDExtern, 1));
      end case;
      
   end Kurzbeschreibung;
   
   
   
   function Langbeschreibung
     (IDExtern : in ForschungenDatentypen.ForschungID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Speziestexte.Forschungen (SpeziesExtern, IDExtern, 2));
      
   end Langbeschreibung;

end ForschungsbeschreibungenGrafik;
