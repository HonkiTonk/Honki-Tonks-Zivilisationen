with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

package FOSDEM is
   
   RecordInputOutputAttempt : constant Positive := 2;
   
private
   
   -- Text_IO
   -- Stream_IO
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   IntegerNumber : Integer := 3;
   FloatNumber : Float := 0.20;
   
   IntegerNumberToText : Unbounded_Wide_Wide_String
     := To_Unbounded_Wide_Wide_String (Source => IntegerNumber'Wide_Wide_Image);
   FloatNumberToText : Unbounded_Wide_Wide_String
     := To_Unbounded_Wide_Wide_String (Source => FloatNumber'Wide_Wide_Image);
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   -- Stringtype, Wide_Stringtype, Wide_Wide_Stringtype.
   
      MostImportantString : Unbounded_Wide_Wide_String
     := To_Unbounded_Wide_Wide_String ("Put Wide_Wide_String here");
   
   SometimesNeededString : Wide_Wide_String (1 .. 10)
     := To_Wide_Wide_String (MostImportantString) (1 .. 10);
   
   SingleTestCharacter : constant Wide_Wide_Character := '@';
   
   
   
   
   
   
   
   RecordImageAttempt : constant Positive := 3;
   
   
   
   
   
   
   
   
   RecordStringsAttempt : constant Positive := 6;
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   

end FOSDEM;
