pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body LandwerteFestlegen is

   -- Beim Erweitern von KartenDatentypen.Kartenart_Sonstiges_Enum'Range müssen eventuell einzelne Bereiche hier angepasst werden. Beachte auch Kartengenerator.
   procedure GrößeFestlegen
   is begin
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Sonstiges_Enum'Range | KartenDatentypen.Kartenart_Chaotisch_Enum'Range =>
            null;
            
         when others =>
            Größe;
            Abstand;
      end case;
      
   end GrößeFestlegen;
   
   
   
   -- Alle Größen- und Abstandsangaben sind Radien.
   procedure Größe
   is begin
      
      if
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / TeilerGröße (Karten.Kartenparameter.Kartenart).YAchse > MaximaleLandgröße (Karten.Kartenparameter.Kartenart).YAchse
      then
         YAchse := MaximaleLandgröße (Karten.Kartenparameter.Kartenart).YAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / TeilerGröße (Karten.Kartenparameter.Kartenart).YAchse < MinimaleLandgröße (Karten.Kartenparameter.Kartenart).YAchse
      then
         YAchse := MinimaleLandgröße (Karten.Kartenparameter.Kartenart).YAchse;

      else
         YAchse := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / TeilerGröße (Karten.Kartenparameter.Kartenart).YAchse;
      end if;

      if
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / TeilerGröße (Karten.Kartenparameter.Kartenart).XAchse > MaximaleLandgröße (Karten.Kartenparameter.Kartenart).XAchse
      then
         XAchse := MaximaleLandgröße (Karten.Kartenparameter.Kartenart).XAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / TeilerGröße (Karten.Kartenparameter.Kartenart).XAchse < MinimaleLandgröße (Karten.Kartenparameter.Kartenart).XAchse
      then
         XAchse := MinimaleLandgröße (Karten.Kartenparameter.Kartenart).XAchse;

      else
         XAchse := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / TeilerGröße (Karten.Kartenparameter.Kartenart).XAchse;
      end if;

      Karten.GrößeLandfläche (Karten.Kartenparameter.Kartenart) := (YAchse, XAchse);
      
   end Größe;
   
   
   
   procedure Abstand
   is begin
      
      if
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / TeilerAbstand (Karten.Kartenparameter.Kartenart).YAchse > MaximalerAbstand (Karten.Kartenparameter.Kartenart).YAchse
      then
         YAchse := MaximalerAbstand (Karten.Kartenparameter.Kartenart).YAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / TeilerAbstand (Karten.Kartenparameter.Kartenart).YAchse < MinimalerAbstand (Karten.Kartenparameter.Kartenart).YAchse
      then
         YAchse := MinimalerAbstand (Karten.Kartenparameter.Kartenart).YAchse;

      else
         YAchse := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse / TeilerAbstand (Karten.Kartenparameter.Kartenart).YAchse;
      end if;

      if
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / TeilerAbstand (Karten.Kartenparameter.Kartenart).XAchse > MaximalerAbstand (Karten.Kartenparameter.Kartenart).XAchse
      then
         XAchse := MaximalerAbstand (Karten.Kartenparameter.Kartenart).XAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / TeilerAbstand (Karten.Kartenparameter.Kartenart).XAchse < MinimalerAbstand (Karten.Kartenparameter.Kartenart).XAchse
      then
         XAchse := MinimalerAbstand (Karten.Kartenparameter.Kartenart).XAchse;

      else
         XAchse := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse / TeilerAbstand (Karten.Kartenparameter.Kartenart).XAchse;
      end if;

      Karten.AbstandLandflächen (Karten.Kartenparameter.Kartenart) := (YAchse, XAchse);
      
   end Abstand;

end LandwerteFestlegen;
