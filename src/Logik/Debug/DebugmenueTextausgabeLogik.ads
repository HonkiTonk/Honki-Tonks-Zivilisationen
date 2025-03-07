private with ArraysHTSEB;

package DebugmenueTextausgabeLogik is

   procedure TexteAusgeben;

private

   Taste : Wide_Wide_Character;

   Zeile : Positive;

   procedure MenütexteAusgeben;
   procedure SpieltexteAusgeben;
   procedure SequenztexteAusgeben;
   procedure KartentexteAusgeben;
   procedure SpeziestexteAusgeben;

   procedure Test
     (ArrayExtern : in ArraysHTSEB.AllgemeinesTextArray);


   function Pause
     return Positive
     with
       Post => (
                  Pause'Result = 1
               );

end DebugmenueTextausgabeLogik;
