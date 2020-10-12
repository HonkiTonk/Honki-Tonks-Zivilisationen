with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Numerics.Discrete_Random, GlobaleDatentypen, SchleifenPruefungen, GlobaleVariablen, ImSpiel, KartenGenerator, Eingabe, Karten, Auswahl, EinheitenDatenbank, Anzeige;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

package SpielEinstellungen is

   function SpielEinstellungen return Integer;

private

   KartengrößeGewählt : Boolean; -- 1 .. 9
   KartenartGewählt : Boolean;
   KartentemperaturGewählt : Boolean;
   SpieleranzahlGewählt : Boolean; -- 1 .. 18
   RasseGewählt : Boolean; -- 1 .. 18
   StartwerteFestgelegt : Boolean;

   Wahl : Integer;
   Wahl2 : Integer;
   Wert : Integer;
   Rasse : Integer;
   FelderDrumHerum : Integer;

   KartenWert : GlobaleDatentypen.RückgabewertFürSchleifenPrüfungRecord;

   subtype ZufälligeKartengröße is Integer range 1 .. 9;
   subtype ZufälligeKartenart is Integer range 1 .. 3;
   subtype ZufälligeKartentemperatur is Integer range 1 .. 3;
   subtype ZufälligeSpieleranzahl is Integer range GlobaleVariablen.RassenImSpiel'Range;
   subtype ZufälligeRasse is Integer range GlobaleVariablen.RassenImSpiel'Range;

   -- Überarbeitung
   subtype Position is Integer range Karten.Karten'First (2) .. Karten.Karten'Last (2);
   subtype Rassen is Integer range GlobaleVariablen.RassenImSpiel'Range;

   package ZufälligeKartengrößeWählen is new Ada.Numerics.Discrete_Random (ZufälligeKartengröße);
   package ZufälligeKartenartWählen is new Ada.Numerics.Discrete_Random (ZufälligeKartenart);
   package ZufälligeKartentemperaturWählen is new Ada.Numerics.Discrete_Random (ZufälligeKartentemperatur);
   package ZufälligeSpieleranzahlWählen is new Ada.Numerics.Discrete_Random (ZufälligeSpieleranzahl);
   package ZufälligeRasseWählen is new Ada.Numerics.Discrete_Random (ZufälligeRasse);

   -- Überarbeitung
   package WerteWählen is new Ada.Numerics.Discrete_Random (Position);
   package RassenWählen is new Ada.Numerics.Discrete_Random (Rassen);

   ZufälligeKartengrößeGewählt : ZufälligeKartengrößeWählen.Generator;
   ZufälligeKartenartGewählt : ZufälligeKartenartWählen.Generator;
   ZufälligeKartentemperaturGewählt : ZufälligeKartentemperaturWählen.Generator;
   ZufälligeSpieleranzahlGewählt : ZufälligeSpieleranzahlWählen.Generator;
   ZufälligeRasseGewählt : ZufälligeRasseWählen.Generator;

   -- Überarbeitung
   PositionGewählt : WerteWählen.Generator;
   RassenGewählt : RassenWählen.Generator;

   function KartengrößeWählen return Integer;
   function KartenartWählen return Integer;
   function KartentemperaturWählen return Integer;
   function SpieleranzahlWählen return Integer;
   function RasseWählen return Integer;
   procedure StartwerteErmitteln;
   procedure StartpunktFestlegen (Rasse : in Integer);

end SpielEinstellungen;
