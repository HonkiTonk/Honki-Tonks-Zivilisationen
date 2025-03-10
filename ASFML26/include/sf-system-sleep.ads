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

--//////////////////////////////////////////////////////////

with Sf.System.Time;

package Sf.System.Sleep is

   --//////////////////////////////////////////////////////////
   --//////////////////////////////////////////////////////////
   --//////////////////////////////////////////////////////////

   --//////////////////////////////////////////////////////////
   --//////////////////////////////////////////////////////////
   --/ @brief Make the current thread sleep for a given duration
   --/
   --/ sfSleep is the best way to block a program or one of its
   --/ threads, as it doesn't consume any CPU power.
   --/
   --/ @param duration Time to sleep
   --/
   --//////////////////////////////////////////////////////////
   procedure sfSleep (duration : Sf.System.Time.sfTime);

   --//////////////////////////////////////////////////////////
   --/ @brief Make the current thread sleep for a given time
   --/
   --/ @param seconds   Time to sleep, in seconds (Ada duration)
   --/
   --//////////////////////////////////////////////////////////
   procedure sfDelay (seconds : Duration);

private

   pragma Import (C, sfSleep, "sfSleep");


end Sf.System.Sleep;
