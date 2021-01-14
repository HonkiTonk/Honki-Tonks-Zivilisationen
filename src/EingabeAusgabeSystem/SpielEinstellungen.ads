with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Numerics.Discrete_Random, Ada.Calendar, Ladezeiten;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Calendar;

with GlobaleDatentypen, SchleifenPruefungen, GlobaleVariablen, ImSpiel, KartenGenerator, Eingabe, Karten, Auswahl, EinheitenDatenbank, Anzeige, ZufallsGeneratoren;
use GlobaleDatentypen;

package SpielEinstellungen is

   function SpielEinstellungen return Integer;

private

   PrüfungEinheit : Boolean;
   PrüfungGrund : Boolean;

   YPosition : GlobaleDatentypen.Kartenfeld;
   XPosition : GlobaleDatentypen.Kartenfeld;

   Wahl : Integer;
   Wahl2 : Integer;
   Wert : Integer;
   Rasse : Integer;
   RassenAusgewählt : Integer;
   SicherheitsTestWert : Integer;
   BenutzerdefinierteGröße : Integer;
   Spieler : Integer;
   Zufallswahl : Integer;

   PositionWert : GlobaleDatentypen.RasseUndPlatznummerRecord;
   GezogeneWerte : GlobaleDatentypen.AchsenAusKartenfeldPositiv;
   KartenWert : GlobaleDatentypen.AchsenAusKartenfeld;
   PlatzBelegt : GlobaleDatentypen.RasseUndPlatznummerRecord;

   type KoordinatenArray is array (1 .. 2) of GlobaleDatentypen.AchsenAusKartenfeld;
   Koordinaten : KoordinatenArray;

   subtype ZufälligeKartengröße is Integer range 1 .. 9;
   subtype ZufälligeKartenart is Integer range 1 .. 3;
   subtype ZufälligeKartentemperatur is Integer range 1 .. 3;
   subtype ZufälligeSpieleranzahl is Integer range GlobaleVariablen.RassenImSpiel'Range;
   subtype ZufälligeRasse is Integer range GlobaleVariablen.RassenImSpiel'Range;

   subtype Rassen is Integer range GlobaleVariablen.RassenImSpiel'Range;

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
   procedure StartpunktFestlegen (RasseExtern : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

   function KartengrößeWählen return Integer;
   function KartenartWählen return Integer;
   function KartentemperaturWählen return Integer;
   function SpieleranzahlWählen return Integer;
   function MenschlicheSpieleranzahl return Integer;
   function RasseWählen return Integer;
   function UmgebungPrüfen (YPosition, XPosition : in GlobaleDatentypen.KartenfeldPositiv; RasseExtern : in Integer) return Boolean
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

end SpielEinstellungen;
