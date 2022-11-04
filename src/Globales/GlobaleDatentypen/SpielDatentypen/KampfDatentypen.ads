pragma Warnings (Off, "*array aggregate*");

package KampfDatentypen is
   pragma Pure;

   -- Negativer Bereich für Abzug.
   -- Das für Angriff, Verteidigung und Lebenspunkte verwenden oder noch weiter aufteilen? äöü
   type KampfwerteGroß is range -1_000 .. 1_000;
   subtype KampfwerteAllgemein is KampfwerteGroß range -100 .. 100;
   subtype Kampfwerte is KampfwerteAllgemein range 0 .. 100;
   subtype Schadensbereiche is Kampfwerte range 1 .. 3;



   type Reichweite is range 1 .. 3;



   type Erfahrungspunkte is range 0 .. 100;
   subtype ErfahrungspunkteVorhanden is Erfahrungspunkte range 1 .. Erfahrungspunkte'Last;

   subtype Rang is Erfahrungspunkte range Erfahrungspunkte'First .. 3;
   subtype RangVorhanden is Rang range 1 .. Rang'Last;



   type Kampf_Enum is (
                       Verteidigung_Enum, Angriff_Enum
                      );

end KampfDatentypen;
