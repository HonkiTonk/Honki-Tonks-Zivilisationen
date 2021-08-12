pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Karte, EinheitSuchen, KartePositionPruefen, Eingabe, BewegungPassierbarkeitPruefen, BewegungBerechnen, EinheitenAllgemein, DiplomatischerZustand, BewegungLadenEntladen, Kampfsystem, StadtSuchen, StadtEntfernen,
     StadtBauen, Verbesserungen;

package body BewegungssystemEinheiten is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummerExtern.Rasse);

      BewegenSchleife:
      loop
         
         Befehl := Eingabe.Tastenwert;
         
         case
           Befehl
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
               
            when GlobaleDatentypen.Heimatstadt_Ändern =>
               EinheitenAllgemein.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               Änderung := KeineÄnderung;
               
            when GlobaleDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range | GlobaleDatentypen.Tastenbelegung_Allgemeine_Befehle_Enum'Range =>
               AufgabeDurchführen := Verbesserungen.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                          BefehlExtern             => Befehl);
               
               case
                 AufgabeDurchführen
               is
                  when True =>
                     return;
               
                  when False =>
                     Änderung := KeineÄnderung;
                     -- Hier Meldung einbauen
               end case;
               
            when GlobaleDatentypen.Bauen =>
               StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               Änderung := KeineÄnderung;
            
            when others =>
               return;
         end case;
         
         if
           Änderung = KeineÄnderung
         then
            AktuellerStatus := NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         else
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                        ÄnderungExtern    => Änderung);
         
            case
              KartenWert.XAchse
            is               
               when GlobaleKonstanten.LeerYXKartenWert =>
                  AktuellerStatus := Bewegbar;               
               
               when others =>
                  AktuellerStatus := BewegungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      NeuePositionExtern       => KartenWert);
            end case;
         end if;
         
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
      StadtAufFeld := StadtSuchen.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                            KoordinatenExtern => NeuePositionExtern);
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
         
      elsif
        StadtAufFeld.Platznummer /= GlobaleKonstanten.LeerEinheitStadtNummer
        and
          FeldPassierbar
      then
         case
           FremdeStadtAufFeld (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                               FremdeStadtExtern => StadtAufFeld)
         is
            when False =>
               null;
               
            when True =>
               BewegungDurchführen := True;
         end case;
         
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
      
      return NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end BewegungPrüfen;
   
   
   
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Bewegung_Noch_Möglich_Enum
   is begin
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte <= GlobaleKonstanten.LeerEinheit.Bewegungspunkte
        or
          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte = GlobaleKonstanten.LeerEinheit.Lebenspunkte
      then
         return Zurück;
            
      else      
         return Bewegbar;
      end if;
      
   end NochBewegungspunkte;
   
   
   
   function FremderAufFeld
     (EinheitRasseNummerExtern, FremdeEinheitExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
            
      case
        DiplomatischerZustand.GegnerAngreifen (EigeneRasseExtern      => EinheitRasseNummerExtern.Rasse,
                                               GegnerischeRasseExtern => FremdeEinheitExtern.Rasse)
      is
         when True =>
            if
              Kampfsystem.KampfsystemNahkampf (AngreiferRasseNummerExtern   => EinheitRasseNummerExtern,
                                               VerteidigerRasseNummerExtern => FremdeEinheitExtern) = True
            then
               case
                 StadtAufFeld.Platznummer
               is
                  when GlobaleKonstanten.LeerEinheitStadtNummer =>
                     return True;
                     
                  when others =>
                     return FremdeStadtAufFeld (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                FremdeStadtExtern => StadtAufFeld);
               end case;
               
            else
               null;
            end if;
            
         when False =>
            null;
      end case;
      
      return False;
      
   end FremderAufFeld;
   
   
   
   function FremdeStadtAufFeld
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      FremdeStadtExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        DiplomatischerZustand.GegnerAngreifen (EigeneRasseExtern      => RasseExtern,
                                               GegnerischeRasseExtern => FremdeStadtExtern.Rasse)
      is
         when True =>
            StadtEntfernen.StadtEntfernen (StadtRasseNummerExtern => FremdeStadtExtern);
            return True;
            
         when False =>
            return False;
      end case;
      
   end FremdeStadtAufFeld;
   
   
   
   -- Hier vielleicht später mehr einbauen? Beispielsweise Plätzetauschen?
   procedure EigeneEinheitAufFeld
     (BewegendeEinheitExtern, FeldBelegendeEinheitExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      BewegungLadenEntladen.TransporterBeladen (TransporterExtern => FeldBelegendeEinheitExtern,
                                                LadungExtern      => BewegendeEinheitExtern.Platznummer);
      
   end EigeneEinheitAufFeld;

end BewegungssystemEinheiten;
