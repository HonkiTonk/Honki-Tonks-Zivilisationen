pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KampfDatentypen;

package KampfKonstanten is
   
   type SchadenAngerichtetArray is array (KampfDatentypen.Kampf_Unterschiede_Enum'Range, KampfDatentypen.Schadensbereiche'Range) of Float;
   SchadenAngerichtet : constant SchadenAngerichtetArray := (
                                                             KampfDatentypen.Gleich_Enum =>
                                                               (
                                                                1 => 0.40,
                                                                2 => 0.75,
                                                                3 => 0.90
                                                               ),

                                                             KampfDatentypen.Stärker_Enum =>
                                                               (
                                                                1 => 0.30,
                                                                2 => 0.65,
                                                                3 => 0.80
                                                               ),

                                                             KampfDatentypen.Extrem_Stärker_Enum =>
                                                               (
                                                                1 => 0.20,
                                                                2 => 0.50,
                                                                3 => 0.70
                                                               ),

                                                             KampfDatentypen.Schwächer_Enum =>
                                                               (
                                                                1 => 0.55,
                                                                2 => 0.85,
                                                                3 => 0.95
                                                               ),

                                                             KampfDatentypen.Extrem_Schwächer_Enum =>
                                                               (
                                                                1 => 0.70,
                                                                2 => 0.90,
                                                                3 => 0.98
                                                               )
                                                            );

end KampfKonstanten;
