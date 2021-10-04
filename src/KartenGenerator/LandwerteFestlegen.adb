pragma SPARK_Mode (On);

package body LandwerteFestlegen is

   -- Alle Größen- und Abstandsangaben sind Radien.
   procedure GrößeFestlegen
   is begin
      
      case
        Karten.Kartenart
      is
         when KartenDatentypen.Nur_Land | KartenDatentypen.Chaos =>
            null;
            
         when others =>
            Größe;
            Abstand;
      end case;
      
   end GrößeFestlegen;
   
   
   
   procedure Größe
   is begin
      
      if
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / TeilerGröße (Karten.Kartenart).YAchse > MaximaleLandgröße (Karten.Kartenart).YAchse
      then
         YAchse := MaximaleLandgröße (Karten.Kartenart).YAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / TeilerGröße (Karten.Kartenart).YAchse < MinimaleLandgröße (Karten.Kartenart).YAchse
      then
         YAchse := MinimaleLandgröße (Karten.Kartenart).YAchse;

      else
         YAchse := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / TeilerGröße (Karten.Kartenart).YAchse;
      end if;

      if
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / TeilerGröße (Karten.Kartenart).XAchse > MaximaleLandgröße (Karten.Kartenart).XAchse
      then
         XAchse := MaximaleLandgröße (Karten.Kartenart).XAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / TeilerGröße (Karten.Kartenart).XAchse < MinimaleLandgröße (Karten.Kartenart).XAchse
      then
         XAchse := MinimaleLandgröße (Karten.Kartenart).XAchse;

      else
         XAchse := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / TeilerGröße (Karten.Kartenart).XAchse;
      end if;

      Karten.GrößeLandart (Karten.Kartenart) := (YAchse, XAchse);
      
   end Größe;
   
   
   
   procedure Abstand
   is begin
      
      if
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / TeilerAbstand (Karten.Kartenart).YAchse > MaximalerAbstand (Karten.Kartenart).YAchse
      then
         YAchse := MaximalerAbstand (Karten.Kartenart).YAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / TeilerAbstand (Karten.Kartenart).YAchse < MinimalerAbstand (Karten.Kartenart).YAchse
      then
         YAchse := MinimalerAbstand (Karten.Kartenart).YAchse;

      else
         YAchse := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / TeilerAbstand (Karten.Kartenart).YAchse;
      end if;

      if
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / TeilerAbstand (Karten.Kartenart).XAchse > MaximalerAbstand (Karten.Kartenart).XAchse
      then
         XAchse := MaximalerAbstand (Karten.Kartenart).XAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / TeilerAbstand (Karten.Kartenart).XAchse < MinimalerAbstand (Karten.Kartenart).XAchse
      then
         XAchse := MinimalerAbstand (Karten.Kartenart).XAchse;

      else
         XAchse := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / TeilerAbstand (Karten.Kartenart).XAchse;
      end if;

      Karten.FelderVonLandartZuLandart (Karten.Kartenart) := (YAchse, XAchse);
      
   end Abstand;

end LandwerteFestlegen;
