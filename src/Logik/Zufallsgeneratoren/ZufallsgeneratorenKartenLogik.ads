private with Ada.Numerics.Discrete_Random;

with SystemDatentypenHTSEB;

with KartenrohstoffeDatentypen;
with KartenRecords;

private with KartenDatentypen;

package ZufallsgeneratorenKartenLogik is
   pragma Elaborate_Body;
   use type KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum;

   function KartengeneratorZufallswerte
     return SystemDatentypenHTSEB.NullBisHundert;

   function KartengeneratorLandgrößen
     return KartenRecords.KartenfeldumgebungPositivRecord;

   function KartengeneratorRohstoffe
     return KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum;

   function KartengeneratorRohstoffbereich
     (AnfangExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum;
      EndeExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum
     with
       Pre => (
                 AnfangExtern <= EndeExtern
              );

private

   Zwischenspeicher : KartenRecords.KartenfeldumgebungPositivRecord;
   Gesamtwert : KartenRecords.KartenfeldumgebungPositivRecord;

   Landgröße : KartenRecords.LandgrößenRecord;

   package ZufälligeZahl is new Ada.Numerics.Discrete_Random (Result_Subtype => SystemDatentypenHTSEB.NullBisHundert);
   package ZufälligeSenkrechteLandgrößen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.SenkrechtePositiv);
   package ZufälligeWaagerechteLandgrößen is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenDatentypen.WaagerechtePositiv);

   package ZufälligerRohstoff is new Ada.Numerics.Discrete_Random (Result_Subtype => KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum);

   ZufälligeZahlGewählt : ZufälligeZahl.Generator;
   ZufälligeSenkrechteLandgrößeGewählt : ZufälligeSenkrechteLandgrößen.Generator;
   ZufälligeWaagerechteLandgrößeGewählt : ZufälligeWaagerechteLandgrößen.Generator;

   ZufälligerRohstoffGewählt : ZufälligerRohstoff.Generator;

end ZufallsgeneratorenKartenLogik;
