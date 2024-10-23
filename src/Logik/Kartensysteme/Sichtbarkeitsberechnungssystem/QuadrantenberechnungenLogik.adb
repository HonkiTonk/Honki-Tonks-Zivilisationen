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
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
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
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
              
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung,
                                                                                                                               -SichtweiteRichtungExtern.Senkrechte,
                                                                                                                               SichtweiteRichtungExtern.Waagerechte),
                                                                                                        TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      case
        KartenQuadrantWert.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechte =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        SichtweiteRichtungExtern.Senkrechte <= 1
        and
          SichtweiteRichtungExtern.Waagerechte <= 1
      then
         SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                     KoordinatenExtern => KartenQuadrantWert);
               
      elsif
        SichtweiteRichtungExtern.Senkrechte in 2 .. 3
        and
          SichtweiteRichtungExtern.Waagerechte <= 1
      then
         SenkrechteÄnderungSchleife:
         for SenkrechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Senkrechte loop
            WaagerechteÄnderungSchleife:
            for WaagerechteÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.Waagerechte loop
                    
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 SenkrechteÄnderungExtern   => SenkrechteÄnderungSchleifenwert - 1,
                                                                                 WaagerechteÄnderungExtern   => -WaagerechteÄnderungSchleifenwert,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit SenkrechteÄnderungSchleife;
                        
               elsif
                 SenkrechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Senkrechte
                 and
                   WaagerechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Waagerechte
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop WaagerechteÄnderungSchleife;
         end loop SenkrechteÄnderungSchleife;
               
      elsif
        SichtweiteRichtungExtern.Senkrechte <= 1
        and
          SichtweiteRichtungExtern.Waagerechte in 2 .. 3
      then
         SenkrechteÄnderungSchleife22:
         for SenkrechteÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.Senkrechte loop
            WaagerechteÄnderungSchleife22:
            for WaagerechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Waagerechte loop
                                 
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 SenkrechteÄnderungExtern   => SenkrechteÄnderungSchleifenwert,
                                                                                 WaagerechteÄnderungExtern   => -WaagerechteÄnderungSchleifenwert + 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit SenkrechteÄnderungSchleife22;
                        
               elsif
                 SenkrechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Senkrechte
                 and
                   WaagerechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Waagerechte
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop WaagerechteÄnderungSchleife22;
         end loop SenkrechteÄnderungSchleife22;
               
      else
         SenkrechteÄnderungSchleife333:
         for SenkrechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Senkrechte loop
            WaagerechteÄnderungSchleife333:
            for WaagerechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Waagerechte loop
                     
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 SenkrechteÄnderungExtern   => SenkrechteÄnderungSchleifenwert - 1,
                                                                                 WaagerechteÄnderungExtern   => -WaagerechteÄnderungSchleifenwert + 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit SenkrechteÄnderungSchleife333;
                        
               elsif
                 SenkrechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Senkrechte
                 and
                   WaagerechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Waagerechte
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop WaagerechteÄnderungSchleife333;
         end loop SenkrechteÄnderungSchleife333;
      end if;
      
   end QuadrantEins;
   
   
   
   procedure QuadrantZwei
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
                    
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung,
                                                                                                                               SichtweiteRichtungExtern.Senkrechte,
                                                                                                                               SichtweiteRichtungExtern.Waagerechte),
                                                                                                        TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      case
        KartenQuadrantWert.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechte =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        SichtweiteRichtungExtern.Senkrechte <= 1
        and
          SichtweiteRichtungExtern.Waagerechte <= 1
      then
         SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                     KoordinatenExtern => KartenQuadrantWert);
               
      elsif
        SichtweiteRichtungExtern.Senkrechte in 2 .. 3
        and
          SichtweiteRichtungExtern.Waagerechte <= 1
      then
         SenkrechteÄnderungSchleife:
         for SenkrechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Senkrechte loop
            WaagerechteÄnderungSchleife:
            for WaagerechteÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.Waagerechte loop
                                         
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 SenkrechteÄnderungExtern   => -SenkrechteÄnderungSchleifenwert + 1,
                                                                                 WaagerechteÄnderungExtern   => -WaagerechteÄnderungSchleifenwert,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit SenkrechteÄnderungSchleife;
                        
               elsif
                 SenkrechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Senkrechte
                 and
                   WaagerechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Waagerechte
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop WaagerechteÄnderungSchleife;
         end loop SenkrechteÄnderungSchleife;
               
      elsif
        SichtweiteRichtungExtern.Senkrechte <= 1
        and
          SichtweiteRichtungExtern.Waagerechte in 2 .. 3
      then
         SenkrechteÄnderungSchleife22:
         for SenkrechteÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.Senkrechte loop
            WaagerechteÄnderungSchleife22:
            for WaagerechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Waagerechte loop
                                 
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 SenkrechteÄnderungExtern   => -SenkrechteÄnderungSchleifenwert,
                                                                                 WaagerechteÄnderungExtern   => -WaagerechteÄnderungSchleifenwert + 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit SenkrechteÄnderungSchleife22;
                        
               elsif
                 SenkrechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Senkrechte
                 and
                   WaagerechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Waagerechte
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop WaagerechteÄnderungSchleife22;
         end loop SenkrechteÄnderungSchleife22;
               
      else
         SenkrechteÄnderungSchleife333:
         for SenkrechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Senkrechte loop
            WaagerechteÄnderungSchleife333:
            for WaagerechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Waagerechte loop
                     
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 SenkrechteÄnderungExtern   => -SenkrechteÄnderungSchleifenwert + 1,
                                                                                 WaagerechteÄnderungExtern   => -WaagerechteÄnderungSchleifenwert + 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit SenkrechteÄnderungSchleife333;
                        
               elsif
                 SenkrechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Senkrechte
                 and
                   WaagerechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Waagerechte
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop WaagerechteÄnderungSchleife333;
         end loop SenkrechteÄnderungSchleife333;
      end if;
                  
   end QuadrantZwei;
   
   
   
   procedure QuadrantDrei
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
                    
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung,
                                                                                                                               SichtweiteRichtungExtern.Senkrechte,
                                                                                                                               -SichtweiteRichtungExtern.Waagerechte),
                                                                                                        TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      case
        KartenQuadrantWert.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechte =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        SichtweiteRichtungExtern.Senkrechte <= 1
        and
          SichtweiteRichtungExtern.Waagerechte <= 1
      then
         SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                     KoordinatenExtern => KartenQuadrantWert);
         
      elsif
        SichtweiteRichtungExtern.Senkrechte in 2 .. 3
        and
          SichtweiteRichtungExtern.Waagerechte <= 1
      then
         SenkrechteÄnderungSchleife:
         for SenkrechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Senkrechte loop
            WaagerechteÄnderungSchleife:
            for WaagerechteÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.Waagerechte loop
                    
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 SenkrechteÄnderungExtern   => -SenkrechteÄnderungSchleifenwert + 1,
                                                                                 WaagerechteÄnderungExtern   => WaagerechteÄnderungSchleifenwert,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit SenkrechteÄnderungSchleife;
                        
               elsif
                 SenkrechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Senkrechte
                 and
                   WaagerechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Waagerechte
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop WaagerechteÄnderungSchleife;
         end loop SenkrechteÄnderungSchleife;
               
      elsif
        SichtweiteRichtungExtern.Senkrechte <= 1
        and
          SichtweiteRichtungExtern.Waagerechte in 2 .. 3
      then
         SenkrechteÄnderungSchleife22:
         for SenkrechteÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.Senkrechte loop
            WaagerechteÄnderungSchleife22:
            for WaagerechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Waagerechte loop
               
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 SenkrechteÄnderungExtern   => -SenkrechteÄnderungSchleifenwert,
                                                                                 WaagerechteÄnderungExtern   => WaagerechteÄnderungSchleifenwert - 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit SenkrechteÄnderungSchleife22;
                        
               elsif
                 SenkrechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Senkrechte
                 and
                   WaagerechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Waagerechte
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop WaagerechteÄnderungSchleife22;
         end loop SenkrechteÄnderungSchleife22;
               
      else
         SenkrechteÄnderungSchleife333:
         for SenkrechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Senkrechte loop
            WaagerechteÄnderungSchleife333:
            for WaagerechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Waagerechte loop
                                       
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 SenkrechteÄnderungExtern   => -SenkrechteÄnderungSchleifenwert + 1,
                                                                                 WaagerechteÄnderungExtern   => WaagerechteÄnderungSchleifenwert - 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit SenkrechteÄnderungSchleife333;
                        
               elsif
                 SenkrechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Senkrechte
                 and
                   WaagerechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Waagerechte
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop WaagerechteÄnderungSchleife333;
         end loop SenkrechteÄnderungSchleife333;
      end if;
                  
   end QuadrantDrei;
   
   
   
   procedure QuadrantVier
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtweiteRichtungExtern : in KartenRecords.SichtweiteNaturalRecord;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
                    
      KartenQuadrantWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                        ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung,
                                                                                                                               -SichtweiteRichtungExtern.Senkrechte,
                                                                                                                               -SichtweiteRichtungExtern.Waagerechte),
                                                                                                        TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      case
        KartenQuadrantWert.Waagerechte
      is
         when KartenKonstanten.LeerWaagerechte =>
            return;
            
         when others =>
            null;
      end case;
      
      if
        SichtweiteRichtungExtern.Senkrechte <= 1
        and
          SichtweiteRichtungExtern.Waagerechte <= 1
      then
         SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                     KoordinatenExtern => KartenQuadrantWert);
               
      elsif
        SichtweiteRichtungExtern.Senkrechte in 2 .. 3
        and
          SichtweiteRichtungExtern.Waagerechte <= 1
      then
         SenkrechteÄnderungSchleife:
         for SenkrechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Senkrechte loop
            WaagerechteÄnderungSchleife:
            for WaagerechteÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.Waagerechte loop
               
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 SenkrechteÄnderungExtern   => SenkrechteÄnderungSchleifenwert - 1,
                                                                                 WaagerechteÄnderungExtern   => WaagerechteÄnderungSchleifenwert,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit SenkrechteÄnderungSchleife;
                        
               elsif
                 SenkrechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Senkrechte
                 and
                   WaagerechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Waagerechte
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop WaagerechteÄnderungSchleife;
         end loop SenkrechteÄnderungSchleife;
               
      elsif
        SichtweiteRichtungExtern.Senkrechte <= 1
        and
          SichtweiteRichtungExtern.Waagerechte in 2 .. 3
      then
         SenkrechteÄnderungSchleife22:
         for SenkrechteÄnderungSchleifenwert in 0 .. SichtweiteRichtungExtern.Senkrechte loop
            WaagerechteÄnderungSchleife22:
            for WaagerechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Waagerechte loop
               
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 SenkrechteÄnderungExtern   => SenkrechteÄnderungSchleifenwert,
                                                                                 WaagerechteÄnderungExtern   => WaagerechteÄnderungSchleifenwert - 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit SenkrechteÄnderungSchleife22;
                  
               elsif
                 SenkrechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Senkrechte
                 and
                   WaagerechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Waagerechte
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop WaagerechteÄnderungSchleife22;
         end loop SenkrechteÄnderungSchleife22;
               
      else
         SenkrechteÄnderungSchleife333:
         for SenkrechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Senkrechte loop
            WaagerechteÄnderungSchleife333:
            for WaagerechteÄnderungSchleifenwert in 2 .. SichtweiteRichtungExtern.Waagerechte loop
                     
               if
                 False = SichtbereicheErmittelnLogik.SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                                 SenkrechteÄnderungExtern   => SenkrechteÄnderungSchleifenwert - 1,
                                                                                 WaagerechteÄnderungExtern   => WaagerechteÄnderungSchleifenwert - 1,
                                                                                 SichtweiteExtern  => (SichtweiteExtern.Senkrechte, SichtweiteExtern.Waagerechte))
               then
                  exit SenkrechteÄnderungSchleife333;
                        
               elsif
                 SenkrechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Senkrechte
                 and
                   WaagerechteÄnderungSchleifenwert = SichtweiteRichtungExtern.Waagerechte
               then
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => SpeziesExtern,
                                                              KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop WaagerechteÄnderungSchleife333;
         end loop SenkrechteÄnderungSchleife333;
      end if;
                  
   end QuadrantVier;

end QuadrantenberechnungenLogik;
