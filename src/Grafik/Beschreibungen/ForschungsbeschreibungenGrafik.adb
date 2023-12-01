with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Speziestexte;
with ForschungKonstanten;
with Spieltexte;
with TextnummernKonstanten;

package body ForschungsbeschreibungenGrafik is

   function Kurzbeschreibung
     (IDExtern : in ForschungenDatentypen.ForschungID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      case
        IDExtern
      is
         when ForschungKonstanten.LeerAnforderung =>
            return To_Wide_Wide_String (Source => Spieltexte.Zeug (TextnummernKonstanten.ZeugKeines));
            
         when others =>
            return To_Wide_Wide_String (Source => Speziestexte.Forschungen (SpeziesExtern, IDExtern, TextnummernKonstanten.KurzeBeschreibung));
      end case;
      
   end Kurzbeschreibung;
   
   
   
   function Langbeschreibung
     (IDExtern : in ForschungenDatentypen.ForschungIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Wide_Wide_String
   is begin
      
      return To_Wide_Wide_String (Source => Speziestexte.Forschungen (SpeziesExtern, IDExtern, TextnummernKonstanten.LangeBeschreibung));
      
   end Langbeschreibung;

end ForschungsbeschreibungenGrafik;
