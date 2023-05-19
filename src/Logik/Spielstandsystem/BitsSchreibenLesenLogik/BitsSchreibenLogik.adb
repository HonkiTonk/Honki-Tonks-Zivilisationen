with Ada.Streams; use Ada.Streams;

package body BitsSchreibenLogik is

   procedure BooleanSchreiben
     (DateiSpeichernExtern : in File_Type;
      BooleanExtern : in Boolean)
   is
      BooleanBit : BitsDatentypen.Bit_Stream (Stream (DateiSpeichernExtern));
   begin
      case
        BooleanExtern
      is
         when False =>
            BooleanZahlenwert := 0;
            
         when True =>
            BooleanZahlenwert := 1;
      end case;

      BooleanBit.Output (1) := Stream_Element (BooleanZahlenwert);
      
      if
        BooleanBit.Write_Count = Stream_Element'Size
      then
         BooleanBit.Channel.Write (BooleanBit.Output);
         BooleanBit.Write_Count := 0;

      else
         null;
      end if;
     -- BooleanBit.Write_Count := BooleanBit.Write_Count + 1;
      
      
    --  BooleanBit.Channel.Write (BooleanBit.Output);
    --  BooleanBit.Output (1) := BooleanBit.Output (1) * 2 or Stream_Element (BooleanZahlenwert);
      
    --  case
     --   BooleanBit.Write_Count
     -- is
     --    when Stream_Element'Size =>
    --        BooleanBit.Channel.Write (BooleanBit.Output);
            
     --    when others =>
     --       null;
   --   end case;
      
   end BooleanSchreiben;
   
   
   
   procedure VieleBooleansSchreiben
     (DateiSpeichernExtern : in File_Type;
      SichtbarkeitExtern : in KartenRecords.SichtbarkeitArray)
   is begin
      
      null;
      
   end VieleBooleansSchreiben;

end BitsSchreibenLogik;
