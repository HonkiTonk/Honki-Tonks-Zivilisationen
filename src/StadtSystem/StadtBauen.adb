pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleKonstanten, GlobaleTexte;

with KIDatentypen;

with Anzeige, StadtWerteFestlegen, Eingabe, Karten, KartePositionPruefen, StadtProduktion, ForschungAllgemein, EinheitenAllgemein;

package body StadtBauen is

   procedure StadtBauen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin     
        
      if
        StadtBauenPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2
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
             GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert).ID /= 0
         then
            if
              GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2
            then
               return;
               
            else
               Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                     TextZeileExtern => 7);
               return;
            end if;

         elsif
           GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert).ID /= 0
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
            
      EinheitenAllgemein.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      case
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
      is
         when 2 =>
            StadtNameSchleife:
            for StadtNameSchleifenwert in KIStadtNameArray'Range (2) loop
               
               if
                 KIStadtName (EinheitRasseNummerExtern.Rasse, StadtNameSchleifenwert) = 0
               then
                  KIStadtName (EinheitRasseNummerExtern.Rasse, StadtNameSchleifenwert) := 1;
                  -- Hier dann aus Datei eingelesene Stadtnamen reinbauen
                  
               else
                  null;
               end if;
               
            end loop StadtNameSchleife;
                  
         when others =>
            GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer).Name := Eingabe.StadtName;
      end case;
      
   end StadtBauen;



   function StadtBauenPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      if
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).DurchStadtBelegterGrund = 0
      then
         return True;
         
      else
         return False;
      end if;
      
   end StadtBauenPrüfen;



   function ErweitertesStadtBauenPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                        ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            exit XAchseSchleife when KartenWert.XAchse = 0;
            
            case
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
            is
               when 0 =>
                  null;
                        
               when others =>
                  return False;
            end case;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      return True;

   end ErweitertesStadtBauenPrüfen;



   function HauptstadtPrüfen
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.StadtID
   is begin
      
      -- Wenn die Hauptstadt existiert gibt es eine Zwei zurück, sonst eine Eins.
      HauptsstadtSchleife:
      for HauptstadtSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         case
           GlobaleVariablen.StadtGebaut (RasseExtern, HauptstadtSchleifenwert).ID
         is
            when 1 =>
               return 2;
               
            when others =>
               null;
         end case;
         
      end loop HauptsstadtSchleife;
      
      return 1;
      
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
            
            exit XAchsenSchleife when KartenWert.XAchse = 0;
                  
            case
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund
            is
               when 2 | 29 .. 31 =>
                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer).AmWasser := True;
                  exit YAchsenSchleife;
                        
               when others =>
                  null;
            end case;
                  
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
             = GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * GlobaleKonstanten.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer)
         then
            Karten.Weltkarte (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position.EAchse,
                              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position.YAchse,
                              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position.XAchse).DurchStadtBelegterGrund := 0;
            
         else
            null;
         end if;
         
      end loop StadtUmgebungFreigebenSchleife;
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer) := GlobaleKonstanten.LeererWertStadt;
      
   end StadtEntfernen;

end StadtBauen;
