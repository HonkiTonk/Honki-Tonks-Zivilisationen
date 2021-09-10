pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;

package LandwerteFestlegen is
   
   procedure GrößeFestlegen;
      
private

   GrößePangäa : GlobaleDatentypen.KartenfeldPositiv;
   YAchse : GlobaleDatentypen.KartenfeldPositiv;
   XAchse : GlobaleDatentypen.KartenfeldPositiv;
   
   MinimaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 GlobaleDatentypen.Inseln     => (1, 1),
                                                                 GlobaleDatentypen.Kontinente => (1, 1),
                                                                 GlobaleDatentypen.Pangäa     => (1, 1),
                                                                 GlobaleDatentypen.Nur_Land   => (1, 1),
                                                                 GlobaleDatentypen.Chaos      => (1, 1)
                                                                );
   MinimalerAbstand : constant Karten.GrößeLandartArray := (
                                                              GlobaleDatentypen.Inseln     => (1, 1),
                                                              GlobaleDatentypen.Kontinente => (1, 1),
                                                              GlobaleDatentypen.Pangäa     => (1, 1),
                                                              GlobaleDatentypen.Nur_Land   => (1, 1),
                                                              GlobaleDatentypen.Chaos      => (1, 1)
                                                             );
   MaximaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 GlobaleDatentypen.Inseln     => (19, 19),
                                                                 GlobaleDatentypen.Kontinente => (45, 45),
                                                                 GlobaleDatentypen.Pangäa     => (1, 1),
                                                                 GlobaleDatentypen.Nur_Land   => (1, 1),
                                                                 GlobaleDatentypen.Chaos      => (1, 1)
                                                                );
   MaximalerAbstand : constant Karten.GrößeLandartArray := (
                                                              GlobaleDatentypen.Inseln     => (19, 19),
                                                              GlobaleDatentypen.Kontinente => (45, 45),
                                                              GlobaleDatentypen.Pangäa     => (1, 1),
                                                              GlobaleDatentypen.Nur_Land   => (1, 1),
                                                              GlobaleDatentypen.Chaos      => (1, 1)
                                                             );
   
   procedure AbstandFestlegen;
   procedure InselGröße;
   procedure KontinentGröße;
   procedure PangäaGröße;
   procedure InselAbstand;
   procedure KontinentAbstand;
   procedure PangäaAbstand;

end LandwerteFestlegen;
