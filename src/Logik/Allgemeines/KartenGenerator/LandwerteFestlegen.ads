pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with RueckgabeDatentypen;

with Karten;

package LandwerteFestlegen is
   
   procedure GrößeFestlegen;
      
private
   
   -- Alle Größen- und Abstandsangaben sind Radien.

   YAchse : KartenDatentypen.KartenfeldPositiv;
   XAchse : KartenDatentypen.KartenfeldPositiv;
   
   MinimaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 RueckgabeDatentypen.Karte_Art_Inseln_Enum     => (2, 2),
                                                                 RueckgabeDatentypen.Karte_Art_Kontinente_Enum => (6, 6),
                                                                 RueckgabeDatentypen.Karte_Art_Pangäa_Enum     => (1, 1),
                                                                 others                                     => (1, 1)
                                                                );
   MaximaleLandgröße : constant Karten.GrößeLandartArray := (
                                                                 RueckgabeDatentypen.Karte_Art_Inseln_Enum     => (3, 3),
                                                                 RueckgabeDatentypen.Karte_Art_Kontinente_Enum => (8, 8),
                                                                 RueckgabeDatentypen.Karte_Art_Pangäa_Enum     => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                                                 others                                     => (1, 1)
                                                                );
   
   MinimalerAbstand : constant Karten.GrößeLandartArray := (
                                                              RueckgabeDatentypen.Karte_Art_Inseln_Enum     => (8, 8),
                                                              RueckgabeDatentypen.Karte_Art_Kontinente_Enum => (13, 13),
                                                              RueckgabeDatentypen.Karte_Art_Pangäa_Enum     => (1, 1),
                                                              others                                     => (1, 1)
                                                             );
   MaximalerAbstand : constant Karten.GrößeLandartArray := (
                                                              RueckgabeDatentypen.Karte_Art_Inseln_Enum     => (15, 15),
                                                              RueckgabeDatentypen.Karte_Art_Kontinente_Enum => (22, 22),
                                                              RueckgabeDatentypen.Karte_Art_Pangäa_Enum     => (KartenDatentypen.KartenfeldPositiv'Last, KartenDatentypen.KartenfeldPositiv'Last),
                                                              others                                     => (1, 1)
                                                             );
   
   TeilerGröße : constant Karten.GrößeLandartArray := (
                                                           RueckgabeDatentypen.Karte_Art_Inseln_Enum     => (7, 7),
                                                           RueckgabeDatentypen.Karte_Art_Kontinente_Enum => (3, 3),
                                                           RueckgabeDatentypen.Karte_Art_Pangäa_Enum     => (2, 2),
                                                           others                                     => (1, 1)
                                                          );
   TeilerAbstand : constant Karten.GrößeLandartArray := (
                                                           RueckgabeDatentypen.Karte_Art_Inseln_Enum     => (3, 3),
                                                           RueckgabeDatentypen.Karte_Art_Kontinente_Enum => (2, 2),
                                                           RueckgabeDatentypen.Karte_Art_Pangäa_Enum     => (1, 1),
                                                           others                                     => (1, 1)
                                                          );
   
   procedure Größe;
   procedure Abstand;

end LandwerteFestlegen;
