with SpeziesDatentypen;
with ForschungenDatentypen;

package ForschungsbeschreibungenGrafik is
   pragma Elaborate_Body;

   function Kurzbeschreibung
     (IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String;

   function Langbeschreibung
     (IDExtern : in ForschungenDatentypen.ForschungID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String;
   
end ForschungsbeschreibungenGrafik;
