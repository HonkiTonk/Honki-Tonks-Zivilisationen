pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with ForschungenDatentypen;

package ForschungsbeschreibungenGrafik is

   function BeschreibungKurz
     (IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String;

   function BeschreibungLang
     (IDExtern : in ForschungenDatentypen.ForschungID;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String;
   
end ForschungsbeschreibungenGrafik;
