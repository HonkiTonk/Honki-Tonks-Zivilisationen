pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package ZahlenDatentypen is

   type NotAus is range 1 .. 100;
   subtype NotAusKlein is NotAus range 1 .. 5;

end ZahlenDatentypen;
