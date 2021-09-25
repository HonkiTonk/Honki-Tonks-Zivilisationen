pragma SPARK_Mode (On);

with GlobaleVariablen, GlobaleKonstanten, KartenKonstanten;

with LeseKarten, LeseEinheitenGebaut, LeseStadtGebaut;

with KartePositionPruefen, EinheitSuchen, DiplomatischerZustand, EinheitenMeldungenSetzen, StadtMeldungenSetzen;

package body EinheitInUmgebung is

   procedure EinheitInUmgebung
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Spieler_Mensch =>
               UmgebungStadt (RasseExtern => RasseSchleifenwert);
               UmgebungEinheit (RasseExtern => RasseSchleifenwert);
               
            when others =>
               null;
         end case;
         
      end loop RassenSchleife;
      
   end EinheitInUmgebung;
   
   
   
   procedure UmgebungStadt
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
                  
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when GlobaleKonstanten.LeerStadtID =>
               null;
                        
            when others =>
               if
                 EinheitFinden (PositionExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)),
                                UmgebungExtern => LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)) + 1,
                                RasseExtern    => RasseExtern)
                 = True
               then
                  StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert),
                                                                   EreignisExtern         => GlobaleDatentypen.Fremde_Einheit_Nahe_Stadt);
                           
               else
                  null;
               end if;
         end case;
                  
      end loop StadtSchleife;
      
   end UmgebungStadt;
   
   
   
   procedure UmgebungEinheit
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
                  
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert))
         is
            when GlobaleKonstanten.LeerEinheitenID =>
               null;
                        
            when others =>
               if
                 EinheitFinden (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert)),
                                UmgebungExtern => 3,
                                RasseExtern    => RasseExtern)
                 = True
               then
                  EinheitenMeldungenSetzen.EinheitMeldungSetzenEreignis (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert),
                                                                         EreignisExtern           => GlobaleDatentypen.Fremde_Einheit_Nahe);
                           
               else
                  null;
               end if;
         end case;
                  
      end loop EinheitenSchleife;
      
   end UmgebungEinheit;
   
   
   
   function EinheitFinden
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
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
              KartenWert.XAchse = KartenKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              LeseKarten.Sichtbar (PositionExtern => KartenWert,
                                   RasseExtern    => RasseExtern)
              = False
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
                                                                    FremdeRasseExtern => AndereEinheit.Rasse)
                 = GlobaleDatentypen.Nichtangriffspakt
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
