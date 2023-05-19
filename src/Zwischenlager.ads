procedure Read
  (StreamExtern : in out Bit_Stream; Data : out Bit_Array)
is
   Last : Stream_Element_Offset;
begin

   for Test in Data'Range loop

      if
        StreamExtern.Read_Count = 0
      then
         StreamExtern.Channel.Read (StreamExtern.Input, Last);
         StreamExtern.Read_Count := Stream_Element'Size;

      else
         null;
      end if;

      Data (Test) := Bit (StreamExtern.Input (1) / 2**(Stream_Element'Size - 1));
      StreamExtern.Input (1)  := StreamExtern.Input (1) * 2;
      StreamExtern.Read_Count := StreamExtern.Read_Count - 1;

   end loop;

end Read;



procedure Write
  (StreamExtern : in out Bit_Stream;
   Data : Boolean)
is begin

   if
     StreamExtern.Write_Count = Stream_Element'Size
   then
      StreamExtern.Channel.Write (StreamExtern.Output);
      StreamExtern.Write_Count := 0;

   else
      null;
   end if;

   StreamExtern.Output (1)  := StreamExtern.Output (1) * 2; -- or Stream_Element (Data (Test));
   StreamExtern.Write_Count := StreamExtern.Write_Count + 1;

end Write;




declare
   Bits : Bit_Stream (Stream (DateiSpeichernExtern));
begin
   Write (StreamExtern => Bits,
          Data         => True);
