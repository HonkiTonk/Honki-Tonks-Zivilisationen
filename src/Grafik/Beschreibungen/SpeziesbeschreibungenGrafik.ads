with SpeziesDatentypen;

package SpeziesbeschreibungenGrafik is
   pragma Elaborate_Body;

   function Kurzbeschreibung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String;
   
   function Langbeschreibung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String;

end SpeziesbeschreibungenGrafik;
