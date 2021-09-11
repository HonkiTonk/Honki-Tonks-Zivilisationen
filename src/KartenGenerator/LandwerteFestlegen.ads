pragma SPARK_Mode (On);

with GlobaleDatentypen;
use GlobaleDatentypen;

with Karten;

package LandwerteFestlegen is
   
   procedure GrößeFestlegen;
      
private
   
   -- Alle Größen- und Abstandsangaben sind Radien.

   GrößePangäa : GlobaleDatentypen.KartenfeldPositiv;
   YAchse : GlobaleDatentypen.KartenfeldPositiv;
   XAchse : GlobaleDatentypen.KartenfeldPositiv;
   
   MinimaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 GlobaleDatentypen.Inseln     => (2, 2),
                                                                 GlobaleDatentypen.Kontinente => (6, 6),
                                                                 GlobaleDatentypen.Pangäa     => (1, 1),
                                                                 GlobaleDatentypen.Nur_Land   => (1, 1),
                                                                 GlobaleDatentypen.Chaos      => (1, 1)
                                                                );
   MaximaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 GlobaleDatentypen.Inseln     => (3, 3),
                                                                 GlobaleDatentypen.Kontinente => (8, 8),
                                                                 GlobaleDatentypen.Pangäa     => (GlobaleDatentypen.KartenfeldPositiv'Last, GlobaleDatentypen.KartenfeldPositiv'Last),
                                                                 GlobaleDatentypen.Nur_Land   => (1, 1),
                                                                 GlobaleDatentypen.Chaos      => (1, 1)
                                                                );
   
   MinimalerAbstand : constant Karten.GrößeLandartArray := (
                                                              GlobaleDatentypen.Inseln     => (8, 8),
                                                              GlobaleDatentypen.Kontinente => (13, 13),
                                                              GlobaleDatentypen.Pangäa     => (1, 1),
                                                              GlobaleDatentypen.Nur_Land   => (1, 1),
                                                              GlobaleDatentypen.Chaos      => (1, 1)
                                                             );
   MaximalerAbstand : constant Karten.GrößeLandartArray := (
                                                              GlobaleDatentypen.Inseln     => (15, 15),
                                                              GlobaleDatentypen.Kontinente => (22, 22),
                                                              GlobaleDatentypen.Pangäa     => (GlobaleDatentypen.KartenfeldPositiv'Last, GlobaleDatentypen.KartenfeldPositiv'Last),
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
