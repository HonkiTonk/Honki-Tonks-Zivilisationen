pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KampfDatentypen is

   -- Negativer Bereich für Abzug.
   -- Das mal überall so gestalten? äöü
   type KampfwerteAllgemein is range -100 .. 100;
   subtype Kampfwerte is KampfwerteAllgemein range 0 .. 100;
   subtype Schadensbereiche is Kampfwerte range 1 .. 3;

   -- Die Werte gelten immer aus Sicht des Angreifers
   type Kampf_Unterschiede_Enum is (
                                    Gleich_Enum, Stärker_Enum, Extrem_Stärker_Enum, Schwächer_Enum, Extrem_Schwächer_Enum
                                   );

end KampfDatentypen;
