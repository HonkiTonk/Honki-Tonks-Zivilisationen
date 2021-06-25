pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen;

with EinheitenDatenbank, KartenDatenbank;

with Anzeige, Eingabe, Karte, KartenPruefungen, Karten, EinheitSuchen, EinheitenAllgemein;

package body StadtEinheitenBauen is

   procedure EinheitFertiggestellt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      EinheitNummer := 0;
            
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
            
         if
           GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert).ID = 0
         then
            EinheitNummer := EinheitNummerSchleifenwert;
            exit EinheitenSchleife;
            
         else
            null;
         end if;
            
      end loop EinheitenSchleife;
      
      -- Das hier so ändern dass die Städte gespeichert werden und am Anfang der Spielerrunde erst die Meldungen kommen, dann auch nutzbar für die KI
      -- GlobaleRecord StadtGebaut um einen Meldewert erweitern
      -- Per Taste abrufbar machen
      -- Auch bei Wachstum direkt berücksichtigen
      if
        EinheitNummer = 0
        and
          GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) = 1
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                               TextZeileExtern => 19);
         GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position;
         GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionAlt := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position;
         Karte.AnzeigeKarte (RasseExtern => StadtRasseNummerExtern.Rasse);         
         Eingabe.WartenEingabe;
         return;
         
      elsif
        EinheitNummer = 0
      then
         return;
         
      else
         null;
      end if;
      
      BereitsVonEinheitBelegt := 1;
      Umgebung := 1;
      
      BereichSchleife:
      loop
         YAchseSchleife:
         for YÄnderungSchleifenwert in -Umgebung .. Umgebung loop -- Es gibt Fälle in denen er über Felder loopt über die er schon geloopt hat, später bessere Lösung bauen
            XAchseSchleife:
            for XÄnderungSchleifenwert in -Umgebung .. Umgebung loop
            
               KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                                                       ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
               exit XAchseSchleife when KartenWert.YAchse = 0;
            
               -- Kann Einheiten auch über Meere hinweg platzieren und so Schiffahrt "umgehen"
               if
                 Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
               in
                 GlobaleKonstanten.FeldBelegung (StadtRasseNummerExtern.Rasse, 1) .. GlobaleKonstanten.FeldBelegung (StadtRasseNummerExtern.Rasse, 2)
               then
                  BereitsVonEinheitBelegt := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer;
                  if
                    BereitsVonEinheitBelegt = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
                    and
                      (EinheitenDatenbank.EinheitenListe
                         (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.EinheitenID
                            (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt
                             - GlobaleKonstanten.EinheitAufschlag)).Passierbarkeit (KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Passierbarkeit) = True
                       or
                         (YÄnderungSchleifenwert = 0
                          and
                            XÄnderungSchleifenwert = 0))
                  then
                     exit BereichSchleife;
                     
                  else
                     null;
                  end if;
               
               else
                  null;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         case
           Umgebung
         is
            when 3 =>
               exit BereichSchleife;
               
            when others =>
               Umgebung := Umgebung + 1;
         end case;
         
      end loop BereichSchleife;
      
      if
        BereitsVonEinheitBelegt = GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch
      then
         EinheitenAllgemein.EinheitErzeugen (KoordinatenExtern            => KartenWert,
                                             EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummer),
                                             IDExtern                     => GlobaleDatentypen.EinheitenID (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                               StadtRasseNummerExtern.Platznummer).Bauprojekt - GlobaleKonstanten.EinheitAufschlag));
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauzeit := 0;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Ressourcen := 0;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Bauprojekt := 0;
         
      else
         null;
      end if;
      
      case
        GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse)
      is
         when 1 =>
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Zeug,
                                                  TextZeileExtern => 29);
         
         when others =>
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIBeschäftigung := KIDatentypen.Keine_Aufgabe;
      end case;
      
   end EinheitFertiggestellt;

end StadtEinheitenBauen;
