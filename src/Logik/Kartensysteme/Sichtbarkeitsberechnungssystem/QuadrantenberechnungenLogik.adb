with SystemDatentypen;
with KartenDatentypen;

with KartenkoordinatenberechnungssystemLogik;
with SichtbarkeitSetzenLogik;
with SichtbereicheErmittelnLogik;

-- Das hier alles noch einmal durchschauen, irgendwas stimmt eventuell nicht. äöü
package body QuadrantenberechnungenLogik is

   procedure QuadrantenDurchlaufen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      YQuadrantSchleife:
      for YQuadrantSchleifenwert in 0 .. SichtweiteExtern.Senkrechte loop
         XQuadrantSchleife:
         for XQuadrantSchleifenwert in 0 .. SichtweiteExtern.Waagerechte loop
            
            QuadrantEins (SpeziesExtern            => SpeziesExtern,
                          SichtweiteRichtungExtern => (YQuadrantSchleifenwert, XQuadrantSchleifenwert),
                          SichtweiteExtern         => SichtweiteExtern,
                          KoordinatenExtern        => KoordinatenExtern);
            
            case
              YQuadrantSchleifenwert
            is
               when 0 =>
                  null;
                  
               when others =>
                  QuadrantZwei (SpeziesExtern            => SpeziesExtern,
                                SichtweiteRichtungExtern => (YQuadrantSchleifenwert, XQuadrantSchleifenwert),
                                SichtweiteExtern         => SichtweiteExtern,
                                KoordinatenExtern        => KoordinatenExtern);
            end case;
      
            case
              XQuadrantSchleifenwert
            is
               when 0 =>
                  null;
                  
               when others =>
                  QuadrantDrei (SpeziesExtern            => SpeziesExtern,
                                SichtweiteRichtungExtern => (YQuadrantSchleifenwert, XQuadrantSchleifenwert),
                                SichtweiteExtern         => SichtweiteExtern,
                                KoordinatenExtern        => KoordinatenExtern);
            end case;
      
            if
              YQuadrantSchleifenwert = 0
              and
                XQuadrantSchleifenwert = 0
            then
               null;
               
            else
               QuadrantVier (SpeziesExtern            => SpeziesExtern,
                             SichtweiteRichtungExtern => (YQuadrantSchleifenwert, XQuadrantSchleifenwert),
                             SichtweiteExtern         => SichtweiteExtern,
                             KoordinatenExtern        => KoordinatenExtern);
            end if;
            
         end loop XQuadrantSchleife;
      end loop YQuadrantSchleife;
      
   end QuadrantenDurchlaufen;
   
   
   
   procedure QuadrantEins
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
              
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung,
                                                                                                                               -SichtweiteRichtungExtern.YAchse,
                                                                                                                               SichtweiteRichtungExtern.XAchse),
                                                                                                        TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      case
        KartenQuadrantWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        SichtweiteRichtungExtern.YAchse <= 1
        and
          SichtweiteRichtungExtern.XAchse <= 1
      then
         SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                     KoordinatenExtern => KartenQuadrantWert);
               
      elsif
        SichtweiteRichtungExtern.YAchse in 2 .. 3
        and
          SichtweiteRichtungExtern.XAchse <= 1
      then
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.YAchse loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.XAchse loop
                    
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteRichtungExtern.YAchse
                 and
                   XÄnderungSchleifenwert = SichtweiteRichtungExtern.XAchse
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
               
      elsif
        SichtweiteRichtungExtern.YAchse <= 1
        and
          SichtweiteRichtungExtern.XAchse in 2 .. 3
      then
         YÄnderungSchleife22:
         for YÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.YAchse loop
            XÄnderungSchleife22:
            for XÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.XAchse loop
                                 
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => YÄnderungSchleifenwert,
                                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit YÄnderungSchleife22;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteRichtungExtern.YAchse
                 and
                   XÄnderungSchleifenwert = SichtweiteRichtungExtern.XAchse
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
         for YÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.YAchse loop
            XÄnderungSchleife333:
            for XÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.XAchse loop
                     
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteRichtungExtern.YAchse
                 and
                   XÄnderungSchleifenwert = SichtweiteRichtungExtern.XAchse
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
                    
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung,
                                                                                                                               SichtweiteRichtungExtern.YAchse,
                                                                                                                               SichtweiteRichtungExtern.XAchse),
                                                                                                        TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      case
        KartenQuadrantWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        SichtweiteRichtungExtern.YAchse <= 1
        and
          SichtweiteRichtungExtern.XAchse <= 1
      then
         SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                     KoordinatenExtern => KartenQuadrantWert);
               
      elsif
        SichtweiteRichtungExtern.YAchse in 2 .. 3
        and
          SichtweiteRichtungExtern.XAchse <= 1
      then
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.YAchse loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.XAchse loop
                                         
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteRichtungExtern.YAchse
                 and
                   XÄnderungSchleifenwert = SichtweiteRichtungExtern.XAchse
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
               
      elsif
        SichtweiteRichtungExtern.YAchse <= 1
        and
          SichtweiteRichtungExtern.XAchse in 2 .. 3
      then
         YÄnderungSchleife22:
         for YÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.YAchse loop
            XÄnderungSchleife22:
            for XÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.XAchse loop
                                 
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert,
                                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit YÄnderungSchleife22;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteRichtungExtern.YAchse
                 and
                   XÄnderungSchleifenwert = SichtweiteRichtungExtern.XAchse
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
         for YÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.YAchse loop
            XÄnderungSchleife333:
            for XÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.XAchse loop
                     
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteRichtungExtern.YAchse
                 and
                   XÄnderungSchleifenwert = SichtweiteRichtungExtern.XAchse
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
                    
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung,
                                                                                                                               SichtweiteRichtungExtern.YAchse,
                                                                                                                               -SichtweiteRichtungExtern.XAchse),
                                                                                                        TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      case
        KartenQuadrantWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        SichtweiteRichtungExtern.YAchse <= 1
        and
          SichtweiteRichtungExtern.XAchse <= 1
      then
         SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                     KoordinatenExtern => KartenQuadrantWert);
         
      elsif
        SichtweiteRichtungExtern.YAchse in 2 .. 3
        and
          SichtweiteRichtungExtern.XAchse <= 1
      then
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.YAchse loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.XAchse loop
                    
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                                                 XÄnderungExtern   => XÄnderungSchleifenwert,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteRichtungExtern.YAchse
                 and
                   XÄnderungSchleifenwert = SichtweiteRichtungExtern.XAchse
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
               
      elsif
        SichtweiteRichtungExtern.YAchse <= 1
        and
          SichtweiteRichtungExtern.XAchse in 2 .. 3
      then
         YÄnderungSchleife22:
         for YÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.YAchse loop
            XÄnderungSchleife22:
            for XÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.XAchse loop
               
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert,
                                                                                 XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit YÄnderungSchleife22;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteRichtungExtern.YAchse
                 and
                   XÄnderungSchleifenwert = SichtweiteRichtungExtern.XAchse
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
         for YÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.YAchse loop
            XÄnderungSchleife333:
            for XÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.XAchse loop
                                       
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                                                 XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteRichtungExtern.YAchse
                 and
                   XÄnderungSchleifenwert = SichtweiteRichtungExtern.XAchse
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
                    
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung,
                                                                                                                               -SichtweiteRichtungExtern.YAchse,
                                                                                                                               -SichtweiteRichtungExtern.XAchse),
                                                                                                        TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      case
        KartenQuadrantWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        SichtweiteRichtungExtern.YAchse <= 1
        and
          SichtweiteRichtungExtern.XAchse <= 1
      then
         SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                     KoordinatenExtern => KartenQuadrantWert);
               
      elsif
        SichtweiteRichtungExtern.YAchse in 2 .. 3
        and
          SichtweiteRichtungExtern.XAchse <= 1
      then
         YÄnderungSchleife:
         for YÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.YAchse loop
            XÄnderungSchleife:
            for XÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.XAchse loop
               
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                                                 XÄnderungExtern   => XÄnderungSchleifenwert,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteRichtungExtern.YAchse
                 and
                   XÄnderungSchleifenwert = SichtweiteRichtungExtern.XAchse
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife;
         end loop YÄnderungSchleife;
               
      elsif
        SichtweiteRichtungExtern.YAchse <= 1
        and
          SichtweiteRichtungExtern.XAchse in 2 .. 3
      then
         YÄnderungSchleife22:
         for YÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.YAchse loop
            XÄnderungSchleife22:
            for XÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.XAchse loop
               
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => YÄnderungSchleifenwert,
                                                                                 XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit YÄnderungSchleife22;
                  
               elsif
                 YÄnderungSchleifenwert = SichtweiteRichtungExtern.YAchse
                 and
                   XÄnderungSchleifenwert = SichtweiteRichtungExtern.XAchse
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
         for YÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.YAchse loop
            XÄnderungSchleife333:
            for XÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.XAchse loop
                     
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                                                 XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteRichtungExtern.YAchse
                 and
                   XÄnderungSchleifenwert = SichtweiteRichtungExtern.XAchse
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
