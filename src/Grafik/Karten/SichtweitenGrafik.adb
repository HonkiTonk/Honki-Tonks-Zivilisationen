with StadtKonstanten;
with GrafikRecordKonstanten;
-- with ViewKonstanten;

with LeseWeltkarteneinstellungen;
with LeseCursor;

with CursorbewegungLogik;
with NachGrafiktask;
with FensterGrafik;

package body SichtweitenGrafik is
   
   procedure StandardSichtweiten
   is begin
      
      AktuelleZoomstufe := StandardZoomstufe;
      KartenfelderAbmessungBerechnen;
      
   end StandardSichtweiten;
   
   
   
   procedure ZoomstufeÄndern
     (ÄnderungExtern : in KartenDatentypen.Kartenfeld)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      -- Eine Möglichkeit einbauen das abzustellen? äöü
      -- Eine Möglichkeit einbauen um direkt zu Standardzoomstufe zu springen und nicht zur Kleinsten?
      if
        AktuelleZoomstufe + ÄnderungExtern > MaximaleZoomstufe
      then
         AktuelleZoomstufe := KartenDatentypen.KartenfeldPositiv'First;
         WelcheZoomanpassung := TastenbelegungDatentypen.Ebene_Hoch_Enum;
         
      elsif
        AktuelleZoomstufe + ÄnderungExtern < MinimaleZoomstufe
      then
         AktuelleZoomstufe := MaximaleZoomstufe;
         WelcheZoomanpassung := TastenbelegungDatentypen.Ebene_Runter_Enum;
         
      else
         AktuelleZoomstufe := AktuelleZoomstufe + ÄnderungExtern;
         WelcheZoomanpassung := TastenbelegungDatentypen.Auswählen_Enum;
      end if;
      
      CursorbewegungLogik.CursorbewegungBerechnen (RichtungExtern => WelcheZoomanpassung,
                                                   SpeziesExtern    => NachGrafiktask.AktuelleSpezies);
      
      KartenfelderAbmessungBerechnen;
      
   end ZoomstufeÄndern;
   
   
   
   function SichthöheLesen
     return KartenDatentypen.KartenfeldPositiv
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      return Sichtbereich.YAchse / 2;
      
   end SichthöheLesen;
   
   
   
   function SichtbreiteLesen
     return KartenDatentypen.KartenfeldPositiv
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      return Sichtbereich.XAchse / 2;
      
   end SichtbreiteLesen;
   
   
   
   function SichtbereichLesen
     return KartenRecords.YXAchsenKartenfeldPositivRecord
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      return (Sichtbereich.YAchse / 2, Sichtbereich.XAchse / 2);
      
   end SichtbereichLesen;
   
   
   
   function BewegungshöheLesen
     return KartenDatentypen.KartenfeldPositiv
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      return Bewegungsbereich.YAchse / 2;
      
   end BewegungshöheLesen;
   
   
   
   function BewegungsbreiteLesen
     return KartenDatentypen.KartenfeldPositiv
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      return Bewegungsbereich.XAchse / 2;
      
   end BewegungsbreiteLesen;
   
   
   
   function BewegungsbereichLesen
     return KartenRecords.YXAchsenKartenfeldPositivRecord
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      return (Bewegungsbereich.YAchse / 2, Bewegungsbereich.XAchse / 2);
      
   end BewegungsbereichLesen;
   
   
   
   function UntenRechts
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      Cursor := LeseCursor.KoordinatenAlt (SpeziesExtern => SpeziesExtern);
      
      if
        Cursor.YAchse >= LeseWeltkarteneinstellungen.YAchse - SichthöheLesen
        and
          Cursor.XAchse >= LeseWeltkarteneinstellungen.XAchse - SichtbreiteLesen
      then
         return False;
               
      else
         return True;
      end if;
      
   end UntenRechts;
   
   
   
   procedure KartenfelderAbmessungBerechnen
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      FensterKarte := (0.00, 0.00, FensterGrafik.AktuelleAuflösung.x, FensterGrafik.AktuelleAuflösung.y);
      Sichtbereich.YAchse := AktuelleZoomstufe * 2;
      
      KartenfelderAbmessung.y := FensterKarte.height / Float (Sichtbereich.YAchse + 1);
      KartenfelderAbmessung.x := KartenfelderAbmessung.y / GrafikRecordKonstanten.Kartenbereich.width;
      
      Zwischenspeicher := FensterKarte.width * GrafikRecordKonstanten.Kartenbereich.width;
      
      Sichtbereich.XAchse := 1;
      
      loop
         
         if
           KartenfelderAbmessung.y * Float (Sichtbereich.XAchse + 1) = Zwischenspeicher
         then
            Sichtbereich.XAchse := Sichtbereich.XAchse + 1;
            exit;
            
         elsif
           KartenfelderAbmessung.y * Float (Sichtbereich.XAchse + 1) > Zwischenspeicher
         then
            exit;
            
         else
            Sichtbereich.XAchse := Sichtbereich.XAchse + 1;
         end if;
         
      end loop;
      
      -- KartenfelderAbmessung.x := FensterKarte.width / Float (Sichtbereich.XAchse);
      
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
   
   
   
   procedure StadtumgebungAbmessungBerechnen
   is begin
      
      StadtumgebungAbmessung.y := FensterGrafik.AktuelleAuflösung.y / Float (StadtKonstanten.Stadtkartengröße);
      StadtumgebungAbmessung.x := StadtumgebungAbmessung.y;
      
      StadtumgebungAbmessung.x := FensterGrafik.AktuelleAuflösung.x / Float (StadtKonstanten.Stadtkartengröße);
      StadtumgebungAbmessung.y := FensterGrafik.AktuelleAuflösung.y / Float (StadtKonstanten.Stadtkartengröße);
      
   end StadtumgebungAbmessungBerechnen;
   
   
   
   function Kartenfeldfläche
     return Sf.System.Vector2.sfVector2f
   is begin
      
      return KartenfelderAbmessung;
      
   end Kartenfeldfläche;
   
   
   
   function Stadtumgebungsfläche
     return Sf.System.Vector2.sfVector2f
   is begin
      
      return StadtumgebungAbmessung;
      
   end Stadtumgebungsfläche;
   
   
   
   -- Warum ist FensterKarte ein Rect und kein Vector? äöü
   function Kartenfläche
     return Sf.Graphics.Rect.sfFloatRect
   is begin
      
      return FensterKarte;
      
   end Kartenfläche;

end SichtweitenGrafik;
