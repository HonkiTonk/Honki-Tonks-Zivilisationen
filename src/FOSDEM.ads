with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
-- with Ada.Integer_Wide_Wide_Text_IO;
-- with Ada.Float_Wide_Wide_Text_IO;
-- with Ada.Float_Text_IO;

package FOSDEM is
   
   RecordStringsAttempt : constant Positive := 5;
   RecordImageAttempt : constant Positive := 2;
   RecordInputOutputAttempt : constant Positive := 1;
   RecordEndAttempt : constant Positive := 1;
   
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

end FOSDEM;
