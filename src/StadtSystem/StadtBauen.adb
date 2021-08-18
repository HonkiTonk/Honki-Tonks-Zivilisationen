pragma SPARK_Mode (On);

with GlobaleKonstanten, GlobaleTexte;

with EinheitenDatenbank;

with Anzeige, StadtWerteFestlegen, Eingabe, KartePositionPruefen, StadtProduktion, ForschungAllgemein, EinheitenAllgemein, Sichtbarkeit, LeseKarten, LeseEinheitenGebaut;

package body StadtBauen is

   procedure StadtBauen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin     
        
      if 
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)).EinheitArt
          = GlobaleDatentypen.Arbeiter
      then
         null;
         
      else
         return;
      end if;
      
      if
        LeseKarten.BelegterGrundLeer (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True
      then
         null;
         
      elsif
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
      then
         return;
         
      else
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                               TextZeileExtern => 6);
         return;
      end if;

      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze loop
         
         if
           StadtNummerSchleifenwert = GlobaleVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Städtegrenze
           and
             GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert).ID /= GlobaleDatentypen.Leer
         then
            if
              GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = GlobaleDatentypen.Spieler_KI
            then
               return;
               
            else
               Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                     TextZeileExtern => 7);
               return;
            end if;

         elsif
           GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert).ID /= GlobaleDatentypen.Leer
         then
            null;
            
         else
            StadtNummer := StadtNummerSchleifenwert;
            exit StadtSchleife;
         end if;
         
      end loop StadtSchleife;
      
      Stadtart := HauptstadtPrüfen (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer) := GlobaleKonstanten.LeerStadt;
      GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer).ID := Stadtart;
      GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer).Position := LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer).EinwohnerArbeiter := (1, 1);
      GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer).UmgebungBewirtschaftung := (0 => (0 => True, others => False), others => (others => False));
      GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer).UmgebungGröße := 1;
      
      StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer));
      StadtProduktion.StadtProduktionPrüfen (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer));
      ForschungAllgemein.ForschungZeit (RasseExtern => EinheitRasseNummerExtern.Rasse);
      Sichtbarkeit.SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer));
            
      EinheitenAllgemein.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      case
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
      is
         when GlobaleDatentypen.Spieler_KI =>
            StandardStadtNamen (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer));
                  
         when others =>
            GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer).Name := Eingabe.StadtName;
      end case;
      
   end StadtBauen;



   function ErweitertesStadtBauenPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              LeseKarten.BelegterGrundLeer (KoordinatenExtern => KartenWert) = True
            then
               null;
               
            else
               return False;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      return True;

   end ErweitertesStadtBauenPrüfen;



   function HauptstadtPrüfen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.Karten_Verbesserung_Stadt_ID_Enum
   is begin
      
      HauptsstadtSchleife:
      for HauptstadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           GlobaleVariablen.StadtGebaut (RasseExtern, HauptstadtSchleifenwert).ID
         is
            when GlobaleDatentypen.Eigene_Hauptstadt =>
               return GlobaleDatentypen.Eigene_Stadt;
               
            when others =>
               null;
         end case;
         
      end loop HauptsstadtSchleife;
      
      return GlobaleDatentypen.Eigene_Hauptstadt;
      
   end HauptstadtPrüfen;
   
   
   
   procedure StandardStadtNamen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Name := GlobaleTexte.TexteEinlesenNeu (22, WelcherName);
      
      case
        WelcherName
      is
         when 3 =>
            WelcherName := 1;
            
         when others =>
            WelcherName := WelcherName + 1;
      end case;
      
   end StandardStadtNamen;

end StadtBauen;
