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

package body Sf.Graphics.Text is
   use Interfaces.C.Strings;

  --//////////////////////////////////////////////////////////
  --/ @brief Set the string of a text (from an ANSI string)
  --/
  --/ A text's string is empty by default.
  --/
  --/ @param text   Text object
  --/ @param string New string
  --/
  --//////////////////////////////////////////////////////////
   procedure setString (Text : sfText_Ptr; Str : String) is
      procedure Internal (Text : sfText_Ptr; Str : chars_ptr);
      pragma Import (C, Internal, "sfText_setString");
      Temp : chars_ptr := New_String (Str);
   begin
      Internal (Text, Temp);
      Free (Temp);
   end setString;


   --//////////////////////////////////////////////////////////
   --/ @brief Set the string of a text (from a unicode string)
   --/
   --/ @param text   Text object
   --/ @param str New string
   --/
   --//////////////////////////////////////////////////////////
   procedure setUnicodeString (text : sfText_Ptr; str : Wide_Wide_String) is
      procedure Internal (Text : sfText_Ptr; Str : C.char32_array);
      pragma Import (C, Internal, "sfText_setUnicodeString");
   begin
      Internal (Text, C.To_C (str));
   end setUnicodeString;

  --//////////////////////////////////////////////////////////
  --/ @brief Get the string of a text (returns an ANSI string)
  --/
  --/ @param text Text object
  --/
  --/ @return String as a locale-dependant ANSI string
  --/
  --//////////////////////////////////////////////////////////
   function getString (Text : sfText_Ptr) return Standard.String is
      function Internal (Text : sfText_Ptr) return chars_ptr;
      pragma Import (C, Internal, "sfText_getString");
      Temp : constant chars_ptr := Internal (Text);
      Res  : constant Standard.String := Value (Temp);
   begin
      return Res;
   end getString;

   function sfText_getUnicodeString (Text : sfText_Ptr) return access C.char32_t;
   pragma Import (C, sfText_getUnicodeString, "sfText_getUnicodeString");

   function getUnicodeString (Text : sfText_Ptr) return Wide_Wide_String is
   begin
      return C.To_Ada (Char32_Ptrs.Value (sfText_getUnicodeString (Text)));
   end getUnicodeString;
   
end Sf.Graphics.Text;
