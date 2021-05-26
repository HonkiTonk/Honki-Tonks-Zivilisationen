pragma SPARK_Mode (On);

package Hauptmenue with
Abstract_State => (HauptmenüAbstraktion)
is

   procedure Hauptmenü;
   
private
  
   RückgabeKampagne : Integer with Part_Of => HauptmenüAbstraktion;         
   RückgabeOptionen : Integer with Part_Of => HauptmenüAbstraktion;

end Hauptmenue;
