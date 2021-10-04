pragma SPARK_Mode (On);

with GlobaleDatentypen, KartenDatentypen;
use GlobaleDatentypen;

with Karten;

package LandwerteFestlegen is
   
   procedure GrößeFestlegen;
      
private
   
   -- Alle Größen- und Abstandsangaben sind Radien.

   YAchse : KartenDatentypen.KartenfeldPositiv;
   XAchse : KartenDatentypen.KartenfeldPositiv;
   
   MinimaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 KartenDatentypen.Inseln     => (2, 2),
                                                                 KartenDatentypen.Kontinente => (6, 6),
                                                                 KartenDatentypen.Pangäa     => (1, 1),
                                                                 others                       => (1, 1)
                                                                );
   MaximaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 KartenDatentypen.Inseln     => (3, 3),
                                                                 KartenDatentypen.Kontinente => (8, 8),
                                                                 KartenDatentypen.Pangäa     => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                                                 others                       => (1, 1)
                                                                );
   
   MinimalerAbstand : constant Karten.GrößeLandartArray := (
                                                              KartenDatentypen.Inseln     => (8, 8),
                                                              KartenDatentypen.Kontinente => (13, 13),
                                                              KartenDatentypen.Pangäa     => (1, 1),
                                                              others                       => (1, 1)
                                                             );
   MaximalerAbstand : constant Karten.GrößeLandartArray := (
                                                              KartenDatentypen.Inseln     => (15, 15),
                                                              KartenDatentypen.Kontinente => (22, 22),
                                                              KartenDatentypen.Pangäa     => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                                              others                       => (1, 1)
                                                             );
   
   TeilerGröße : constant Karten.GrößeLandartArray := (
                                                           KartenDatentypen.Inseln     => (7, 7),
                                                           KartenDatentypen.Kontinente => (3, 3),
                                                           KartenDatentypen.Pangäa     => (2, 2),
                                                           others                       => (1, 1)
                                                          );
   TeilerAbstand : constant Karten.GrößeLandartArray := (
                                                           KartenDatentypen.Inseln     => (3, 3),
                                                           KartenDatentypen.Kontinente => (2, 2),
                                                           KartenDatentypen.Pangäa     => (1, 1),
                                                           others                       => (1, 1)
                                                          );
   
   procedure Größe;
   procedure Abstand;

end LandwerteFestlegen;
