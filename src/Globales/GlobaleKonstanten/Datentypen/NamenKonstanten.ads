with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with ArraysHTSEB;

package NamenKonstanten is
   pragma Elaborate_Body;

   Entwickler : constant Wide_Wide_String (1 .. 10) := "Honki Tonk";
   
   Helfer : constant ArraysHTSEB.AllgemeinesTextArray (1 .. 1) := (
                                                                   1 => To_Unbounded_Wide_Wide_String (Source => "mgrojo")
                                                                  );

end NamenKonstanten;
