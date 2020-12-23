with GlobaleDatentypen;

package Karten is

   type KartenRecord is record

      Grund : GlobaleDatentypen.KartenGrund;
      Hügel : Boolean;
      Sichtbar : Boolean;
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

   type KartenArray is array (GlobaleDatentypen.Ebene'Range, 1 .. GlobaleDatentypen.Kartenfeld'Last, 1 .. GlobaleDatentypen.Kartenfeld'Last) of KartenRecord;
   Karten : KartenArray := (others => (others => (others => (0, False, False, 0, 0, 0, 0, 0, 0))));

   type StadtkarteArray is array (GlobaleDatentypen.Stadtfeld'Range, GlobaleDatentypen.Stadtfeld'Range) of Integer;
   Stadtkarte : StadtkarteArray := (others => (others => (0)));

   type KartengrößenRecord is record

      YAchsenGröße : GlobaleDatentypen.Kartenfeld;
      XAchsenGröße : GlobaleDatentypen.Kartenfeld;
      Ressourcenmenge : Integer;

   end record;

   type KartengrößenArray is array (1 .. 9) of KartengrößenRecord;
   Kartengrößen : constant KartengrößenArray := ((20, 20, 12), (40, 40, 50), (80, 80, 200), (120, 80, 300), (120, 160, 600), (160, 160, 800), (240, 240, 1_800), (320, 320, 3200), (1_000, 1_000, 31_250));
   -- In Speichern wird der neunte Kartenwert genutzt, bei eventuellen Änderungen berücksichtigen um das Speichersystem nicht zu killen.

   Kartengröße : Integer := 1;

end Karten;
