pragma SPARK_Mode (On);

package GrafikStartEnde is
   
   procedure FensterEntfernen;
   procedure FensterErzeugen;

   procedure FensterLeeren;
   procedure FensterAnzeigen;
   
private
      
   Name : constant Wide_Wide_String := "Name des Spiels";

end GrafikStartEnde;