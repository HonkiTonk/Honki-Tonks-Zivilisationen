private with Ada.Numerics.Discrete_Random;

with SystemDatentypenHTSEB;

private with KartenDatentypen;

with KartenRecords;

package ZufallsgeneratorenKartenLogik is
   pragma Elaborate_Body;

   function KartengeneratorZufallswerte
     return SystemDatentypenHTSEB.NullBisHundert;

   function KartengeneratorLandgrößen
      return KartenRecords.KartenfeldumgebungPositivRecord;

private

   Minimalwert : KartenRecords.KartenfeldumgebungPositivRecord;
   Maximalwert : KartenRecords.KartenfeldumgebungPositivRecord;
   Zwischenspeicher : KartenRecords.KartenfeldumgebungPositivRecord;
   Gesamtwert : KartenRecords.KartenfeldumgebungPositivRecord;

   package ZufälligeZahl is new Ada.Numerics.Discrete_Random (Result_Subtype => SystemDatentypenHTSEB.NullBisHundert);
   package ZufälligeSenkrechteLandgrößen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.SenkrechtePositiv);
   package ZufälligeWaagerechteLandgrößen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.WaagerechtePositiv);

   ZufälligeZahlGewählt : ZufälligeZahl.Generator;
   ZufälligeSenkrechteLandgrößeGewählt : ZufälligeSenkrechteLandgrößen.Generator;
   ZufälligeWaagerechteLandgrößeGewählt : ZufälligeWaagerechteLandgrößen.Generator;

end ZufallsgeneratorenKartenLogik;
