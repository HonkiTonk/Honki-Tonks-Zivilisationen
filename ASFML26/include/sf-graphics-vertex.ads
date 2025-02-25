--//////////////////////////////////////////////////////////
-- SFML - Simple and Fast Multimedia Library
-- Copyright (C) 2007-2023 Laurent Gomila (laurent@sfml-dev.org)
-- This software is provided 'as-is', without any express or implied warranty.
-- In no event will the authors be held liable for any damages arising from the use of this software.
-- Permission is granted to anyone to use this software for any purpose,
-- including commercial applications, and to alter it and redistribute it freely,
-- subject to the following restrictions:
-- 1. The origin of this software must not be misrepresented;
--    you must not claim that you wrote the original software.
--    If you use this software in a product, an acknowledgment
--    in the product documentation would be appreciated but is not required.
-- 2. Altered source versions must be plainly marked as such,
--    and must not be misrepresented as being the original software.
-- 3. This notice may not be removed or altered from any source distribution.
--//////////////////////////////////////////////////////////

with Sf.System.Vector2;
with Sf.Graphics.Color;

package Sf.Graphics.Vertex is

   --//////////////////////////////////////////////////////////
   --/ Define a point with color and texture coordinates
   --//////////////////////////////////////////////////////////
   --/ @field position Position of the vertex
   --/ @field color Color of the vertex
   --/ @field texCoords Coordinates of the texture's pixel to map to the vertex
   type sfVertex is record
      position : aliased Sf.System.Vector2.sfVector2f;
      color : aliased Sf.Graphics.Color.sfColor;
      texCoords : aliased Sf.System.Vector2.sfVector2f;
   end record;

private

   pragma Convention (C_Pass_By_Copy, sfVertex);

end Sf.Graphics.Vertex;
