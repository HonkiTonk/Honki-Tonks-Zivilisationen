pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Karte, EinheitSuchen, KartePositionPruefen, Eingabe, BewegungPassierbarkeitPruefen, BewegungBerechnen, EinheitenAllgemein, Diplomatie, BewegungLadenEntladen, Kampfsystem;

package body BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummerExtern.Rasse);

      BewegenSchleife:
      loop
         
         case
           Eingabe.Tastenwert
         is
            when GlobaleDatentypen.Hoch =>
               Änderung := (0, -1, 0);
            
            when GlobaleDatentypen.Links =>
               Änderung := (0, 0, -1);
            
            when GlobaleDatentypen.Runter =>
               Änderung := (0, 1, 0);
            
            when GlobaleDatentypen.Rechts  =>
               Änderung := (0, 0, 1);
            
            when GlobaleDatentypen.Links_Oben =>
               Änderung := (0, -1, -1);
            
            when GlobaleDatentypen.Rechts_Oben =>
               Änderung := (0, -1, 1);
            
            when GlobaleDatentypen.Links_Unten =>
               Änderung := (0, 1, -1);

            when GlobaleDatentypen.Rechts_Unten =>
               Änderung := (0, 1, 1);
            
            when GlobaleDatentypen.Ebene_Hoch =>
               Änderung := (1, 0, 0);
            
            when GlobaleDatentypen.Ebene_Runter =>
               Änderung := (-1, 0, 0);
            
            when others =>
               return;
         end case;
         
         KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                     ÄnderungExtern       => Änderung);
         
         case
           KartenWert.XAchse
         is               
            when GlobaleKonstanten.LeerYXKartenWert =>
               AktuellerStatus := Bewegbar;               
               
            when others =>
               AktuellerStatus := BewegungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   NeuePositionExtern       => KartenWert);
         end case;
         
         case
           AktuellerStatus
         is
            when Bewegbar =>
               null;
               
            when Zurück =>
               return;
         end case;

         Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummerExtern.Rasse);
         
      end loop BewegenSchleife;
      
   end BewegungEinheitenRichtung;
   
   
   
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Bewegung_Noch_Möglich_Enum
   is begin
      
      FeldPassierbar := BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                   NeuePositionExtern       => NeuePositionExtern);
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeuePositionExtern);
      BewegungDurchführen := False;
      
      if
        FeldPassierbar = False
        and
          EinheitAufFeld.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
      then
         return Bewegbar;
         
      elsif
        EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
        and then
          EinheitenAllgemein.KannTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                      TransporterExtern => EinheitAufFeld) = False
      then
         return Bewegbar;
         
      elsif
        EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
        and then
          EinheitenAllgemein.KannTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                      TransporterExtern => EinheitAufFeld) = True
      then
         EigeneEinheitAufFeld (BewegendeEinheitExtern     => EinheitRasseNummerExtern,
                               FeldBelegendeEinheitExtern => EinheitAufFeld);
         
      elsif
        EinheitAufFeld.Rasse /= EinheitRasseNummerExtern.Rasse
        and
          EinheitAufFeld.Rasse /= GlobaleDatentypen.Leer
      then
         if
           FremderAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                           FremdeEinheitExtern      => EinheitAufFeld) = True
           and
             FeldPassierbar
         then
            BewegungDurchführen := True;
            
         else
            null;
         end if;
         
      else
         BewegungDurchführen := True;
      end if;
      
      case
        BewegungDurchführen
      is
         when True =>
            BewegungBerechnen.BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           NeuePositionExtern       => NeuePositionExtern);
            
         when False =>
            null;
      end case;
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte <= GlobaleKonstanten.LeerEinheit.Bewegungspunkte
        or
          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte = GlobaleKonstanten.LeerEinheit.Lebenspunkte
      then
         return Zurück;
            
      else      
         return Bewegbar;
      end if;
      
   end BewegungPrüfen;
   
   
   
   function FremderAufFeld
     (EinheitRasseNummerExtern, FremdeEinheitExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
            
      case
        Diplomatie.GegnerAngreifen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                    GegnerExtern             => FremdeEinheitExtern)
      is
         when True =>
            if
              Kampfsystem.KampfsystemNahkampf (AngreiferRasseNummerExtern   => EinheitRasseNummerExtern,
                                               VerteidigerRasseNummerExtern => FremdeEinheitExtern) = True
            then
               return True;
               
            else
               null;
            end if;
            
         when False =>
            null;
      end case;
      
      return False;
      
   end FremderAufFeld;
   
   
   
   -- Hier vielleicht später mehr einbauen? Beispielsweise Plätzetauschen?
   procedure EigeneEinheitAufFeld
     (BewegendeEinheitExtern, FeldBelegendeEinheitExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      BewegungLadenEntladen.TransporterBeladen (TransporterExtern => FeldBelegendeEinheitExtern,
                                                LadungExtern      => BewegendeEinheitExtern.Platznummer);
      
   end EigeneEinheitAufFeld;

end BewegungssystemEinheiten;
