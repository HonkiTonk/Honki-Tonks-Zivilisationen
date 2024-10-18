private with Ada.Numerics.Discrete_Random;

private with KartenDatentypen;

with KartenRecords;
with SystemDatentypen;

package ZufallsgeneratorenKartenLogik is
   pragma Elaborate_Body;

   function KartengeneratorZufallswerte
     return SystemDatentypen.NullBisHundert;

   function KartengeneratorLandgrößen
      return KartenRecords.YXAchsenKartenfeldPositivRecord;

private

   Minimalwert : KartenRecords.YXAchsenKartenfeldPositivRecord;
   Maximalwert : KartenRecords.YXAchsenKartenfeldPositivRecord;
   Zwischenspeicher : KartenRecords.YXAchsenKartenfeldPositivRecord;
   Gesamtwert : KartenRecords.YXAchsenKartenfeldPositivRecord;

   package ZufälligeZahl is new Ada.Numerics.Discrete_Random (Result_Subtype => SystemDatentypen.NullBisHundert);
   package ZufälligeSenkrechteLandgrößen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.SenkrechtePositiv);
   package ZufälligeWaagerechteLandgrößen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.WaagerechtePositiv);

   ZufälligeZahlGewählt : ZufälligeZahl.Generator;
   ZufälligeSenkrechteLandgrößeGewählt : ZufälligeSenkrechteLandgrößen.Generator;
   ZufälligeWaagerechteLandgrößeGewählt : ZufälligeWaagerechteLandgrößen.Generator;

end ZufallsgeneratorenKartenLogik;
