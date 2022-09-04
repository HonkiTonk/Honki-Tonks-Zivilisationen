pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with StadtDatentypen;
with RassenDatentypen;

package GebaeudebeschreibungenGrafik is

   function BeschreibungKurz
     (IDExtern : in StadtDatentypen.GebäudeID;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String;
   
   function BeschreibungLang
     (IDExtern : in StadtDatentypen.GebäudeID;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Wide_Wide_String;

end GebaeudebeschreibungenGrafik;
