pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with Karten;

package LandwerteFestlegen is
   
   procedure GrößeFestlegen;
      
private
   
   -- Alle Größen- und Abstandsangaben sind Radien.

   YAchse : KartenDatentypen.KartenfeldPositiv;
   XAchse : KartenDatentypen.KartenfeldPositiv;
   
   MinimaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 KartenKonstanten.KartenartInselnKonstante     => (2, 2),
                                                                 KartenKonstanten.KartenartKontinenteKonstante => (6, 6),
                                                                 KartenKonstanten.KartenartPangäaKonstante     => (1, 1),
                                                                 others                      => (1, 1)
                                                                );
   MaximaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 KartenKonstanten.KartenartInselnKonstante     => (3, 3),
                                                                 KartenKonstanten.KartenartKontinenteKonstante => (8, 8),
                                                                 KartenKonstanten.KartenartPangäaKonstante     => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                                                 others                      => (1, 1)
                                                                );
   
   MinimalerAbstand : constant Karten.GrößeLandartArray := (
                                                              KartenKonstanten.KartenartInselnKonstante     => (8, 8),
                                                              KartenKonstanten.KartenartKontinenteKonstante => (13, 13),
                                                              KartenKonstanten.KartenartPangäaKonstante     => (1, 1),
                                                              others                      => (1, 1)
                                                             );
   MaximalerAbstand : constant Karten.GrößeLandartArray := (
                                                              KartenKonstanten.KartenartInselnKonstante     => (15, 15),
                                                              KartenKonstanten.KartenartKontinenteKonstante => (22, 22),
                                                              KartenKonstanten.KartenartPangäaKonstante     => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                                              others                      => (1, 1)
                                                             );
   
   TeilerGröße : constant Karten.GrößeLandartArray := (
                                                           KartenKonstanten.KartenartInselnKonstante     => (7, 7),
                                                           KartenKonstanten.KartenartKontinenteKonstante => (3, 3),
                                                           KartenKonstanten.KartenartPangäaKonstante     => (2, 2),
                                                           others                      => (1, 1)
                                                          );
   TeilerAbstand : constant Karten.GrößeLandartArray := (
                                                           KartenKonstanten.KartenartInselnKonstante     => (3, 3),
                                                           KartenKonstanten.KartenartKontinenteKonstante => (2, 2),
                                                           KartenKonstanten.KartenartPangäaKonstante     => (1, 1),
                                                           others                      => (1, 1)
                                                          );
   
   procedure Größe;
   procedure Abstand;

end LandwerteFestlegen;
