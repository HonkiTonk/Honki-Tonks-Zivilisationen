pragma SPARK_Mode (On);

package GrafikStart is
   
   procedure FensterEntfernen;
   
   
   
   function FensterErzeugen
     return Boolean;
   
private
   
   Name : constant Wide_Wide_String := "Name des Spiels";

end GrafikStart;
