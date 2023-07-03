package KampfDatentypen is
   pragma Pure;

   type Kampfwerte is range 0 .. 1_000;
   subtype KampfwerteEinheiten is Kampfwerte range 0 .. 100;



   type Lebenspunkte is range -1_000 .. 1_000;
   subtype LebenspunkteVorhanden is Lebenspunkte range 1 .. Lebenspunkte'Last;



   type Reichweite is range 0 .. 3;
   subtype ReichweiteVorhanden is Reichweite range 1 .. Reichweite'Last;



   type Erfahrungspunkte is range 0 .. 100;
   subtype ErfahrungspunkteVorhanden is Erfahrungspunkte range 1 .. Erfahrungspunkte'Last;

   subtype Rang is Erfahrungspunkte range Erfahrungspunkte'First .. 3;



   type Kampfbonus is new Float range 0.00 .. 10.00;



   type Kampf_Enum is (
                       Verteidigung_Enum, Angriff_Enum
                      );

end KampfDatentypen;
