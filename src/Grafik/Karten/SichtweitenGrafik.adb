with StadtKonstanten;

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
      
      return AktuelleZoomstufe * 2;
      
   end SichthöheLesen;
   
   
   
   function SichtbreiteLesen
     return KartenDatentypen.KartenfeldPositiv
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      return AktuelleZoomstufe * 2;
      
   end SichtbreiteLesen;
   
   

   function SichtweiteLesen
     return KartenDatentypen.KartenfeldPositiv
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      return AktuelleZoomstufe * 2;
            
   end SichtweiteLesen;
   
   
   
   function BewegungshöheLesen
     return KartenDatentypen.KartenfeldPositiv
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      return SichthöheLesen -1;
      
   end BewegungshöheLesen;
   
   
   
   function BewegungsbreiteLesen
     return KartenDatentypen.KartenfeldPositiv
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      return SichtbreiteLesen -1;
      
   end BewegungsbreiteLesen;
   
   

   function BewegungsfeldLesen
     return KartenDatentypen.KartenfeldPositiv
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      return SichtweiteLesen - 1;
      
   end BewegungsfeldLesen;
   
   
   
   function UntenRechts
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      Cursor := LeseCursor.KoordinatenAlt (SpeziesExtern => SpeziesExtern);
      
      if
        Cursor.YAchse >= LeseWeltkarteneinstellungen.YAchse - SichtweiteLesen
        and
          Cursor.XAchse >= LeseWeltkarteneinstellungen.XAchse - SichtweiteLesen
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
      
      KartenfelderAbmessung.y := FensterKarte.height / Float (2 * SichthöheLesen + 1);
      KartenfelderAbmessung.x := KartenfelderAbmessung.y;
      
      KartenfelderAbmessung.x := FensterKarte.width / Float (2 * SichtweiteLesen + 1);
      KartenfelderAbmessung.y := FensterKarte.height / Float (2 * SichtweiteLesen + 1);
            
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
   
   
   
   function Kartenfläche
     return Sf.Graphics.Rect.sfFloatRect
   is begin
      
      return FensterKarte;
      
   end Kartenfläche;

end SichtweitenGrafik;
