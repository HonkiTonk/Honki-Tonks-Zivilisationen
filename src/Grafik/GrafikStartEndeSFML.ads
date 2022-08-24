pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package GrafikStartEndeSFML is
   
   procedure FensterErzeugen;
   procedure FensterEntfernen;

   procedure FensterLeeren;
   procedure FensterAnzeigen;
   
private
   
   procedure FensterErzeugenErweitert;

end GrafikStartEndeSFML;
