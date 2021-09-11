pragma SPARK_Mode (On);

package body LandwerteFestlegen is

   -- Alle Größen- und Abstandsangaben sind Radien.
   procedure GrößeFestlegen
   is begin
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Inseln =>
            InselGröße;
            
         when GlobaleDatentypen.Kontinente =>
            KontinentGröße;
            
         when GlobaleDatentypen.Pangäa =>
            PangäaGröße;
            
         when others =>
            return;
      end case;
      
      AbstandFestlegen;
      
   end GrößeFestlegen;
   
   
   
   procedure InselGröße
   is begin
      
      if
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 7 > MaximaleLandgröße (Karten.Kartenart).YAchse
      then
         YAchse := MaximaleLandgröße (Karten.Kartenart).YAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 7 < MinimaleLandgröße (Karten.Kartenart).YAchse
      then
         YAchse := MinimaleLandgröße (Karten.Kartenart).YAchse;

      else
         YAchse := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 7;
      end if;

      if
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 7 > MaximaleLandgröße (Karten.Kartenart).XAchse
      then
         XAchse := MaximaleLandgröße (Karten.Kartenart).XAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 7 < MinimaleLandgröße (Karten.Kartenart).XAchse
      then
         XAchse := MinimaleLandgröße (Karten.Kartenart).XAchse;

      else
         XAchse := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 7;
      end if;

      Karten.GrößeLandart (Karten.Kartenart) := (YAchse, XAchse);
      
   end InselGröße;
   
   
   
   procedure KontinentGröße
   is begin
      
      if
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 3 > MaximaleLandgröße (Karten.Kartenart).YAchse
      then
         YAchse := MaximaleLandgröße (Karten.Kartenart).YAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 3 < MinimaleLandgröße (Karten.Kartenart).YAchse
      then
         YAchse := MinimaleLandgröße (Karten.Kartenart).YAchse;

      else
         YAchse := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 3;
      end if;

      if
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 3 > MaximaleLandgröße (Karten.Kartenart).XAchse
      then
         XAchse := MaximaleLandgröße (Karten.Kartenart).XAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 3 < MinimaleLandgröße (Karten.Kartenart).XAchse
      then
         XAchse := MinimaleLandgröße (Karten.Kartenart).XAchse;

      else
         XAchse := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 3;
      end if;

      Karten.GrößeLandart (Karten.Kartenart) := (YAchse, XAchse);
      
   end KontinentGröße;
   
   
   
   procedure PangäaGröße
   is begin
      
      if
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2 > MaximaleLandgröße (Karten.Kartenart).YAchse
      then
         YAchse := MaximaleLandgröße (Karten.Kartenart).YAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2 < MinimaleLandgröße (Karten.Kartenart).YAchse
      then
         YAchse := MinimaleLandgröße (Karten.Kartenart).YAchse;

      else
         YAchse := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 7;
      end if;

      if
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 > MaximaleLandgröße (Karten.Kartenart).XAchse
      then
         XAchse := MaximaleLandgröße (Karten.Kartenart).XAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 < MinimaleLandgröße (Karten.Kartenart).XAchse
      then
         XAchse := MinimaleLandgröße (Karten.Kartenart).XAchse;

      else
         XAchse := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2;
      end if;

      Karten.GrößeLandart (Karten.Kartenart) := (YAchse, XAchse);
      
   end PangäaGröße;
   
   
   
   procedure AbstandFestlegen
   is begin
      
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Inseln =>
            InselAbstand;
            
         when GlobaleDatentypen.Kontinente =>
            KontinentAbstand;
            
         when GlobaleDatentypen.Pangäa =>
            PangäaAbstand;
            
         when others =>
            return;
      end case;
      
   end AbstandFestlegen;
   
   
   
   procedure InselAbstand
   is begin
      
      if
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 3 > MaximalerAbstand (Karten.Kartenart).YAchse
      then
         YAchse := MaximalerAbstand (Karten.Kartenart).YAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 3 < MinimalerAbstand (Karten.Kartenart).YAchse
      then
         YAchse := MinimalerAbstand (Karten.Kartenart).YAchse;

      else
         YAchse := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 3;
      end if;

      if
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 3 > MaximalerAbstand (Karten.Kartenart).XAchse
      then
         XAchse := MaximalerAbstand (Karten.Kartenart).XAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 3 < MinimalerAbstand (Karten.Kartenart).XAchse
      then
         XAchse := MinimalerAbstand (Karten.Kartenart).XAchse;

      else
         XAchse := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 3;
      end if;

      Karten.FelderVonLandartZuLandart (Karten.Kartenart) := (YAchse, XAchse);
      
   end InselAbstand;
   
   
   
   procedure KontinentAbstand
   is begin
      
      if
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2 > MaximalerAbstand (Karten.Kartenart).YAchse
      then
         YAchse := MaximalerAbstand (Karten.Kartenart).YAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2 < MinimalerAbstand (Karten.Kartenart).YAchse
      then
         YAchse := MinimalerAbstand (Karten.Kartenart).YAchse;

      else
         YAchse := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße;
      end if;

      if
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 > MaximalerAbstand (Karten.Kartenart).XAchse
      then
         XAchse := MaximalerAbstand (Karten.Kartenart).XAchse;
         
      elsif
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2 < MinimalerAbstand (Karten.Kartenart).XAchse
      then
         XAchse := MinimalerAbstand (Karten.Kartenart).XAchse;

      else
         XAchse := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
      end if;

      Karten.FelderVonLandartZuLandart (Karten.Kartenart) := (YAchse, XAchse);
      
   end KontinentAbstand;
   
   
   
   procedure PangäaAbstand
   is begin
      
      YAchse := MaximalerAbstand (Karten.Kartenart).YAchse;

      XAchse := MaximalerAbstand (Karten.Kartenart).XAchse;

      Karten.FelderVonLandartZuLandart (Karten.Kartenart) := (YAchse, XAchse);
      
   end PangäaAbstand;

end LandwerteFestlegen;
