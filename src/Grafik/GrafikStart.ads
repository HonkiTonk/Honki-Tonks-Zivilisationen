pragma SPARK_Mode (On);

package GrafikStart is
      
   function FensterErzeugen
     return Boolean;
   
   procedure FensterEntfernen;
   
private
   
   Name : constant Wide_Wide_String := "Name des Spiels";

end GrafikStart;
