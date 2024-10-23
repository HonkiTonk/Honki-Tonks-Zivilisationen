with StadtKonstanten;

with LeseWeltkarteneinstellungen;
with LeseCursor;
with LeseGrafiktask;

with CursorbewegungLogik;
with FensterGrafik;

package body SichtweitenGrafik is
   
   procedure StandardSichtweiten
   is begin
      
      AktuelleYZoomstufe := StandardYZoomstufe;
      KartenfelderAbmessungBerechnen;
      
   end StandardSichtweiten;
   
   
   
   procedure ZoomstufeÄndern
     (ÄnderungExtern : in KartenDatentypen.Senkrechte)
   is
      use type KartenDatentypen.Senkrechte;
   begin
      
      -- Eine Möglichkeit einbauen das abzustellen? äöü
      -- Eine Möglichkeit einbauen um direkt zu StandardYZoomstufe zu springen und nicht zur Kleinsten? äöü
      if
        AktuelleYZoomstufe + ÄnderungExtern > MaximaleYZoomstufe
      then
         AktuelleYZoomstufe := MinimaleYZoomstufe;
         WelcheZoomanpassung := TastenbelegungDatentypen.Ebene_Hoch_Enum;
         
      elsif
        AktuelleYZoomstufe + ÄnderungExtern < MinimaleYZoomstufe
      then
         AktuelleYZoomstufe := MaximaleYZoomstufe;
         WelcheZoomanpassung := TastenbelegungDatentypen.Ebene_Runter_Enum;
         
      else
         AktuelleYZoomstufe := AktuelleYZoomstufe + ÄnderungExtern;
         WelcheZoomanpassung := TastenbelegungDatentypen.Auswählen_Enum;
      end if;
      
      CursorbewegungLogik.CursorbewegungBerechnen (RichtungExtern => WelcheZoomanpassung,
                                                   SpeziesExtern    => LeseGrafiktask.AktiveSpezies);
      
      KartenfelderAbmessungBerechnen;
      
   end ZoomstufeÄndern;
   
   
   
   function SichthöheLesen
     return KartenDatentypen.SenkrechtePositiv
   is
      use type KartenDatentypen.Senkrechte;
   begin
      
      return Sichtbereich.Senkrechte / 2;
      
   end SichthöheLesen;
   
   
   
   function SichtbreiteLesen
     return KartenDatentypen.WaagerechtePositiv
   is
      use type KartenDatentypen.Waagerechte;
   begin
      
      return Sichtbereich.Waagerechte / 2;
      
   end SichtbreiteLesen;
   
   
   
   function SichtbereichLesen
     return KartenRecords.KartenfeldumgebungPositivRecord
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      return (Sichtbereich.Senkrechte / 2, Sichtbereich.Waagerechte / 2);
      
   end SichtbereichLesen;
   
   
   
   function BewegungshöheLesen
     return KartenDatentypen.SenkrechtePositiv
   is
      use type KartenDatentypen.Senkrechte;
   begin
      
      return Bewegungsbereich.Senkrechte / 2;
      
   end BewegungshöheLesen;
   
   
   
   function BewegungsbreiteLesen
     return KartenDatentypen.WaagerechtePositiv
   is
      use type KartenDatentypen.Waagerechte;
   begin
      
      return Bewegungsbereich.Waagerechte / 2;
      
   end BewegungsbreiteLesen;
   
   
   
   function BewegungsbereichLesen
     return KartenRecords.KartenfeldumgebungPositivRecord
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      return (Bewegungsbereich.Senkrechte / 2, Bewegungsbereich.Waagerechte / 2);
      
   end BewegungsbereichLesen;
   
   
   
   function UntenRechts
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      Cursor := LeseCursor.KoordinatenAlt (SpeziesExtern => SpeziesExtern);
      
      if
        Cursor.Senkrechte >= LeseWeltkarteneinstellungen.Senkrechte - SichthöheLesen
        and
          Cursor.Waagerechte >= LeseWeltkarteneinstellungen.Waagerechte - SichtbreiteLesen
      then
         return False;
               
      else
         return True;
      end if;
      
   end UntenRechts;
   
   
   
   procedure KartenfelderAbmessungBerechnen
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      FensterKarte := FensterGrafik.AktuelleAuflösung;
      Sichtbereich.Senkrechte := AktuelleYZoomstufe * 2 + 1;
      Sichtbereich.Waagerechte := AktuelleXZoomstufe * 2 + 1;
      
      KartenfelderAbmessung.y := FensterKarte.y / Float (Sichtbereich.Senkrechte);
      KartenfelderAbmessung.x := FensterGrafik.AktuelleAuflösung.x / Float (Sichtbereich.Waagerechte);
      
      Bewegungsbereich.Senkrechte := Sichtbereich.Senkrechte - 1;
      Bewegungsbereich.Waagerechte := Sichtbereich.Waagerechte - 1;
      
   end KartenfelderAbmessungBerechnen;
   
   
   
   procedure StadtumgebungAbmessungBerechnen
   is begin
      
      -- StadtumgebungAbmessung.y := FensterGrafik.AktuelleAuflösung.y / Float (StadtKonstanten.Stadtkartengröße);
      -- StadtumgebungAbmessung.x := StadtumgebungAbmessung.y;
      
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
     return Sf.System.Vector2.sfVector2f
   is begin
      
      return FensterKarte;
      
   end Kartenfläche;

end SichtweitenGrafik;
