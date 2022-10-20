pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.View;

with EinheitenKonstanten;
with Views;

with LeseEinheitenGebaut;

with StadtkarteGrafik;
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
              Position.y >= Sf.Graphics.View.getSize (view => Views.KartenviewAccess).y / 2.00
              and
                Position.x >= Sf.Graphics.View.getSize (view => Views.KartenviewAccess).x / 1.50
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
      
      -- Von außen die Arraypositionen für die Bereiche/Views hineingeben? äöü
      StadtkarteGrafik.Stadtkarte (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtumgebungGrafik.Stadtumgebung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      StadtbefehleGrafik.Stadtbefehle;
      StadtseitenleisteGrafik.Stadtinformationen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
   end Stadtkarte;

end KartenaufteilungGrafik;
