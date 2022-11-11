with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package EinlesenLogik is
   pragma Elaborate_Body;

   procedure EinlesenOhneAnzeige;
   procedure EinlesenMitAnzeige;

private

   GewählteSprache : Unbounded_Wide_Wide_String;

end EinlesenLogik;
