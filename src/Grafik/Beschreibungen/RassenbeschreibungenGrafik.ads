pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;

package RassenbeschreibungenGrafik is
   pragma Elaborate_Body;

   function Kurzbeschreibung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String;
   
   function Langbeschreibung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String;

end RassenbeschreibungenGrafik;
