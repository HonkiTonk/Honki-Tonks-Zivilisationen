pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body LandwerteFestlegen is

   -- Alle Größen- und Abstandsangaben sind Radien.
   procedure GrößeFestlegen
   is begin
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when SystemDatentypen.Karte_Art_Nur_Land_Enum | SystemDatentypen.Karte_Art_Chaos_Enum =>
            null;
            
         when others =>
            Größe;
            Abstand;
      end case;
      
   end GrößeFestlegen;
   
   
   
   procedure Größe
   is begin
      
      if
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße / TeilerGröße (Karten.Kartenparameter.Kartenart).YAchse > MaximaleLandgröße (Karten.Kartenparameter.Kartenart).YAchse
      then
         YAchse := MaximaleLandgröße (Karten.Kartenparameter.Kartenart).YAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße / TeilerGröße (Karten.Kartenparameter.Kartenart).YAchse < MinimaleLandgröße (Karten.Kartenparameter.Kartenart).YAchse
      then
         YAchse := MinimaleLandgröße (Karten.Kartenparameter.Kartenart).YAchse;

      else
         YAchse := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße / TeilerGröße (Karten.Kartenparameter.Kartenart).YAchse;
      end if;

      if
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße / TeilerGröße (Karten.Kartenparameter.Kartenart).XAchse > MaximaleLandgröße (Karten.Kartenparameter.Kartenart).XAchse
      then
         XAchse := MaximaleLandgröße (Karten.Kartenparameter.Kartenart).XAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße / TeilerGröße (Karten.Kartenparameter.Kartenart).XAchse < MinimaleLandgröße (Karten.Kartenparameter.Kartenart).XAchse
      then
         XAchse := MinimaleLandgröße (Karten.Kartenparameter.Kartenart).XAchse;

      else
         XAchse := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße / TeilerGröße (Karten.Kartenparameter.Kartenart).XAchse;
      end if;

      Karten.GrößeLandart (Karten.Kartenparameter.Kartenart) := (YAchse, XAchse);
      
   end Größe;
   
   
   
   procedure Abstand
   is begin
      
      if
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße / TeilerAbstand (Karten.Kartenparameter.Kartenart).YAchse > MaximalerAbstand (Karten.Kartenparameter.Kartenart).YAchse
      then
         YAchse := MaximalerAbstand (Karten.Kartenparameter.Kartenart).YAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße / TeilerAbstand (Karten.Kartenparameter.Kartenart).YAchse < MinimalerAbstand (Karten.Kartenparameter.Kartenart).YAchse
      then
         YAchse := MinimalerAbstand (Karten.Kartenparameter.Kartenart).YAchse;

      else
         YAchse := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchsenGröße / TeilerAbstand (Karten.Kartenparameter.Kartenart).YAchse;
      end if;

      if
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße / TeilerAbstand (Karten.Kartenparameter.Kartenart).XAchse > MaximalerAbstand (Karten.Kartenparameter.Kartenart).XAchse
      then
         XAchse := MaximalerAbstand (Karten.Kartenparameter.Kartenart).XAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße / TeilerAbstand (Karten.Kartenparameter.Kartenart).XAchse < MinimalerAbstand (Karten.Kartenparameter.Kartenart).XAchse
      then
         XAchse := MinimalerAbstand (Karten.Kartenparameter.Kartenart).XAchse;

      else
         XAchse := Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchsenGröße / TeilerAbstand (Karten.Kartenparameter.Kartenart).XAchse;
      end if;

      Karten.FelderVonLandartZuLandart (Karten.Kartenparameter.Kartenart) := (YAchse, XAchse);
      
   end Abstand;

end LandwerteFestlegen;
