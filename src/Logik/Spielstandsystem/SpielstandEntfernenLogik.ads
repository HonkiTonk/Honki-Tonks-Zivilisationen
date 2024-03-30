with SpielstandDatentypen;

package SpielstandEntfernenLogik is
   pragma Elaborate_Body;

   procedure SpielstandEntfernen
     (SpielstandnameExtern : in Wide_Wide_String;
      ManuellAutoExtern : in SpielstandDatentypen.Spielstand_Enum);

end SpielstandEntfernenLogik;
