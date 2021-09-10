pragma SPARK_Mode (On);

package body LandwerteFestlegen is

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
           
      case
        Karten.Kartenart
      is
         when GlobaleDatentypen.Inseln | GlobaleDatentypen.Kontinente | GlobaleDatentypen.Nur_Land | GlobaleDatentypen.Chaos =>
            Karten.GrößeLandart := (
                                      GlobaleDatentypen.Inseln     => (6, 6),
                                      GlobaleDatentypen.Kontinente => (15, 15),
                                      GlobaleDatentypen.Pangäa     => (1, 1),
                                      GlobaleDatentypen.Nur_Land   => (1, 1),
                                      GlobaleDatentypen.Chaos      => (1, 1)
                                     );
            AbstandFestlegen;
            return;
            
         when GlobaleDatentypen.Pangäa =>
            null;
      end case;
      
      if
        Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße < Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2
      then
         GrößePangäa := Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 2;

      elsif
        Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße < Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2
      then
         GrößePangäa := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 2;

      else
         GrößePangäa := Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße / 3 + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße / 3;
      end if;
      
      Karten.GrößeLandart := (
                                GlobaleDatentypen.Inseln     => (6, 6),
                                GlobaleDatentypen.Kontinente => (15, 15),
                                GlobaleDatentypen.Pangäa     => (GrößePangäa, GrößePangäa),
                                GlobaleDatentypen.Nur_Land   => (1, 1),
                                GlobaleDatentypen.Chaos      => (1, 1)
                               );
      
      AbstandFestlegen;
      
   end GrößeFestlegen;
   
   
   
   procedure InselGröße
   is begin
      
      null;
      
   end InselGröße;
   
   
   
   procedure KontinentGröße
   is begin
      
      null;
      
   end KontinentGröße;
   
   
   
   procedure PangäaGröße
   is begin
      
      null;
      
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
      
      Karten.FelderVonLandartZuLandart := (
                                           GlobaleDatentypen.Inseln     => (19, 19),
                                           GlobaleDatentypen.Kontinente => (45, 45),
                                           GlobaleDatentypen.Pangäa     => (1, 1),
                                           GlobaleDatentypen.Nur_Land   => (1, 1),
                                           GlobaleDatentypen.Chaos      => (1, 1)
                                          );
      
   end AbstandFestlegen;
   
   
   
   procedure InselAbstand
   is begin
      
      null;
      
   end InselAbstand;
   
   
   
   procedure KontinentAbstand
   is begin
      
      null;
      
   end KontinentAbstand;
   
   
   
   procedure PangäaAbstand
   is begin
      
      null;
      
   end PangäaAbstand;

end LandwerteFestlegen;
