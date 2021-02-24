pragma SPARK_Mode (On);

with Ada.Numerics.Discrete_Random;

with GlobaleDatentypen, GlobaleRecords;
use GlobaleDatentypen;

with Karten;

package SpielEinstellungen is

   function SpielEinstellungen return Integer;

private

   PrüfungEinheit : Boolean;
   PrüfungGrund : Boolean;

   YPosition : GlobaleDatentypen.Kartenfeld;
   XPosition : GlobaleDatentypen.Kartenfeld;

   SpielerAnzahl : Positive := 1; -- 1 .. 18
   Wahl : Integer;
   Wahl2 : Integer;
   Wert : Integer;
   Rasse : Integer;
   RassenAusgewählt : Integer;
   SicherheitsTestWert : Integer;
   BenutzerdefinierteGröße : Integer;
   Spieler : Integer;
   Zufallswahl : Integer;

   PositionWert : GlobaleRecords.RassePlatznummerRecord;
   GezogeneWerte : GlobaleRecords.AchsenKartenfeldPositivRecord;
   KartenWert : GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord;
   PlatzBelegt : GlobaleRecords.RassePlatznummerRecord;

   type KoordinatenArray is array (1 .. 2) of GlobaleRecords.AchsenKartenfeldRecord;
   Koordinaten : KoordinatenArray;

   subtype ZufälligeKartengröße is Integer range 1 .. 9;
   subtype ZufälligeKartenart is Integer range 1 .. 3;
   subtype ZufälligeKartentemperatur is Integer range 1 .. 3;
   subtype ZufälligeSpieleranzahl is Integer range Integer (GlobaleDatentypen.Rassen'First) .. Integer (GlobaleDatentypen.Rassen'Last);
   subtype ZufälligeRasse is Integer range Integer (GlobaleDatentypen.Rassen'First) .. Integer (GlobaleDatentypen.Rassen'Last);

   subtype Rassen is Integer range Integer (GlobaleDatentypen.Rassen'First) .. Integer (GlobaleDatentypen.Rassen'Last);

   package ZufälligeKartengrößeWählen is new Ada.Numerics.Discrete_Random (ZufälligeKartengröße);
   package ZufälligeKartenartWählen is new Ada.Numerics.Discrete_Random (ZufälligeKartenart);
   package ZufälligeKartentemperaturWählen is new Ada.Numerics.Discrete_Random (ZufälligeKartentemperatur);
   package ZufälligeSpieleranzahlWählen is new Ada.Numerics.Discrete_Random (ZufälligeSpieleranzahl);
   package ZufälligeRasseWählen is new Ada.Numerics.Discrete_Random (ZufälligeRasse);

   package RassenWählen is new Ada.Numerics.Discrete_Random (Rassen);

   ZufälligeKartengrößeGewählt : ZufälligeKartengrößeWählen.Generator;
   ZufälligeKartenartGewählt : ZufälligeKartenartWählen.Generator;
   ZufälligeKartentemperaturGewählt : ZufälligeKartentemperaturWählen.Generator;
   ZufälligeSpieleranzahlGewählt : ZufälligeSpieleranzahlWählen.Generator;
   ZufälligeRasseGewählt : ZufälligeRasseWählen.Generator;

   RassenGewählt : RassenWählen.Generator;

   procedure StartwerteErmitteln;
   procedure StartpunktFestlegen (RasseExtern : in GlobaleDatentypen.Rassen);

   function KartengrößeWählen return Integer with
     Post => KartengrößeWählen'Result >= -2;

   function KartenartWählen return Integer with
     Post => KartenartWählen'Result >= -2;

   function KartentemperaturWählen return Integer with
     Post => KartentemperaturWählen'Result >= -2;

   function SpieleranzahlWählen return Integer with
     Post => SpieleranzahlWählen'Result >= -2;

   function MenschlicheSpieleranzahl return Integer with
     Post => MenschlicheSpieleranzahl'Result >= -2;

   function RasseWählen return Integer with
     Post => RasseWählen'Result >= -2;

   function UmgebungPrüfen (YPosition, XPosition : in GlobaleDatentypen.KartenfeldPositiv; RasseExtern : in GlobaleDatentypen.Rassen) return Boolean with
     Pre => YPosition <= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße and XPosition <= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

end SpielEinstellungen;
