pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitenDatenbank, KartenDatenbank;

with EinheitSuchen, KartenPruefungen;

package body BewegungLadenEntladen is

   procedure TransporterBeladen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ÄnderungExtern : in GlobaleRecords.AchsenKartenfeldRecord)
   is begin

      KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                              ÄnderungExtern       => ÄnderungExtern,
                                                              ZusatzYAbstandExtern => 0);
      
      TransporterNummer := EinheitSuchen.KoordinatenTransporterMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                               KoordinatenExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
      
      EinheitAusladen := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert;
                                          
      TransporterSchleife:
      for FreierPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
        
         case
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).Transportiert (FreierPlatzSchleifenwert)
         is
            when 0 =>
               FreierPlatzNummer := FreierPlatzSchleifenwert;
               exit TransporterSchleife;
               
            when others =>
               null;
         end case;
         
      end loop TransporterSchleife;
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).Transportiert (FreierPlatzNummer) := EinheitRasseNummerExtern.Platznummer;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBewegungspunkte := 0.00;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition
        := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransporterNummer).AchsenPosition;
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).WirdTransportiert := TransporterNummer;
      
      case
        EinheitAusladen
      is
         when 0 =>
            null;
            
         when others =>
            EinheitAusTransporterEntfernen (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                            AuszuladendeEinheitExtern => EinheitAusladen);
      end case;
      
      GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).AchsenPosition := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition;
      
   end TransporterBeladen;
   
   
   
   procedure EinheitAusTransporterEntfernen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AuszuladendeEinheitExtern : in GlobaleDatentypen.MaximaleEinheiten)
   is begin
      
      TransporterLeerenSchleife:
      for TransporterPlatzZweiSchleifenwert in GlobaleRecords.TransporterArray'Range loop

         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, AuszuladendeEinheitExtern).Transportiert (TransporterPlatzZweiSchleifenwert) = EinheitRasseNummerExtern.Platznummer
         then
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, AuszuladendeEinheitExtern).Transportiert (TransporterPlatzZweiSchleifenwert) := 0;
            -- Hier nicht den wird Transportiert auf 0 setzen, da das zu Problemen bei Verschiebungen von Transporter zu Transporter führen kann.
            exit TransporterLeerenSchleife;
                     
         else
            null;
         end if;
               
      end loop TransporterLeerenSchleife;
      
   end EinheitAusTransporterEntfernen;
   
   
   
   procedure TransporterladungVerschieben
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      TransporterEinsSchleife:
      for TransporterPlatzEinsSchleifenwert in GlobaleRecords.TransporterArray'Range loop
               
         case
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (TransporterPlatzEinsSchleifenwert)
         is
            when 0 =>
               null;
                     
            when others =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert
                                                 (TransporterPlatzEinsSchleifenwert)).AchsenPosition := NeuePositionExtern;
         end case;
               
      end loop TransporterEinsSchleife;
      
   end TransporterladungVerschieben;
   
   
   
   procedure TransporterStadtEntladen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      NeuePositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      TransportplatzEntladen := (others => 0);
      WelcherPlatz := 1;
      BelegterPlatzSchleife:
      for BelegterPlatzSchleifenwert in GlobaleRecords.TransporterArray'Range loop
                        
         case
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert)
         is
            when 0 =>
               null;
                              
            when others =>
               TransportplatzEntladen (WelcherPlatz) := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert (BelegterPlatzSchleifenwert);
               WelcherPlatz := WelcherPlatz + 1;
         end case;
                
      end loop BelegterPlatzSchleife;

      case
        TransportplatzEntladen (1)
      is
         when 0 =>
            return;
                          
         when others =>
            null;
      end case;
      
      Umgebung := 1;         
      WelcherPlatz := 1;
      
      BereichSchleife:
      loop
         YAchseSchleife:
         for YÄnderungSchleifenwert in -Umgebung .. Umgebung loop -- Es gibt Fälle in denen er über Felder loopt über die er schon geloopt hat, später bessere Lösung bauen
            XAchseSchleife:
            for XÄnderungSchleifenwert in -Umgebung .. Umgebung loop
            
               KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => NeuePositionExtern,
                                                                       ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                       ZusatzYAbstandExtern => 0);
            
               exit XAchseSchleife when KartenWert.YAchse = 0;
            
               -- Kann Einheiten auch über Meere hinweg platzieren und so Schiffahrt "umgehen"
               if
                 YÄnderungSchleifenwert = 0
                 and
                   XÄnderungSchleifenwert = 0
               then
                  null;
                     
               elsif
                 Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
               in
                 GlobaleKonstanten.FeldBelegung (EinheitRasseNummerExtern.Rasse, 1) .. GlobaleKonstanten.FeldBelegung (EinheitRasseNummerExtern.Rasse, 2)
               then
                  if
                    GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch = EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer
                    and
                      EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransportplatzEntladen (WelcherPlatz)).ID).Passierbarkeit
                    (KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Passierbarkeit) = True
                  then
                     GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransportplatzEntladen (WelcherPlatz)).AchsenPosition := KartenWert;
                     GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, TransportplatzEntladen (WelcherPlatz)).WirdTransportiert := 0;
                     WelcherPlatz := WelcherPlatz + 1;
                        
                     if
                       WelcherPlatz > TransportplatzEntladen'Last
                     then
                        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert := (others => 0);
                        return;
                              
                     else
                        null;
                     end if;
                     
                  else
                     null;
                  end if;
                     
               else
                  null;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
            
         Umgebung := Umgebung + 1;
                     
      end loop BereichSchleife;     
      
   end TransporterStadtEntladen;

end BewegungLadenEntladen;
