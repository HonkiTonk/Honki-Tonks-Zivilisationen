pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

private with Ada.Numerics.Discrete_Random;

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

   package ZufälligeZahl is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.Auswahlbereich);
   package ZufälligerBoolean is new Ada.Numerics.Discrete_Random (Result_Subtype => Boolean);
   package ZufälligeLandgrößenAbstände is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.KartenfeldPositiv);

   ZufälligeZahlGewählt : ZufälligeZahl.Generator;
   ZufälligerBooleanGewählt : ZufälligerBoolean.Generator;
   ZufälligeLandgrößeAbstandGewählt : ZufälligeLandgrößenAbstände.Generator;

end ZufallsgeneratorenKarten;
