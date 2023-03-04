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
    -- (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
    --  EinheitExtern : in EinheitenRecords.EinheitenGebautRecord)
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      CursorplatzierungGrafik.Weltkarte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      CursorplatzierungAltGrafik.CursorplatzierungAlt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      WeltkarteGrafik.WeltkarteAnzeigen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        EinheitSpeziesNummerExtern.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            RechtsLinksBefehlsanzeige := SichtweitenGrafik.UntenRechts (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
            
         when others =>
            Position := KoordinatenPositionUmwandlungen.KoordinatenZuKartenposition (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                                                     SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies);
            Viewgröße := Sf.Graphics.View.getSize (view => Views.WeltkarteAccess (ViewKonstanten.WeltKarte));
            
            if
              Position.y >= Viewgröße.y / 2.00
              and
                Position.x >= Viewgröße.x / 1.50
            then
               RechtsLinksBefehlsanzeige := False;
               
            else
               RechtsLinksBefehlsanzeige := True;
            end if;
            
            WeltkartenbefehleGrafik.Einheitenbefehle (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                      RechtsLinksExtern          => RechtsLinksBefehlsanzeige);
      end case;
         
      SeitenleisteGrafik.SeitenleisteGrafik (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      
      WeltkartenbefehleGrafik.Kartenbefehle (RechtsLinksExtern => RechtsLinksBefehlsanzeige);
      
   end Weltkarte;
   
   

   procedure Stadtkarte
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      case
        NachGrafiktask.Stadtkarte
      is
         when True =>
            StadtkarteGrafik.Stadtkarte (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
         when False =>
            StadtumgebungGrafik.Stadtumgebung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            StadtseitenleisteGrafik.Stadtinformationen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            StadtbefehleGrafik.Stadtbefehle;
      end case;
      
   end Stadtkarte;

end KartenaufteilungGrafik;
