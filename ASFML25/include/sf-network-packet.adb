--//////////////////////////////////////////////////////////
-- //
-- // SFML - Simple and Fast Multimedia Library
-- // Copyright (C) 2007-2009 Laurent Gomila (laurent.gom@gmail.com)
-- //
-- // This software is provided 'as-is', without any express or implied warranty.
-- // In no event will the authors be held liable for any damages arising from the use of this software.
-- //
-- // Permission is granted to anyone to use this software for any purpose,
-- // including commercial applications, and to alter it and redistribute it freely,
-- // subject to the following restrictions:
-- //
-- // 1. The origin of this software must not be misrepresented;
-- //    you must not claim that you wrote the original software.
-- //    If you use this software in a product, an acknowledgment
-- //    in the product documentation would be appreciated but is not required.
-- //
-- // 2. Altered source versions must be plainly marked as such,
-- //    and must not be misrepresented as being the original software.
-- //
-- // 3. This notice may not be removed or altered from any source distribution.
-- //
--//////////////////////////////////////////////////////////

--//////////////////////////////////////////////////////////

--//////////////////////////////////////////////////////////
with Interfaces.C.Strings;

package body Sf.Network.Packet is
   use Interfaces.C.Strings;

   --//////////////////////////////////////////////////////////
   --/ Functions to extract data from a packet
   --/
   --/ @param Packet   Packet to read
   --/
   --//////////////////////////////////////////////////////////
   procedure ReadString (packet : sfPacket_Ptr; Str : out String) is
      procedure Internal (packet : sfPacket_Ptr; Str : chars_ptr);
      pragma Import (C, Internal, "sfPacket_readString");
      Temp : chars_ptr;
   begin
      Internal (packet, Temp);
      Str := Value (Temp) (Str'RANGE);
      Free (Temp);
   end ReadString;

   --//////////////////////////////////////////////////////////
   --/ Functions to insert data into a packet
   --/
   --/ @param Packet   Packet to write
   --/
   --//////////////////////////////////////////////////////////
   procedure WriteString (packet : sfPacket_Ptr; item : String) is
      procedure Internal (packet : sfPacket_Ptr; Str : chars_ptr);
      pragma Import (C, Internal, "sfPacket_writeString");
      Temp : chars_ptr := New_String (item);
   begin
      Internal (Packet, Temp);
      Free (Temp);
   end WriteString;

   procedure writeWideString (packet : sfPacket_Ptr;
                              item   : Wide_Wide_String) is
      procedure Internal (packet : sfPacket_Ptr; Str : C.char32_array);
      pragma Import (C, Internal, "sfPacket_writeWideString");
   begin
      Internal (Packet, C.To_C (item));
   end writeWideString;

end Sf.Network.Packet;
