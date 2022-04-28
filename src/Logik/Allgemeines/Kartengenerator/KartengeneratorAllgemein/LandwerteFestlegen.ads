pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with Karten;

package LandwerteFestlegen is
   
   procedure GrößeFestlegen;
      
private
   
   -- Alle Größen- und Abstandsangaben sind Radien.

   YAchse : KartenDatentypen.KartenfeldPositiv;
   XAchse : KartenDatentypen.KartenfeldPositiv;
   
   MinimaleLandgröße : constant Karten.LandflächenArray := (
                                                               KartenDatentypen.Kartenart_Inseln_Enum     => (2, 2),
                                                               KartenDatentypen.Kartenart_Kontinente_Enum => (6, 6),
                                                               KartenDatentypen.Kartenart_Pangäa_Enum     => (1, 1),
                                                               others                                     => (1, 1)
                                                              );
   MaximaleLandgröße : constant Karten.LandflächenArray := (
                                                               KartenDatentypen.Kartenart_Inseln_Enum     => (3, 3),
                                                               KartenDatentypen.Kartenart_Kontinente_Enum => (8, 8),
                                                               KartenDatentypen.Kartenart_Pangäa_Enum     => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                                               others                                     => (1, 1)
                                                              );
   
   MinimalerAbstand : constant Karten.LandflächenArray := (
                                                            KartenDatentypen.Kartenart_Inseln_Enum     => (8, 8),
                                                            KartenDatentypen.Kartenart_Kontinente_Enum => (13, 13),
                                                            KartenDatentypen.Kartenart_Pangäa_Enum     => (1, 1),
                                                            others                                     => (1, 1)
                                                           );
   MaximalerAbstand : constant Karten.LandflächenArray := (
                                                            KartenDatentypen.Kartenart_Inseln_Enum     => (15, 15),
                                                            KartenDatentypen.Kartenart_Kontinente_Enum => (22, 22),
                                                            KartenDatentypen.Kartenart_Pangäa_Enum     => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                                            others                                     => (1, 1)
                                                           );
   
   TeilerGröße : constant Karten.LandflächenArray := (
                                                         KartenDatentypen.Kartenart_Inseln_Enum     => (7, 7),
                                                         KartenDatentypen.Kartenart_Kontinente_Enum => (3, 3),
                                                         KartenDatentypen.Kartenart_Pangäa_Enum     => (2, 2),
                                                         others                                     => (1, 1)
                                                        );
   TeilerAbstand : constant Karten.LandflächenArray := (
                                                         KartenDatentypen.Kartenart_Inseln_Enum     => (3, 3),
                                                         KartenDatentypen.Kartenart_Kontinente_Enum => (2, 2),
                                                         KartenDatentypen.Kartenart_Pangäa_Enum     => (1, 1),
                                                         others                                     => (1, 1)
                                                        );
   
   procedure Größe;
   procedure Abstand;

end LandwerteFestlegen;