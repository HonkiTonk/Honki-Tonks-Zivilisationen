pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with DiplomatieDatentypen; use DiplomatieDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with StadtDatentypen;

with LeseKarten;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with Kartenkoordinatenberechnungssystem;
with EinheitSuchen;
with DiplomatischerZustand;
with EinheitenMeldungenSetzen;
with StadtMeldungenSetzen;

package body EinheitInUmgebung is

   procedure EinheitInUmgebung
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Mensch_Spieler_Enum =>
               UmgebungStadt (RasseExtern => RasseSchleifenwert);
               UmgebungEinheit (RasseExtern => RasseSchleifenwert);
               
            when others =>
               null;
         end case;
         
      end loop RassenSchleife;
      
   end EinheitInUmgebung;
   
   
   
   procedure UmgebungStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop
                  
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
                        
            when others =>
               if
                 True = EinheitFinden (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)),
                                       UmgebungExtern    => LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert)) + 1,
                                       RasseExtern       => RasseExtern)
               then
                  StadtMeldungenSetzen.StadtMeldungSetzenEreignis (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert),
                                                                   EreignisExtern         => StadtDatentypen.Fremde_Einheit_Nahe_Stadt_Enum);
                           
               else
                  null;
               end if;
         end case;
                  
      end loop StadtSchleife;
      
   end UmgebungStadt;
   
   
   
   procedure UmgebungEinheit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
                  
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
                        
            when others =>
               if
                 True = EinheitFinden (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert)),
                                       UmgebungExtern    => 3,
                                       RasseExtern       => RasseExtern)
               then
                  EinheitenMeldungenSetzen.EinheitMeldungSetzenEreignis (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert),
                                                                         EreignisExtern           => EinheitenDatentypen.Fremde_Einheit_Nahe_Enum);
                           
               else
                  null;
               end if;
         end case;
                  
      end loop EinheitenSchleife;
      
   end UmgebungEinheit;
   
   
   
   function EinheitFinden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      UmgebungExtern : in KartenDatentypen.Sichtweite;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
         XAchseSchleife:
         for XAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
      
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = LeseKarten.Sichtbar (KoordinatenExtern => KartenWert,
                                           RasseExtern       => RasseExtern)
            then
               null;
               
            else
               AndereEinheit := EinheitSuchen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => RasseExtern,
                                                                                          KoordinatenExtern => KartenWert,
                                                                                          LogikGrafikExtern => True);
               
               if
                 AndereEinheit.Nummer = EinheitenKonstanten.LeerNummer
               then
                  null;
                    
               elsif
                 DiplomatieDatentypen.Nichtangriffspakt_Enum = DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => RasseExtern,
                                                                                                                  FremdeRasseExtern => AndereEinheit.Rasse)
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
