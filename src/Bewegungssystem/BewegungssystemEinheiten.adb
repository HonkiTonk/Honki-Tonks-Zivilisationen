pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Karte, EinheitSuchen, KartePositionPruefen, Eingabe, BewegungPassierbarkeitPruefen, BewegungBerechnen, EinheitenAllgemein, Diplomatie, BewegungLadenEntladen;

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
           KartenWert.YAchse
         is               
            when 0 =>
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
      
      if
        FeldPassierbar = False
        and
          EinheitAufFeld.Platznummer = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
      then
         return Bewegbar;
         
      elsif
        FeldPassierbar = False
        and
          EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
          and
            EinheitenAllgemein.KennTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                        TransporterExtern => EinheitAufFeld) = False
      then
         return Bewegbar;
         
      elsif
        FeldPassierbar = False
        and
          EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
          and
            EinheitenAllgemein.KennTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                        TransporterExtern => EinheitAufFeld) = True
      then
         ZwischenWert := EigeneEinheitAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               EigeneEinheitExtern      => EinheitAufFeld,
                                               NeuePositionExtern       => NeuePositionExtern);
         
      elsif
        FeldPassierbar = False
        and
          EinheitAufFeld.Rasse /= EinheitRasseNummerExtern.Rasse
          and
            EinheitAufFeld.Rasse /= GlobaleDatentypen.Leer
      then
         ZwischenWert := FremderAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         FremdeEinheitExtern      => EinheitAufFeld,
                                         NeuePositionExtern       => NeuePositionExtern);
         
      else
         null;
      end if;
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Bewegungspunkte <= 0.00
        or
          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Lebenspunkte = 0
      then
         return Zurück;
            
      else      
         return Bewegbar;
      end if;
      
   end BewegungPrüfen;
   
   
   
   
   function FremderAufFeld
     (EinheitRasseNummerExtern, FremdeEinheitExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      Diplomatie.GegnerAngreifenOderNicht (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           GegnerExtern             => FremdeEinheitExtern);
      
      return False;
      
   end FremderAufFeld;
   
   
   
   function EigeneEinheitAufFeld
     (EinheitRasseNummerExtern, EigeneEinheitExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      BewegungLadenEntladen.TransporterBeladen (LadungExtern      => EinheitRasseNummerExtern,
                                                TransporterExtern => EigeneEinheitExtern);
      
      return False;
      
   end EigeneEinheitAufFeld;

end BewegungssystemEinheiten;
