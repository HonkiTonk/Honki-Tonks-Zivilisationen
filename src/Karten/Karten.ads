with GlobaleDatentypen;
use GlobaleDatentypen;

package Karten is

   type SichtbarkeitArray is array (GlobaleDatentypen.RassenImSpielArray'Range) of Boolean;

   type KartenRecord is record

      Grund : GlobaleDatentypen.KartenGrund;
      Hügel : Boolean;
      Sichtbar : SichtbarkeitArray;
      Fluss : GlobaleDatentypen.KartenGrund;
      VerbesserungStraße : GlobaleDatentypen.KartenVerbesserung;
      VerbesserungGebiet : GlobaleDatentypen.KartenVerbesserung;
      Ressource : GlobaleDatentypen.KartenGrund;
      DurchStadtBelegterGrund : GlobaleDatentypen.BelegterGrund;
      Felderwertung : GlobaleDatentypen.GesamtproduktionStadt;

      -- Sichtbar2
      -- VerbesserungStraße2
      -- VerbesserungGebiet2
      -- Noch mehr?

   end record;

   type KartenArray is array (GlobaleDatentypen.EbeneVorhanden'Range, GlobaleDatentypen.KartenfeldPositiv'Range, GlobaleDatentypen.KartenfeldPositiv'Range) of KartenRecord;
   Karten : KartenArray := (others => (others => (others => (0, False, (others => False), 0, 0, 0, 0, 0, 0))));

   type StadtkarteArray is array (GlobaleDatentypen.Stadtfeld'Range, GlobaleDatentypen.Stadtfeld'Range) of Integer;
   Stadtkarte : StadtkarteArray := (others => (others => (0)));

   type KartengrößenRecord is record

      YAchsenGröße : GlobaleDatentypen.KartenfeldPositiv;
      XAchsenGröße : GlobaleDatentypen.KartenfeldPositiv;
      Ressourcenmenge : Natural;

   end record;

   type KartengrößenArray is array (1 .. 10) of KartengrößenRecord;
   Kartengrößen : KartengrößenArray := ((20, 20, 12), (40, 40, 50), (80, 80, 200), (120, 80, 300), (120, 160, 600), (160, 160, 800), (240, 240, 1_800), (320, 320, 3200), (1_000, 1_000, 31_250), (1, 1, 1));
   -- In Speichern wird der neunte Kartenwert genutzt, bei eventuellen Änderungen berücksichtigen um das Speichersystem nicht zu killen.

   Kartengröße : Integer := 1;

end Karten;
