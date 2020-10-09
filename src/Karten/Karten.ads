package Karten is

   type KartenRecord is record

      Grund : Integer;
      Hügel : Boolean;
      Sichtbar : Boolean;
      Fluss : Integer;
      VerbesserungStraße : Integer;
      VerbesserungGebiet : Integer;
      Ressource : Integer;

      GeneratorKarte : Integer;

   end record;

   type KartenArray is array (1 .. 1_000, 1 .. 1_000) of KartenRecord;
   -- Winzig = 20 x 20, Klein = 40 x 40, Mittel = 80 x 80, Rechteck = 120 x 80, Großes Rechteck = 120 x 160, Groß = 160 x 160, Riesig = 240 x 240, Gigantisch = 320 x 320, Absurd = 1_000 x 1_000, Absurder =
   -- 10_000 x 10_000 (Computer sagt nein)
   Karten : KartenArray := (others => (others => (0, False, True, 0, 0, 0, 0, 0))); -- Sichtbarkeit später wieder auf False setzen, steht zum testen auf True

   type StadtkarteArray is array (1 .. 20, 1 .. 20) of Integer;
   Stadtkarte : StadtkarteArray := (others => (others => (0)));

   type KartengrößenRecord is record

      YAchsenGröße : Integer;
      XAchsenGröße : Integer;
      Ressourcenmenge : Integer;

   end record;

   type KartengrößenArray is array (1 .. 9) of KartengrößenRecord;
   Kartengrößen : KartengrößenArray := ((20, 20, 12), (40, 40, 50), (80, 80, 200), (120, 80, 300), (120, 160, 600), (160, 160, 800), (240, 240, 1_800), (320, 320, 3200), (1_000, 1_000, 31_250));
   -- In Speichern wird der neunte Kartenwert genutzt, bei eventuellen Änderungen berücksichtigen um das Speichersystem nicht zu killen.

   Kartengröße : Integer := 1;

end Karten;
