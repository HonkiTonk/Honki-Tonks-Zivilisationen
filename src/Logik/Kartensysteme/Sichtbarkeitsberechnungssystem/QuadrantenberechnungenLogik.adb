with KartenkoordinatenberechnungssystemLogik;
with SichtbarkeitSetzenLogik;
with SichtbereicheErmittelnLogik;

package body QuadrantenberechnungenLogik is

   procedure QuadrantenDurchlaufen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SichtweiteExtern : in KartenDatentypen.Sichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      YQuadrantSchleife:
      for YQuadrantSchleifenwert in 0 .. SichtweiteExtern loop
         XQuadrantSchleife:
         for XQuadrantSchleifenwert in 0 .. SichtweiteExtern loop
            
            QuadrantEins (SpeziesExtern             => SpeziesExtern,
                          SichtweiteYRichtungExtern => YQuadrantSchleifenwert,
                          SichtweiteXRichtungExtern => XQuadrantSchleifenwert,
                          SichtweiteExtern          => SichtweiteExtern,
                          KoordinatenExtern         => KoordinatenExtern);
            
            case
              YQuadrantSchleifenwert
            is
               when 0 =>
                  null;
                  
               when others =>
                  QuadrantZwei (SpeziesExtern             => SpeziesExtern,
                                SichtweiteYRichtungExtern => YQuadrantSchleifenwert,
                                SichtweiteXRichtungExtern => XQuadrantSchleifenwert,
                                SichtweiteExtern          => SichtweiteExtern,
                                KoordinatenExtern         => KoordinatenExtern);
            end case;
      
            case
              XQuadrantSchleifenwert
            is
               when 0 =>
                  null;
                  
               when others =>
                  QuadrantDrei (SpeziesExtern             => SpeziesExtern,
                                SichtweiteYRichtungExtern => YQuadrantSchleifenwert,
                                SichtweiteXRichtungExtern => XQuadrantSchleifenwert,
                                SichtweiteExtern          => SichtweiteExtern,
                                KoordinatenExtern         => KoordinatenExtern);
            end case;
      
            if
              YQuadrantSchleifenwert = 0
              and
                XQuadrantSchleifenwert = 0
            then
               null;
               
            else
               QuadrantVier (SpeziesExtern             => SpeziesExtern,
                             SichtweiteYRichtungExtern => YQuadrantSchleifenwert,
                             SichtweiteXRichtungExtern => XQuadrantSchleifenwert,
                             SichtweiteExtern          => SichtweiteExtern,
                             KoordinatenExtern         => KoordinatenExtern);
            end if;
            
         end loop XQuadrantSchleife;
      end loop YQuadrantSchleife;
      
   end QuadrantenDurchlaufen;
   
   
   
   -- Auch mal einen zweidimensionalen Record für die Sichtweiten einbauen? äöü
   procedure QuadrantEins
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteExtern : in KartenDatentypen.Sichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
              
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, -SichtweiteYRichtungExtern, SichtweiteXRichtungExtern),
                                                                                                        LogikGrafikExtern => True);
      
      case
        KartenQuadrantWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern <= 1
      then
         SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                     KoordinatenExtern => KartenQuadrantWert);
               
      elsif
        SichtweiteYRichtungExtern in 2 .. 3
        and
          SichtweiteXRichtungExtern <= 1
      then
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in 0 .. SichtweiteXRichtungExtern loop
                    
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert,
                                                                                 SichtweiteExtern  => SichtweiteExtern)
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern in 2 .. 3
      then
         YÄnderungSchleife22:
         for YÄnderungSchleifenwert in 0 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife22:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
                                 
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => YÄnderungSchleifenwert,
                                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                                                 SichtweiteExtern  => SichtweiteExtern)
               then
                  exit YÄnderungSchleife22;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife22;
         end loop YÄnderungSchleife22;
               
      else
         YÄnderungSchleife333:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife333:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
                     
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                                                 SichtweiteExtern  => SichtweiteExtern)
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife333;
         end loop YÄnderungSchleife333;
      end if;
      
   end QuadrantEins;
   
   
   
   procedure QuadrantZwei
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteExtern : in KartenDatentypen.Sichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
                    
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, SichtweiteYRichtungExtern, SichtweiteXRichtungExtern),
                                                                                                        LogikGrafikExtern => True);
      
      case
        KartenQuadrantWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern <= 1
      then
         SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                     KoordinatenExtern => KartenQuadrantWert);
               
      elsif
        SichtweiteYRichtungExtern in 2 .. 3
        and
          SichtweiteXRichtungExtern <= 1
      then
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in 0 .. SichtweiteXRichtungExtern loop
                                         
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert,
                                                                                 SichtweiteExtern  => SichtweiteExtern)
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern in 2 .. 3
      then
         YÄnderungSchleife22:
         for YÄnderungSchleifenwert in 0 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife22:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
                                 
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert,
                                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                                                 SichtweiteExtern  => SichtweiteExtern)
               then
                  exit YÄnderungSchleife22;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife22;
         end loop YÄnderungSchleife22;
               
      else
         YÄnderungSchleife333:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife333:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
                     
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                                                 SichtweiteExtern  => SichtweiteExtern)
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife333;
         end loop YÄnderungSchleife333;
      end if;
                  
   end QuadrantZwei;
   
   
   
   procedure QuadrantDrei
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteExtern : in KartenDatentypen.Sichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
                    
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, SichtweiteYRichtungExtern, -SichtweiteXRichtungExtern),
                                                                                                        LogikGrafikExtern => True);
      
      case
        KartenQuadrantWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern <= 1
      then
         SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                     KoordinatenExtern => KartenQuadrantWert);
         
      elsif
        SichtweiteYRichtungExtern in 2 .. 3
        and
          SichtweiteXRichtungExtern <= 1
      then
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in 0 .. SichtweiteXRichtungExtern loop
                    
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                                                 XÄnderungExtern   => XÄnderungSchleifenwert,
                                                                                 SichtweiteExtern  => SichtweiteExtern)
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern in 2 .. 3
      then
         YÄnderungSchleife22:
         for YÄnderungSchleifenwert in 0 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife22:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
               
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert,
                                                                                 XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                                                 SichtweiteExtern  => SichtweiteExtern)
               then
                  exit YÄnderungSchleife22;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife22;
         end loop YÄnderungSchleife22;
               
      else
         YÄnderungSchleife333:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife333:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
                                       
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                                                 XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                                                 SichtweiteExtern  => SichtweiteExtern)
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife333;
         end loop YÄnderungSchleife333;
      end if;
                  
   end QuadrantDrei;
   
   
   
   procedure QuadrantVier
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteExtern : in KartenDatentypen.Sichtweite;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
                    
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, -SichtweiteYRichtungExtern, -SichtweiteXRichtungExtern),
                                                                                                        LogikGrafikExtern => True);
      
      case
        KartenQuadrantWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern <= 1
      then
         SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                     KoordinatenExtern => KartenQuadrantWert);
               
      elsif
        SichtweiteYRichtungExtern in 2 .. 3
        and
          SichtweiteXRichtungExtern <= 1
      then
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in 0 .. SichtweiteXRichtungExtern loop
               
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                                                 XÄnderungExtern   => XÄnderungSchleifenwert,
                                                                                 SichtweiteExtern  => SichtweiteExtern)
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern in 2 .. 3
      then
         YÄnderungSchleife22:
         for YÄnderungSchleifenwert in 0 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife22:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
               
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => YÄnderungSchleifenwert,
                                                                                 XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                                                 SichtweiteExtern  => SichtweiteExtern)
               then
                  exit YÄnderungSchleife22;
                  
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife22;
         end loop YÄnderungSchleife22;
               
      else
         YÄnderungSchleife333:
         for YÄnderungSchleifenwert in 2 .. SichtweiteYRichtungExtern loop
            XÄnderungSchleife333:
            for XÄnderungSchleifenwert in 2 .. SichtweiteXRichtungExtern loop
                     
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                                                 XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                                                 SichtweiteExtern  => SichtweiteExtern)
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife333;
         end loop YÄnderungSchleife333;
      end if;
                  
   end QuadrantVier;

end QuadrantenberechnungenLogik;
