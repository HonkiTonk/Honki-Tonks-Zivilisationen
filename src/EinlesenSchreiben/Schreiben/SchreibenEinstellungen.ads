pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

package SchreibenEinstellungen is

   procedure SchreibenEinstellungen;

   procedure SchreibenSprache;

private

   DateiEinstellungenSchreiben : File_Type;

end SchreibenEinstellungen;
