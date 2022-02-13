pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with SystemKonstanten;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with KarteKoordinatenPruefen;
with EinheitSuchen;
with DiplomatischerZustand;
with EinheitenMeldungenSetzen;
with StadtMeldungenSetzen;

package body EinheitInUmgebung is

   procedure EinheitInUmgebung
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SystemKonstanten.SpielerMenschKonstante =>
               UmgebungStadt (RasseExtern => RasseSchleifenwert);
               UmgebungEinheit (RasseExtern => RasseSchleifenwert);
               
            when others =>
               null;
         end case;
         
      end loop RassenSchleife;
      
   end EinheitInUmgebung;
   
   
   
   procedure UmgebungStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
                  
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
                        
            when others =>
               if
                 EinheitFinden (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)),
                                UmgebungExtern    => LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)) + 1,
                                RasseExtern       => RasseExtern)
                 = True
               then
                  StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert),
                                                                   EreignisExtern         => EinheitStadtDatentypen.Fremde_Einheit_Nahe_Stadt);
                           
               else
                  null;
               end if;
         end case;
                  
      end loop StadtSchleife;
      
   end UmgebungStadt;
   
   
   
   procedure UmgebungEinheit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
                  
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
                        
            when others =>
               if
                 EinheitFinden (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert)),
                                UmgebungExtern    => 3,
                                RasseExtern       => RasseExtern)
                 = True
               then
                  EinheitenMeldungenSetzen.EinheitMeldungSetzenEreignis (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert),
                                                                         EreignisExtern           => EinheitStadtDatentypen.Fremde_Einheit_Nahe);
                           
               else
                  null;
               end if;
         end case;
                  
      end loop EinheitenSchleife;
      
   end UmgebungEinheit;
   
   
   
   function EinheitFinden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      UmgebungExtern : in KartenDatentypen.Sichtweite;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
         XAchseSchleife:
         for XAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
      
            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => KoordinatenExtern,
                                                                           ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                           LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Sichtbar (KoordinatenExtern => KartenWert,
                                   RasseExtern       => RasseExtern)
              = False
            then
               null;
               
            else
               AndereEinheit := EinheitSuchen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => RasseExtern,
                                                                                          KoordinatenExtern => KartenWert);
               
               if
                 AndereEinheit.Platznummer = EinheitenKonstanten.LeerNummer
               then
                  null;
                    
               elsif
                 DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => RasseExtern,
                                                                    FremdeRasseExtern => AndereEinheit.Rasse)
                 = SystemDatentypen.Nichtangriffspakt
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
