pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package Einlesen is

   procedure EinlesenOhneAnzeige;
   procedure EinlesenMitAnzeige;

private

   GewählteSprache : Unbounded_Wide_Wide_String;

end Einlesen;
