package KampfDatentypen is
   pragma Pure;

   -- Negativer Bereich für Abzug.
   -- Das für Angriff, Verteidigung und Lebenspunkte verwenden oder noch weiter aufteilen? äöü
   -- Da negative Werte jetzt nicht mehr gebraucht werden die Datentypen anpassen, auch hinsichtlich der Multiplikation. äöü
   -- EinheitenDatentypen enthält schon Lebenspunkte, diese eventuell hierher verschieben? äöü
   type KampfwerteGroß is range 0 .. 1_000;
   subtype KampfwerteAllgemein is KampfwerteGroß range 0 .. 100;

   subtype KampfwerteEinheiten is KampfwerteAllgemein range 0 .. 100;



   type Reichweite is range 0 .. 3;
   subtype ReichweiteVorhanden is Reichweite range 1 .. Reichweite'Last;



   type Erfahrungspunkte is range 0 .. 100;
   subtype ErfahrungspunkteVorhanden is Erfahrungspunkte range 1 .. Erfahrungspunkte'Last;

   subtype Rang is Erfahrungspunkte range Erfahrungspunkte'First .. 3;
   subtype RangVorhanden is Rang range 1 .. Rang'Last;



   type Kampfbonus is new Float range 0.00 .. 10.00;



   type Kampf_Enum is (
                       Verteidigung_Enum, Angriff_Enum
                      );

end KampfDatentypen;
