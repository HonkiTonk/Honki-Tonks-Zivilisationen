with StadtDatentypen;
with SpeziesDatentypen;

package GebaeudebeschreibungenGrafik is
   pragma Elaborate_Body;

   function Kurzbeschreibung
     (IDExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String;
   
   function Langbeschreibung
     (IDExtern : in StadtDatentypen.GebäudeID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Wide_Wide_String;

end GebaeudebeschreibungenGrafik;
