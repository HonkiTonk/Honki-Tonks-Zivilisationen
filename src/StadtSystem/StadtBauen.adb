pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleKonstanten, GlobaleTexte;

with KIDatentypen;

with Anzeige, StadtWerteFestlegen, Eingabe, Karten, KartePositionPruefen, StadtProduktion, ForschungAllgemein, EinheitenAllgemein, Sichtbarkeit, FeldTesten;

package body StadtBauen is

   procedure StadtBauen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin     
        
      if
        FeldTesten.BelegterGrundLeerTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
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
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         if
           StadtNummerSchleifenwert = GlobaleVariablen.StadtGebautArray'Last (2)
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
      
      -- ID, AchsenPosition, Am Wasser, (Einwohner, Arbeiter)
      -- Aktuelle Nahrungsmittel, Aktuelle Nahrungsproduktion, Aktuelle Ressourcen, Aktuelle Produktionrate
      -- Aktuelle Geldgewinnung, Aktuelle Forschungsrate, Aktuelles Bauprojekt, Verbleibende Bauzeit
      -- Korruption, Gebäude Vorhanden, Stadtname
      -- UmgebungBewirtschaftung, UmgebungGröße
      -- Aktuelle Meldungen
      -- KI aktuelle Beschäftigung
      
      GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer) :=       
        (
         Stadtart, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position, False, (1, 1),
         0, 0, 0, 0,
         0, 0, 0, 0,
         0, (others => False), To_Unbounded_Wide_Wide_String (Source => "KIStadtname"),
         (0 => (0 => True, others => False), others => (others => False)), 1,
         (others => GlobaleDatentypen.Keine),
         KIDatentypen.Keine_Aufgabe
        );
      
      case
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse
      is
         when -1 .. 0 =>
            AmWasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  
         when others =>
            null;
      end case;
      
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
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund = 0
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
      for HauptstadtSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
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
   
   
   
   procedure AmWasser
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      YAchsenSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchsenSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                        ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund
            in
              GlobaleDatentypen.Karten_Grund_Wasser_Enum'Range
            then
               GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer).AmWasser := True;
               exit YAchsenSchleife;
               
            else
               null;
            end if;
                  
         end loop XAchsenSchleife;
      end loop YAchsenSchleife;
      
   end AmWasser;



   procedure StadtEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      StadtUmgebungFreigebenSchleife:
      for StadtUmgebungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         
         if
           Karten.Weltkarte (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position.EAchse,
                             GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position.YAchse,
                             GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position.XAchse).DurchStadtBelegterGrund
             = GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (StadtRasseNummerExtern.Rasse)) * GlobaleKonstanten.RassenMulitplikationWert
           + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer)
         then
            Karten.Weltkarte (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position.EAchse,
                              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position.YAchse,
                              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position.XAchse).DurchStadtBelegterGrund := 0;
            
         else
            null;
         end if;
         
      end loop StadtUmgebungFreigebenSchleife;
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer) := GlobaleKonstanten.LeerStadt;
      
   end StadtEntfernen;
   
   
   
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
