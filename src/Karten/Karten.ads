package Karten is

   type KartenRecord is record

      Grund : Integer;
      Hügel : Boolean;
      Sichtbar : Boolean;
      Fluss : Integer;
      VerbesserungStraße : Integer;
      VerbesserungGebiet : Integer;
      Ressource : Integer;

   end record;

   type KartenArray is array (1 .. 1000, 1 .. 1000) of KartenRecord;
   -- Winzig = 20x20, Klein = 40x40, Mittel = 80x80, Rechteck = 120x80, Großes Rechteck = 120x160, Groß = 160x160, Riesig = 240x240, Gigantisch = 320x320, Absurd = 1000x1000
   Karten : KartenArray := (others => (others => (-2, False, True, 0, 0, 0, 0))); -- Sichtbarkeit später wieder auf False setzen, steht zum testen auf True

   type StadtkarteArray is array (1 .. 20, 1 .. 20) of Integer;
   Stadtkarte : StadtkarteArray := (others => (others => (0)));

   type KartengrößenRecord is record

      YAchsenGröße : Integer;
      XAchsenGröße : Integer;
      Ressourcenmenge : Integer;

   end record;

   type KartengrößenArray is array (1 .. 9) of KartengrößenRecord;
   Kartengrößen : KartengrößenArray := ((20, 20, 12), (40, 40, 50), (80, 80, 200), (120, 80, 300), (120, 160, 600), (160, 160, 800), (240, 240, 1800), (320, 320, 3200), (1000, 1000, 31250));

   Kartengröße : Integer := 1;

end Karten;
