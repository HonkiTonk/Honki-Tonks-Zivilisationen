private with Ada.Numerics.Discrete_Random;

with KartenDatentypen;
with SystemDatentypen;

package ZufallsgeneratorenKartenLogik is
   pragma Elaborate_Body;

   function KartengeneratorZufallswerte
     return SystemDatentypen.NullBisHundert;

   function KartengeneratorLandgrößen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.SenkrechtePositiv;

private

   MinimalerWert : KartenDatentypen.SenkrechtePositiv;
   MaximalerWert : KartenDatentypen.SenkrechtePositiv;
   Zwischenspeicher : KartenDatentypen.SenkrechtePositiv;

   package ZufälligeZahl is new Ada.Numerics.Discrete_Random (Result_Subtype => SystemDatentypen.NullBisHundert);
   package ZufälligeLandgrößen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.SenkrechtePositiv);

   ZufälligeZahlGewählt : ZufälligeZahl.Generator;
   ZufälligeLandgrößeGewählt : ZufälligeLandgrößen.Generator;

end ZufallsgeneratorenKartenLogik;
