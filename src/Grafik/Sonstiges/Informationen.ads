pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package Informationen is

   Versionsnummer : constant Wide_Wide_String (1 .. 9) := "0.01.0165";

   procedure Informationen;

private

   procedure InformationenKonsole;
   procedure InformationenSFML;

end Informationen;
