with Sf.Graphics.View;

with EinheitenKonstanten;
with Views;
with ViewKonstanten;
with GrafikKonstanten;

with CursorplatzierungGrafik;
with CursorplatzierungAltGrafik;
with WeltkarteGrafik;
with SeitenleisteGrafik;
with StadtseitenleisteGrafik;
with StadtumgebungGrafik;
with StadtbefehleGrafik;
with WeltkartenbefehleGrafik;
with KoordinatenPositionUmwandlungen;
with SichtweitenGrafik;
with StadtkarteGrafik;
with NachGrafiktask;

package body KartenaufteilungGrafik is
   
   procedure Weltkarte
     (EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord)
   is begin
            
      CursorplatzierungGrafik.Weltkarte (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies);
      CursorplatzierungAltGrafik.CursorplatzierungAlt (EinheitSpeziesNummerExtern => EinheitenauswahlExtern.SpeziesNummer,
                                                       EinheitenkoordinatenExtern => EinheitenauswahlExtern.Koordinaten);
      
      WeltkarteGrafik.WeltkarteAnzeigen (EinheitenauswahlExtern => EinheitenauswahlExtern);
      
      case
        EinheitenauswahlExtern.SpeziesNummer.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            RechtsLinksBefehlsanzeige := SichtweitenGrafik.UntenRechts (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies);
            
         when others =>
            Position := KoordinatenPositionUmwandlungen.KoordinatenZuKartenposition (KoordinatenExtern => EinheitenauswahlExtern.Koordinaten,
                                                                                     SpeziesExtern     => EinheitenauswahlExtern.SpeziesNummer.Spezies);
            Viewgröße := Sf.Graphics.View.getSize (view => Views.WeltkarteAccess (ViewKonstanten.WeltKarte));
            
            if
              Position.y >= Viewgröße.y / GrafikKonstanten.Halbierung
              and
                Position.x >= Viewgröße.x / 1.50
            then
               RechtsLinksBefehlsanzeige := False;
               
            else
               RechtsLinksBefehlsanzeige := True;
            end if;
            
            -- Hier eventuell direkt die Einheitenart übergeben? äöü
            WeltkartenbefehleGrafik.Einheitenbefehle (SpeziesExtern     => EinheitenauswahlExtern.SpeziesNummer.Spezies,
                                                      IDExtern          => EinheitenauswahlExtern.ID,
                                                      RechtsLinksExtern => RechtsLinksBefehlsanzeige);
      end case;
         
      SeitenleisteGrafik.SeitenleisteGrafik (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies);
      
      WeltkartenbefehleGrafik.Kartenbefehle (RechtsLinksExtern => RechtsLinksBefehlsanzeige);
      
   end Weltkarte;
   
   

   procedure Stadtkarte
     (StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord)
   is begin
      
      case
        NachGrafiktask.Stadtkarte
      is
         when True =>
            StadtkarteGrafik.Stadtkarte (StadtauswahlExtern => (StadtauswahlExtern.SpeziesNummer.Spezies, StadtauswahlExtern.Koordinaten, StadtauswahlExtern.GebäudeVorhanden));
      
         when False =>
            StadtumgebungGrafik.Stadtumgebung (StadtauswahlExtern => (StadtauswahlExtern.SpeziesNummer, StadtauswahlExtern.Koordinaten, StadtauswahlExtern.UmgebungBewirtschaftung));
            StadtseitenleisteGrafik.Stadtinformationen (StadtauswahlExtern => StadtauswahlExtern);
            StadtbefehleGrafik.Stadtbefehle;
      end case;
      
   end Stadtkarte;

end KartenaufteilungGrafik;
