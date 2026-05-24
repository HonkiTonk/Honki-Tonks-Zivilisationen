package KampfDatentypen is
   pragma Pure;

   type KampfwerteBasis is range 0 .. 1_000;
   subtype KampfwerteEinheiten is KampfwerteBasis range 0 .. 100;



   type LebenspunkteBasis is range -1_000 .. 1_000;
   subtype LebenspunkteVorhanden is LebenspunkteBasis range 0 .. LebenspunkteBasis'Last;



   type ReichweiteBasis is range 0 .. 3;
   subtype ReichweiteVorhanden is ReichweiteBasis range 1 .. ReichweiteBasis'Last;



   type ErfahrungspunkteBasis is range 0 .. 100;
   subtype ErfahrungspunkteVorhanden is ErfahrungspunkteBasis range 1 .. ErfahrungspunkteBasis'Last;

   subtype Rang is ErfahrungspunkteBasis range ErfahrungspunkteBasis'First .. 3;



   type Kampfbonus is new Float range 0.00 .. 10.00;



   type Kampf_Enum is (
                       Verteidigung_Enum, Angriff_Enum
                      );

end KampfDatentypen;
