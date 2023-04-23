procedure KartenfelderAbmessungBerechnen
is
   use type KartenDatentypen.Kartenfeld;
begin

   FensterKarte := (0.00, 0.00, FensterGrafik.AktuelleAuflösung.x, FensterGrafik.AktuelleAuflösung.y);
   Sichtbereich.YAchse := AktuelleZoomstufe * 2;

   KartenfelderAbmessung.y := FensterKarte.height / Float (Sichtbereich.YAchse + 1);
   KartenfelderAbmessung.x := KartenfelderAbmessung.y; --  / 0.80; -- GrafikRecordKonstanten.Kartenbereich.width;

   --  if
   --   KartenfelderAbmessung.x = 0.00
   --  then
   --     Sichtbereich.XAchse := AktuelleZoomstufe * 2;
   --
   -- elsif
   --    FensterKarte.width / KartenfelderAbmessung.x < 2.00
   -- then
   --    Sichtbereich.XAchse := AktuelleZoomstufe * 2;

   --  elsif
   --   Positive (KartenDatentypen.KartenfeldPositiv'Last) < Positive (FensterKarte.width / KartenfelderAbmessung.x)
   --  then
   --    Sichtbereich.XAchse := KartenDatentypen.KartenfeldPositiv'Last;

   -- else
   --    Sichtbereich.XAchse := KartenDatentypen.KartenfeldPositiv (FensterKarte.width / KartenfelderAbmessung.x);
   --  end if;

   Sichtbereich.XAchse := KartenDatentypen.KartenfeldPositiv (0.80 * ((FensterKarte.width / FensterKarte.height) * Float (Sichtbereich.YAchse)));
   KartenfelderAbmessung.x := FensterGrafik.AktuelleAuflösung.x / (Float (Sichtbereich.XAchse) + 1.00);

   Sichtbereich.XAchse := Sichtbereich.XAchse + 1;

   --  Sichtbereich.XAchse := KartenDatentypen.KartenfeldPositiv (0.80 * ((FensterKarte.width / FensterKarte.height) * Float (Sichtbereich.YAchse))) + 1;
   --  GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltKarte).width := Float (Sichtbereich.XAchse) * KartenfelderAbmessung.x / FensterGrafik.AktuelleAuflösung.x;

   -- GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltWichtiges).left := GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltKarte).width;
   -- GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltAllgemeines).left := GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltKarte).width;
   -- GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltStadt).left := GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltKarte).width;
   --  GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltEinheit).left := GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltKarte).width;

   -- GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltWichtiges).width := 1.00 - GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltKarte).width;
   --  GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltAllgemeines).width := 1.00 - GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltKarte).width;
   --  GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltStadt).width := 1.00 - GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltKarte).width;
   -- GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltEinheit).width := 1.00 - GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltKarte).width;

   Bewegungsbereich.YAchse := Sichtbereich.YAchse - 1;
   Bewegungsbereich.XAchse := Sichtbereich.XAchse - 1;

end KartenfelderAbmessungBerechnen;
