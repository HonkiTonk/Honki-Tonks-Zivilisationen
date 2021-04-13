pragma SPARK_Mode (On);

package Hauptmenue with
Abstract_State => (HauptmenüAbstraktion)
is

   procedure Hauptmenü
     with
       Global =>
         (In_Out => HauptmenüAbstraktion),
     Depends =>
       (HauptmenüAbstraktion => HauptmenüAbstraktion);
   
private   

   LadenErfolgreich : Boolean
     with Part_Of =>
       HauptmenüAbstraktion;

   Startauswahl : Integer
     with Part_Of =>
       HauptmenüAbstraktion;
   
   RückgabeKampagne : Integer
     with Part_Of =>
       HauptmenüAbstraktion;
         
   RückgabeOptionen : Integer
     with Part_Of =>
       HauptmenüAbstraktion;

end Hauptmenue;
