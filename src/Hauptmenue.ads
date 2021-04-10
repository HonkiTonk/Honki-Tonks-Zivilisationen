pragma SPARK_Mode (On);

package Hauptmenue is

   procedure Hauptmenü
     with
       Global => (null),
     Depends => (null),
     Pre => (True),
     Post => (True);
   
private   

   LadenErfolgreich : Boolean;

   Startauswahl : Integer;
   RückgabeKampagne : Integer;
   RückgabeOptionen : Integer;

end Hauptmenue;
