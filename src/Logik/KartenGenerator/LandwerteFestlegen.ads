pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with SystemDatentypen;

with Karten;

package LandwerteFestlegen is
   
   procedure GrößeFestlegen;
      
private
   
   -- Alle Größen- und Abstandsangaben sind Radien.

   YAchse : KartenDatentypen.KartenfeldPositiv;
   XAchse : KartenDatentypen.KartenfeldPositiv;
   
   MinimaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 SystemDatentypen.Karte_Art_Inseln     => (2, 2),
                                                                 SystemDatentypen.Karte_Art_Kontinente => (6, 6),
                                                                 SystemDatentypen.Karte_Art_Pangäa     => (1, 1),
                                                                 others                      => (1, 1)
                                                                );
   MaximaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 SystemDatentypen.Karte_Art_Inseln     => (3, 3),
                                                                 SystemDatentypen.Karte_Art_Kontinente => (8, 8),
                                                                 SystemDatentypen.Karte_Art_Pangäa     => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                                                 others                      => (1, 1)
                                                                );
   
   MinimalerAbstand : constant Karten.GrößeLandartArray := (
                                                              SystemDatentypen.Karte_Art_Inseln     => (8, 8),
                                                              SystemDatentypen.Karte_Art_Kontinente => (13, 13),
                                                              SystemDatentypen.Karte_Art_Pangäa     => (1, 1),
                                                              others                      => (1, 1)
                                                             );
   MaximalerAbstand : constant Karten.GrößeLandartArray := (
                                                              SystemDatentypen.Karte_Art_Inseln     => (15, 15),
                                                              SystemDatentypen.Karte_Art_Kontinente => (22, 22),
                                                              SystemDatentypen.Karte_Art_Pangäa     => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                                              others                      => (1, 1)
                                                             );
   
   TeilerGröße : constant Karten.GrößeLandartArray := (
                                                           SystemDatentypen.Karte_Art_Inseln     => (7, 7),
                                                           SystemDatentypen.Karte_Art_Kontinente => (3, 3),
                                                           SystemDatentypen.Karte_Art_Pangäa     => (2, 2),
                                                           others                      => (1, 1)
                                                          );
   TeilerAbstand : constant Karten.GrößeLandartArray := (
                                                           SystemDatentypen.Karte_Art_Inseln     => (3, 3),
                                                           SystemDatentypen.Karte_Art_Kontinente => (2, 2),
                                                           SystemDatentypen.Karte_Art_Pangäa     => (1, 1),
                                                           others                      => (1, 1)
                                                          );
   
   procedure Größe;
   procedure Abstand;

end LandwerteFestlegen;
