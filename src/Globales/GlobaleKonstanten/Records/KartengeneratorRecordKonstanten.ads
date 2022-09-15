pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen;
with KartenRecords;

package KartengeneratorRecordKonstanten is

   -- Das hier sollte woanders hin, oder? Oder aus dem Array ein Record machen. äöü
   -- Polgrund auch definierbar machen, so dass die Pole nicht nur aus Eis bestehen? äöü
   Eisrand : constant KartenDatentypen.PolregionenArray := (
                                                            KartenDatentypen.Norden_Enum => 1,
                                                            KartenDatentypen.Süden_Enum  => 1,
                                                            KartenDatentypen.Westen_Enum => 0,
                                                            KartenDatentypen.Osten_Enum  => 0
                                                           );
   
   Inselgröße : constant KartenRecords.LandgrößenRecord := (
                                                                MinimaleYAchse => 3,
                                                                MaximaleYAchse => 4,
                                                                MinimaleXAchse => 3,
                                                                MaximaleXAchse => 4
                                                               );
   
   Kontinentgröße : constant KartenRecords.LandgrößenRecord := (
                                                                    MinimaleYAchse => 5,
                                                                    MaximaleYAchse => 8,
                                                                    MinimaleXAchse => 5,
                                                                    MaximaleXAchse => 8
                                                                   );
   
   Pangäagröße : constant KartenRecords.LandgrößenRecord := (
                                                                  MinimaleYAchse => 100,
                                                                  MaximaleYAchse => 100,
                                                                  MinimaleXAchse => 100,
                                                                  MaximaleXAchse => 100
                                                                 );

end KartengeneratorRecordKonstanten;
