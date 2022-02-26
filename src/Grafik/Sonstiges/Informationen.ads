pragma SPARK_Mode (On);

package Informationen is

   Versionsnummer : constant Wide_Wide_String (1 .. 9) := "0.01.0050";

   procedure Informationen;

private

   procedure InformationenKonsole;
   procedure InformationenSFML;

end Informationen;
