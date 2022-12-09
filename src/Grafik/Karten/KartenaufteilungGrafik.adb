with Sf.Graphics.View;

with EinheitenKonstanten;
with Views;
with ViewKonstanten;

with LeseEinheitenGebaut;

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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      CursorplatzierungGrafik.Weltkarte (RasseExtern => EinheitRasseNummerExtern.Rasse);
      CursorplatzierungAltGrafik.CursorplatzierungAlt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Von außen die Arraypositionen für die Bereiche/Views hineingeben? äöü
      WeltkarteGrafik.WeltkarteAnzeigen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        EinheitRasseNummerExtern.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            RechtsLinksBefehlsanzeige := SichtweitenGrafik.UntenRechts (RasseExtern => EinheitRasseNummerExtern.Rasse);
            
         when others =>
            Position := KoordinatenPositionUmwandlungen.KoordinatenZuKartenposition (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                     RasseExtern       => EinheitRasseNummerExtern.Rasse);
            
            if
              Position.y >= Sf.Graphics.View.getSize (view => Views.WeltkarteAccess (ViewKonstanten.WeltKarte)).y / 2.00
              and
                Position.x >= Sf.Graphics.View.getSize (view => Views.WeltkarteAccess (ViewKonstanten.WeltKarte)).x / 1.50
            then
               RechtsLinksBefehlsanzeige := False;
               
            else
               RechtsLinksBefehlsanzeige := True;
            end if;
            
            WeltkartenbefehleGrafik.Einheitenbefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      RechtsLinksExtern        => RechtsLinksBefehlsanzeige);
      end case;
         
      SeitenleisteGrafik.SeitenleisteGrafik (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      WeltkartenbefehleGrafik.Kartenbefehle (RechtsLinksExtern => RechtsLinksBefehlsanzeige);
      
   end Weltkarte;
   
   

   procedure Stadtkarte
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      case
        NachGrafiktask.Stadtkarte
      is
         when True =>
            StadtkarteGrafik.Stadtkarte (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
         when False =>
            StadtumgebungGrafik.Stadtumgebung (StadtRasseNummerExtern => StadtRasseNummerExtern);
            StadtseitenleisteGrafik.Stadtinformationen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            StadtbefehleGrafik.Stadtbefehle;
      end case;
      
   end Stadtkarte;

end KartenaufteilungGrafik;
