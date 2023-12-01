with StadtDatentypen;
with SpeziesDatentypen;

package GebaeudebeschreibungenGrafik is
   pragma Elaborate_Body;

   function Kurzbeschreibung
     (IDExtern : in StadtDatentypen.GebäudeIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Wide_Wide_String;
   
   function Langbeschreibung
     (IDExtern : in StadtDatentypen.GebäudeIDVorhanden;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Wide_Wide_String;

end GebaeudebeschreibungenGrafik;
