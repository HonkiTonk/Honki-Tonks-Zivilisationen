with EinheitenDatentypen;
with DiplomatieDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with StadtDatentypen;

with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseGrenzen;
with LeseDiplomatie;

with KartenkoordinatenberechnungssystemLogik;
with EinheitSuchenLogik;
with MeldungenSetzenLogik;

package body EinheitInUmgebungLogik is

   procedure EinheitInUmgebung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      UmgebungStadt (SpeziesExtern => SpeziesExtern);
      UmgebungEinheit (SpeziesExtern => SpeziesExtern);
      
   end EinheitInUmgebung;
   
   
   
   procedure UmgebungStadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
                  
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
                        
            when others =>
               if
                 True = EinheitFinden (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)),
                                       UmgebungExtern    => LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)) + 1,
                                       SpeziesExtern     => SpeziesExtern)
               then
                  MeldungenSetzenLogik.StadtmeldungSetzen (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert),
                                                           EreignisExtern           => StadtDatentypen.Fremde_Einheit_Nahe_Stadt_Enum);
                           
               else
                  null;
               end if;
         end case;
                  
      end loop StadtSchleife;
      
   end UmgebungStadt;
   
   
   
   procedure UmgebungEinheit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
                  
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
                        
            when others =>
               if
                 True = EinheitFinden (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)),
                                       UmgebungExtern    => 3,
                                       SpeziesExtern     => SpeziesExtern)
               then
                  MeldungenSetzenLogik.EinheitmeldungSetzen (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert),
                                                             EreignisExtern             => EinheitenDatentypen.Fremde_Einheit_Nahe_Enum);
                           
               else
                  null;
               end if;
         end case;
                  
      end loop EinheitenSchleife;
      
   end UmgebungEinheit;
   
   
   
   function EinheitFinden
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      UmgebungExtern : in KartenDatentypen.Sichtweite;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
   begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
         XAchseSchleife:
         for XAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
      
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                              SpeziesExtern     => SpeziesExtern)
            then
               null;
               
            else
               AndereEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneSpezielleSpeziesSuchen (SpeziesExtern     => SpeziesExtern,
                                                                                                 KoordinatenExtern => KartenWert,
                                                                                                 LogikGrafikExtern => True);
               
               if
                 AndereEinheit.Nummer = EinheitenKonstanten.LeerNummer
               then
                  null;
                    
               elsif
                 DiplomatieDatentypen.Nichtangriffspakt_Enum = LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesExtern,
                                                                                                SpeziesZweiExtern => AndereEinheit.Spezies)
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

end EinheitInUmgebungLogik;
