pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO;
use Ada.Wide_Wide_Text_IO;

package body Programmanalyse is

   procedure Auswahl is
   begin
      
      DatentypGröße;
      WerteAufrufprüfung;
      
   end Auswahl;
     
     

   procedure DatentypGröße is
   begin

      Put (Item => "Belegte Bits: ");
      Ada.Float_Text_IO.Put (Item => Bit,
                             Exp  => 0);
      New_Line;
      
      Put (Item => "Belegte Bytes: ");
      Ada.Float_Text_IO.Put (Item => Byte,
                             Exp  => 0);
      New_Line;
      
      Put (Item => "Belegte Kilobytes: ");
      Ada.Float_Text_IO.Put (Item => Kilobyte,
                             Exp  => 0);
      New_Line;
      
      Put (Item => "Belegte Megabytes: ");
      Ada.Float_Text_IO.Put (Item => Megabyte,
                             Exp  => 0);
      New_Line;

      Get_Immediate (Taste);
      
   end DatentypGröße;



   procedure WerteAufrufprüfung is
   begin

      Put_Line (Item => "Los gehts!");      
      Put_Line (Item => "Fertig!");
      Get_Immediate (Taste);
      
   end WerteAufrufprüfung;

end Programmanalyse;
