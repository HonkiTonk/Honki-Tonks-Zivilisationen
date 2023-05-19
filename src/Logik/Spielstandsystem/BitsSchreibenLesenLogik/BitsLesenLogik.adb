with Ada.Streams; use Ada.Streams;

with Diagnoseinformationen;

package body BitsLesenLogik is
   
   function BooleanLesen
     (DateiLadenExtern : in File_Type)
      return Boolean
   is
      Last : Stream_Element_Offset;
      BooleanBit : BitsDatentypen.Bit_Stream (Stream (DateiLadenExtern));
   begin
            
      case
        BooleanBit.Read_Count
      is
         when 0 =>
            BooleanBit.Channel.Read (BooleanBit.Input, Last);
            BooleanBit.Read_Count := Stream_Element'Size;
            
         when others =>
            null;
      end case;
         
      BooleanZahlenwert := BitsDatentypen.Bit (BooleanBit.Input (1) / 2**(Stream_Element'Size - 1));
      -- BooleanBit.Input (1) := BooleanBit.Input (1) * 2;
      
      case
        BooleanZahlenwert
      is
         when 0 =>
            return False;
            
         when 1 =>
            Diagnoseinformationen.Zahl (ZahlExtern => Integer (BooleanZahlenwert));
            return True;
      end case;
      
   end BooleanLesen;

end BitsLesenLogik;
