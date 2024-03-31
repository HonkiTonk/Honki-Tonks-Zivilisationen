with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;

package SpielstandEntfernenLogik is
   pragma Elaborate_Body;

   procedure SpielstandEntfernen
     (SpielstandnameExtern : in Unbounded_Wide_Wide_String;
      ManuellAutoExtern : in SystemDatentypen.Spielstand_Enum)
     with
       Pre => (
                 To_Wide_Wide_String (Source => SpielstandnameExtern)'Length > 0
              );

end SpielstandEntfernenLogik;
