pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KampfDatentypen is

   -- Negativer Bereich für Abzug.
   type KampfwerteAllgemein is range -100 .. 100;
   subtype Kampfwerte is KampfwerteAllgemein range 0 .. 100;

end KampfDatentypen;
