with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with StadtWerteFestlegen, GlobaleVariablen, GebaeudeDatenbank, EinheitenDatenbank, GlobaleDatentypen;
use GlobaleDatentypen;

package Wachstum is
   
   procedure Wachstum;
   procedure WachstumBeiStadtGründung (Rasse : in Integer);

private
   
   procedure WachstumEinwohner (Rasse, StadtNummer : in Integer);
   procedure WachstumProduktion (Rasse, StadtNummer : in Integer);

end Wachstum;
