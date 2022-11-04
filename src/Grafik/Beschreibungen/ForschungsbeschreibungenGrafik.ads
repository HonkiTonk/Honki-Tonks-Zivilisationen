pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
with ForschungenDatentypen;

package ForschungsbeschreibungenGrafik is
   pragma Elaborate_Body;

   function Kurzbeschreibung
     (IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String;

   function Langbeschreibung
     (IDExtern : in ForschungenDatentypen.ForschungID;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String;
   
end ForschungsbeschreibungenGrafik;
