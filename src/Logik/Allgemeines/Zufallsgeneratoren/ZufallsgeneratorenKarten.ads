pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with Ada.Numerics.Float_Random;
with Ada.Numerics.Discrete_Random;

with KartenDatentypen;

package ZufallsgeneratorenKarten is

   function KartengeneratorZufallswerte
     return KartenDatentypen.WahrscheinlichkeitKartengenerator;

private

   ZufälligerKommawert : Ada.Numerics.Float_Random.Generator;

   package ZufälligeZahl is new Ada.Numerics.Discrete_Random (KartenDatentypen.WahrscheinlichkeitKartengenerator);

   zufälligeZahlGewählt : ZufälligeZahl.Generator;

end ZufallsgeneratorenKarten;
