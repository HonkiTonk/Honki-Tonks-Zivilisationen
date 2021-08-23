pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleKonstanten;

with KartePositionPruefen, EinheitSuchen, DiplomatischerZustand, EinheitenMeldungenSetzen, StadtMeldungenSetzen, LeseKarten, LeseEinheitenGebaut, LeseStadtGebaut;

package body EinheitInUmgebung is

   procedure EinheitInUmgebung
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer | GlobaleDatentypen.Spieler_KI =>
               null;
               
            when GlobaleDatentypen.Spieler_Mensch =>
               StadtSchleife:
               for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Städtegrenze loop
                  
                  case
                    LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseSchleifenwert, StadtSchleifenwert))
                  is
                     when GlobaleKonstanten.LeerStadtID =>
                        null;
                        
                     when others =>
                        EinheitInDerNähe := EinheitFinden (PositionExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => (RasseSchleifenwert, StadtSchleifenwert)),
                                                            UmgebungExtern => LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => (RasseSchleifenwert, StadtSchleifenwert)) + 1,
                                                            RasseExtern    => RasseSchleifenwert);
                        
                        if
                          EinheitInDerNähe
                        then
                           StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => (RasseSchleifenwert, StadtSchleifenwert),
                                                                            EreignisExtern         => GlobaleDatentypen.Fremde_Einheit_Nahe_Stadt);
                           
                        else
                           null;
                        end if;
                  end case;
                  
               end loop StadtSchleife;
               
               EinheitenSchleife:
               for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseSchleifenwert).Einheitengrenze loop
                  
                  case
                    LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitSchleifenwert))
                  is
                     when GlobaleKonstanten.LeerEinheitenID =>
                        null;
                        
                     when others =>
                        EinheitInDerNähe := EinheitFinden (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitSchleifenwert)),
                                                            UmgebungExtern => 3,
                                                            RasseExtern    => RasseSchleifenwert);
                  end case;
                        
                  if
                    EinheitInDerNähe
                  then
                     EinheitenMeldungenSetzen.EinheitMeldungSetzenEreignis (EinheitRasseNummerExtern => (RasseSchleifenwert, EinheitSchleifenwert),
                                                                            EreignisExtern           => GlobaleDatentypen.Fremde_Einheit_Nahe);
                           
                  else
                     null;
                  end if;
                  
               end loop EinheitenSchleife;
         end case;
         
      end loop RassenSchleife;
      
   end EinheitInUmgebung;
   
   
   
   function EinheitFinden
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      UmgebungExtern : in GlobaleDatentypen.Sichtweite;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
         XAchseSchleife:
         for XAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
      
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => PositionExtern,
                                                                        ÄnderungExtern   => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              LeseKarten.Sichtbar (PositionExtern => KartenWert,
                                   RasseExtern    => RasseExtern) = False
            then
               null;
               
            else
               AndereEinheit := EinheitSuchen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => RasseExtern,
                                                                                          KoordinatenExtern => KartenWert);
               
               if
                 AndereEinheit.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
               then
                  null;
                    
               elsif
                 DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => RasseExtern,
                                                                    FremdeRasseExtern => AndereEinheit.Rasse) = GlobaleDatentypen.Nichtangriffspakt
               then
                  null;
                  
               else
                  return True;
               end if;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
      
   end EinheitFinden;

end EinheitInUmgebung;
