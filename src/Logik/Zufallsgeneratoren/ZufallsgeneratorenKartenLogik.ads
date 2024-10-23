private with Ada.Numerics.Discrete_Random;

private with KartenDatentypen;

with KartenRecords;
with SystemDatentypen;

package ZufallsgeneratorenKartenLogik is
   pragma Elaborate_Body;

   function KartengeneratorZufallswerte
     return SystemDatentypen.NullBisHundert;

   function KartengeneratorLandgrößen
      return KartenRecords.KartenfeldumgebungPositivRecord;

private

   Minimalwert : KartenRecords.KartenfeldumgebungPositivRecord;
   Maximalwert : KartenRecords.KartenfeldumgebungPositivRecord;
   Zwischenspeicher : KartenRecords.KartenfeldumgebungPositivRecord;
   Gesamtwert : KartenRecords.KartenfeldumgebungPositivRecord;

   package ZufälligeZahl is new Ada.Numerics.Discrete_Random (Result_Subtype => SystemDatentypen.NullBisHundert);
   package ZufälligeSenkrechteLandgrößen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.SenkrechtePositiv);
   package ZufälligeWaagerechteLandgrößen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.WaagerechtePositiv);

   ZufälligeZahlGewählt : ZufälligeZahl.Generator;
   ZufälligeSenkrechteLandgrößeGewählt : ZufälligeSenkrechteLandgrößen.Generator;
   ZufälligeWaagerechteLandgrößeGewählt : ZufälligeWaagerechteLandgrößen.Generator;

end ZufallsgeneratorenKartenLogik;
