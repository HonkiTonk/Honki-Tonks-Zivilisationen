with Sf.Graphics.View;

with EinheitenKonstanten;
with Views;
with ViewKonstanten;
with GrafikKonstanten;

with LeseEinheitenDatenbank;

with ZeigerplatzierungGrafik;
with ZeigerplatzierungAltGrafik;
with WeltkarteGrafik;
with SeitenleisteGrafik;
with StadtseitenleisteGrafik;
with StadtumgebungGrafik;
with StadtbefehleGrafik;
with WeltkartenbefehleGrafik;
with UmwandlungenGrafik;
with SichtweitenGrafik;
with StadtkarteGrafik;

package body KartenaufteilungGrafik is
   
   procedure Weltkarte
     (EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord)
   is begin
            
      ZeigerplatzierungGrafik.Weltkarte (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies);
      ZeigerplatzierungAltGrafik.ZeigerplatzierungAlt (EinheitSpeziesNummerExtern => EinheitenauswahlExtern.SpeziesNummer,
                                                       EinheitenkoordinatenExtern => EinheitenauswahlExtern.Koordinaten);
      
      WeltkarteGrafik.WeltkarteAnzeigen (EinheitenauswahlExtern => EinheitenauswahlExtern);
      
      case
        EinheitenauswahlExtern.SpeziesNummer.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            RechtsLinksBefehlsanzeige := SichtweitenGrafik.UntenRechts (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies);
            
         when others =>
            Position := UmwandlungenGrafik.KoordinatenKartenposition (KoordinatenExtern => EinheitenauswahlExtern.Koordinaten,
                                                                                   SpeziesExtern     => EinheitenauswahlExtern.SpeziesNummer.Spezies);
            Viewgröße := Sf.Graphics.View.getSize (view => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte));
            
            if
              Position.y >= Viewgröße.y / GrafikKonstanten.Halbierung
              and
                Position.x >= Viewgröße.x / 1.50
            then
               RechtsLinksBefehlsanzeige := False;
               
            else
               RechtsLinksBefehlsanzeige := True;
            end if;
            
            WeltkartenbefehleGrafik.Einheitenbefehle (EinheitartExtern  => LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies,
                                                                                                                IDExtern      => EinheitenauswahlExtern.ID),
                                                      RechtsLinksExtern => RechtsLinksBefehlsanzeige);
      end case;
         
      SeitenleisteGrafik.SeitenleisteGrafik (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies);
      
      WeltkartenbefehleGrafik.Kartenbefehle (RechtsLinksExtern => RechtsLinksBefehlsanzeige);
      
   end Weltkarte;
   
   

   procedure Stadtkarte
     (StadtauswahlExtern : in StadtGrafikRecords.StadtGrafikRecord;
      AnzeigeExtern : in GrafikDatentypen.Stadt_Enum)
   is begin
      
      case
        AnzeigeExtern
      is
         when GrafikDatentypen.Stadtumgebung_Enum =>
            StadtumgebungGrafik.Stadtumgebung (StadtauswahlExtern => (StadtauswahlExtern.SpeziesNummer, StadtauswahlExtern.Koordinaten, StadtauswahlExtern.UmgebungBewirtschaftung));
            StadtseitenleisteGrafik.Stadtinformationen (StadtauswahlExtern => StadtauswahlExtern);
            StadtbefehleGrafik.Stadtbefehle;
            
         when GrafikDatentypen.Stadtkarte_Enum =>
            StadtkarteGrafik.Stadtkarte (StadtauswahlExtern => (StadtauswahlExtern.SpeziesNummer.Spezies, StadtauswahlExtern.Koordinaten, StadtauswahlExtern.GebäudeVorhanden));
      end case;
      
   end Stadtkarte;

end KartenaufteilungGrafik;
