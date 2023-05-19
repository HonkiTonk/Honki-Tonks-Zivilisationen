with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with KartenRecords;

private with BitsDatentypen;

package BitsSchreibenLogik is
   
   procedure BooleanSchreiben
     (DateiSpeichernExtern : in File_Type;
      BooleanExtern : in Boolean);
   
   procedure VieleBooleansSchreiben
     (DateiSpeichernExtern : in File_Type;
      SichtbarkeitExtern : in KartenRecords.SichtbarkeitArray);
   
private
   
   BooleanZahlenwert : BitsDatentypen.Bit;

end BitsSchreibenLogik;
