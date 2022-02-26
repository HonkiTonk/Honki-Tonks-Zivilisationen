pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenEinstellungenKonstanten;

with Karten;

package LandwerteFestlegen is
   
   procedure GrößeFestlegen;
      
private
   
   -- Alle Größen- und Abstandsangaben sind Radien.

   YAchse : KartenDatentypen.KartenfeldPositiv;
   XAchse : KartenDatentypen.KartenfeldPositiv;
   
   MinimaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 KartenEinstellungenKonstanten.KartenartInselnKonstante     => (2, 2),
                                                                 KartenEinstellungenKonstanten.KartenartKontinenteKonstante => (6, 6),
                                                                 KartenEinstellungenKonstanten.KartenartPangäaKonstante     => (1, 1),
                                                                 others                      => (1, 1)
                                                                );
   MaximaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 KartenEinstellungenKonstanten.KartenartInselnKonstante     => (3, 3),
                                                                 KartenEinstellungenKonstanten.KartenartKontinenteKonstante => (8, 8),
                                                                 KartenEinstellungenKonstanten.KartenartPangäaKonstante     => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                                                 others                      => (1, 1)
                                                                );
   
   MinimalerAbstand : constant Karten.GrößeLandartArray := (
                                                              KartenEinstellungenKonstanten.KartenartInselnKonstante     => (8, 8),
                                                              KartenEinstellungenKonstanten.KartenartKontinenteKonstante => (13, 13),
                                                              KartenEinstellungenKonstanten.KartenartPangäaKonstante     => (1, 1),
                                                              others                      => (1, 1)
                                                             );
   MaximalerAbstand : constant Karten.GrößeLandartArray := (
                                                              KartenEinstellungenKonstanten.KartenartInselnKonstante     => (15, 15),
                                                              KartenEinstellungenKonstanten.KartenartKontinenteKonstante => (22, 22),
                                                              KartenEinstellungenKonstanten.KartenartPangäaKonstante     => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                                              others                      => (1, 1)
                                                             );
   
   TeilerGröße : constant Karten.GrößeLandartArray := (
                                                           KartenEinstellungenKonstanten.KartenartInselnKonstante     => (7, 7),
                                                           KartenEinstellungenKonstanten.KartenartKontinenteKonstante => (3, 3),
                                                           KartenEinstellungenKonstanten.KartenartPangäaKonstante     => (2, 2),
                                                           others                      => (1, 1)
                                                          );
   TeilerAbstand : constant Karten.GrößeLandartArray := (
                                                           KartenEinstellungenKonstanten.KartenartInselnKonstante     => (3, 3),
                                                           KartenEinstellungenKonstanten.KartenartKontinenteKonstante => (2, 2),
                                                           KartenEinstellungenKonstanten.KartenartPangäaKonstante     => (1, 1),
                                                           others                      => (1, 1)
                                                          );
   
   procedure Größe;
   procedure Abstand;

end LandwerteFestlegen;
