pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with Ada.Numerics.Discrete_Random;

with KartenDatentypen;

package ZufallsgeneratorenKarten is

   function KartengeneratorZufallswerte
     return KartenDatentypen.Auswahlbereich;

   function KartengeneratorBoolean
     return Boolean;

   function KartengeneratorLandgrößen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv;

   function KartengeneratorAbstände
     (YAchseXAchseExtern : in Boolean)
     return KartenDatentypen.KartenfeldPositiv;

private

   MinimalerWert : KartenDatentypen.KartenfeldPositiv;
   MaximalerWert : KartenDatentypen.KartenfeldPositiv;
   GezogenerWert : KartenDatentypen.KartenfeldPositiv;

   package ZufälligeZahl is new Ada.Numerics.Discrete_Random (KartenDatentypen.Auswahlbereich);
   package ZufälligerBoolean is new Ada.Numerics.Discrete_Random (Boolean);
   package ZufälligeLandgrößenAbstände is new Ada.Numerics.Discrete_Random (KartenDatentypen.KartenfeldPositiv);

   ZufälligeZahlGewählt : ZufälligeZahl.Generator;
   ZufälligerBooleanGewählt : ZufälligerBoolean.Generator;
   ZufälligeLandgrößeAbstandGewählt : ZufälligeLandgrößenAbstände.Generator;

end ZufallsgeneratorenKarten;
