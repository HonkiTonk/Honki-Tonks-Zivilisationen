pragma SPARK_Mode (On);

with EinheitenDatenbank;
  
with KartePositionPruefen, EinheitSuchen, StadtSuchen, Diplomatie;

package body Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürRasse
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop

         case
           GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummerSchleifenwert).ID
         is
            when 0 =>
               null;
            
            when others =>
               SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert));
         end case;
         
      end loop EinheitenSchleife;

      StädteSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop

         case
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).ID
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               SichtbarkeitsprüfungFürStadt (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert));
         end case;
         
      end loop StädteSchleife;
      
   end SichtbarkeitsprüfungFürRasse;



   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (GlobaleDatentypen.Luft) = True
        or
          EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                             GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Passierbarkeit (GlobaleDatentypen.Weltraum) = True
      then
         SichtbarkeitsprüfungOhneBlockade (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                            SichtweiteExtern         => 3);
         return;
         
      else
         null;
      end if;
      
      KoordinatenEinheit := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position;
      AktuellerGrund := Karten.Weltkarte (KoordinatenEinheit.EAchse, KoordinatenEinheit.YAchse, KoordinatenEinheit.XAchse).Grund;
      
      if
        AktuellerGrund = GlobaleDatentypen.Gebirge
        or
          AktuellerGrund = GlobaleDatentypen.Hügel
          or
            Karten.Weltkarte (KoordinatenEinheit.EAchse, KoordinatenEinheit.YAchse, KoordinatenEinheit.XAchse).Hügel = True
      then
         SichtweiteObjekt := 3;

      elsif
        AktuellerGrund = GlobaleDatentypen.Dschungel
        or
          AktuellerGrund = GlobaleDatentypen.Sumpf
          or
            AktuellerGrund = GlobaleDatentypen.Wald
      then
         SichtbarkeitsprüfungOhneBlockade (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                            SichtweiteExtern         => 1);
         return;
               
      else
         SichtweiteObjekt := 2;
      end if;

      YQuadrantSchleife:
      for YQuadrantSchleifenwert in 0 .. SichtweiteObjekt loop
         XQuadrantSchleife:
         for XQuadrantSchleifenwert in 0 .. SichtweiteObjekt loop
            
            QuadrantEins (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                          SichtweiteYRichtungExtern => YQuadrantSchleifenwert,
                          SichtweiteXRichtungExtern => XQuadrantSchleifenwert,
                          SichtweiteMaximalExtern   => SichtweiteObjekt);
            
            case
              YQuadrantSchleifenwert
            is
               when 0 =>
                  null;
                  
               when others =>
                  QuadrantZwei (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                SichtweiteYRichtungExtern => YQuadrantSchleifenwert,
                                SichtweiteXRichtungExtern => XQuadrantSchleifenwert,
                                SichtweiteMaximalExtern   => SichtweiteObjekt);
            end case;
      
            case
              XQuadrantSchleifenwert
            is
               when 0 =>
                  null;
                  
               when others =>
                  QuadrantDrei (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                SichtweiteYRichtungExtern => YQuadrantSchleifenwert,
                                SichtweiteXRichtungExtern => XQuadrantSchleifenwert,
                                SichtweiteMaximalExtern   => SichtweiteObjekt);
            end case;
      
            if
              YQuadrantSchleifenwert = 0
              and
                XQuadrantSchleifenwert = 0
            then
               null;
               
            else
               QuadrantVier (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                             SichtweiteYRichtungExtern => YQuadrantSchleifenwert,
                             SichtweiteXRichtungExtern => XQuadrantSchleifenwert,
                             SichtweiteMaximalExtern   => SichtweiteObjekt);
            end if;
            
         end loop XQuadrantSchleife;
      end loop YQuadrantSchleife;
      
   end SichtbarkeitsprüfungFürEinheit;
   
   
   
   procedure QuadrantEins
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern, SichtweiteXRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in GlobaleDatentypen.Sichtweite)
   is begin
              
      KartenQuadrantWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenEinheit,
                                                                          ÄnderungExtern    => (0, -SichtweiteYRichtungExtern, SichtweiteXRichtungExtern));
            
      if
        KartenQuadrantWert.XAchse = 0
      then
         null;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern <= 1
      then
         SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
                    
               SichtbarkeitTesten := SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                 YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert,
                                                                 SichtweiteExtern  => SichtweiteMaximalExtern);
                     
               if
                 SichtbarkeitTesten = False
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
               
               SichtbarkeitTesten := SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                 YÄnderungExtern   => YÄnderungSchleifenwert,
                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                                 SichtweiteExtern  => SichtweiteMaximalExtern);
                  
               if
                 SichtbarkeitTesten = False
               then
                  exit YÄnderungSchleife22;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
                     
               SichtbarkeitTesten := SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                 YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                                 SichtweiteExtern  => SichtweiteMaximalExtern);
                  
               if
                 SichtbarkeitTesten = False
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife333;
         end loop YÄnderungSchleife333;
      end if;
      
   end QuadrantEins;
   
   
   
   procedure QuadrantZwei
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern, SichtweiteXRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in GlobaleDatentypen.Sichtweite)
   is begin
                    
      KartenQuadrantWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenEinheit,
                                                                          ÄnderungExtern    => (0, SichtweiteYRichtungExtern, SichtweiteXRichtungExtern));
            
      if
        KartenQuadrantWert.XAchse = 0
      then
         null;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern <= 1
      then
         SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
                    
               SichtbarkeitTesten := SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert,
                                                                 SichtweiteExtern  => SichtweiteMaximalExtern);
                     
               if
                 SichtbarkeitTesten = False
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
               
               SichtbarkeitTesten := SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert,
                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                                 SichtweiteExtern  => SichtweiteMaximalExtern);
                  
               if
                 SichtbarkeitTesten = False
               then
                  exit YÄnderungSchleife22;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
                     
               SichtbarkeitTesten := SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                                 XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                                 SichtweiteExtern  => SichtweiteMaximalExtern);
                  
               if
                 SichtbarkeitTesten = False
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife333;
         end loop YÄnderungSchleife333;
      end if;            
                  
   end QuadrantZwei;
   
   
   
   procedure QuadrantDrei
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern, SichtweiteXRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in GlobaleDatentypen.Sichtweite)
   is begin
                    
      KartenQuadrantWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenEinheit,
                                                                          ÄnderungExtern    => (0, SichtweiteYRichtungExtern, -SichtweiteXRichtungExtern));
            
      if
        KartenQuadrantWert.XAchse = 0
      then
         null;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern <= 1
      then
         SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
                    
               SichtbarkeitTesten := SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                                 XÄnderungExtern   => XÄnderungSchleifenwert,
                                                                 SichtweiteExtern  => SichtweiteMaximalExtern);
                     
               if
                 SichtbarkeitTesten = False
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
               
               SichtbarkeitTesten := SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert,
                                                                 XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                                 SichtweiteExtern  => SichtweiteMaximalExtern);
                  
               if
                 SichtbarkeitTesten = False
               then
                  exit YÄnderungSchleife22;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
                     
               SichtbarkeitTesten := SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                 YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                                 XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                                 SichtweiteExtern  => SichtweiteMaximalExtern);
                  
               if
                 SichtbarkeitTesten = False
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife333;
         end loop YÄnderungSchleife333;
      end if;            
                  
   end QuadrantDrei;
   
   
   
   procedure QuadrantVier
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern, SichtweiteXRichtungExtern : in GlobaleDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in GlobaleDatentypen.Sichtweite)
   is begin
                    
      KartenQuadrantWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenEinheit,
                                                                          ÄnderungExtern    => (0, -SichtweiteYRichtungExtern, -SichtweiteXRichtungExtern));
            
      if
        KartenQuadrantWert.XAchse = 0
      then
         null;
               
      elsif
        SichtweiteYRichtungExtern <= 1
        and
          SichtweiteXRichtungExtern <= 1
      then
         SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
                    
               SichtbarkeitTesten := SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                 YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                                 XÄnderungExtern   => XÄnderungSchleifenwert,
                                                                 SichtweiteExtern  => SichtweiteMaximalExtern);
                     
               if
                 SichtbarkeitTesten = False
               then
                  exit YÄnderungSchleife;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
               
               SichtbarkeitTesten := SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                 YÄnderungExtern   => YÄnderungSchleifenwert,
                                                                 XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                                 SichtweiteExtern  => SichtweiteMaximalExtern);
                  
               if
                 SichtbarkeitTesten = False
               then
                  exit YÄnderungSchleife22;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
                     
               SichtbarkeitTesten := SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                                 YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                                 XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                                 SichtweiteExtern  => SichtweiteMaximalExtern);
                  
               if
                 SichtbarkeitTesten = False
               then
                  exit YÄnderungSchleife333;
                        
               elsif
                 YÄnderungSchleifenwert = SichtweiteYRichtungExtern
                 and
                   XÄnderungSchleifenwert = SichtweiteXRichtungExtern
               then
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenQuadrantWert);
                        
               else
                  null;
               end if;
                     
            end loop XÄnderungSchleife333;
         end loop YÄnderungSchleife333;
      end if;            
                  
   end QuadrantVier;
   
   
   
   function SichtbarkeitBlockadeTesten
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      YÄnderungExtern, XÄnderungExtern : in GlobaleDatentypen.LoopRangeMinusZweiZuZwei;
      SichtweiteExtern : in GlobaleDatentypen.LoopRangeMinusDreiZuDrei)
      return Boolean
   is begin
      
      KartenBlockadeWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                          ÄnderungExtern    => (0, YÄnderungExtern, XÄnderungExtern));
      if
        KartenBlockadeWert.XAchse = 0
      then
         null;
         
      elsif
        Karten.Weltkarte (KartenBlockadeWert.EAchse, KartenBlockadeWert.YAchse, KartenBlockadeWert.XAchse).Grund = GlobaleDatentypen.Gebirge
        or
          Karten.Weltkarte (KartenBlockadeWert.EAchse, KartenBlockadeWert.YAchse, KartenBlockadeWert.XAchse).Grund = GlobaleDatentypen.Hügel
        or
          Karten.Weltkarte (KartenBlockadeWert.EAchse, KartenBlockadeWert.YAchse, KartenBlockadeWert.XAchse).Hügel = True
        or
          (SichtweiteExtern /= 3
           and
             (Karten.Weltkarte (KartenBlockadeWert.EAchse, KartenBlockadeWert.YAchse, KartenBlockadeWert.XAchse).Grund = GlobaleDatentypen.Dschungel
              or
                Karten.Weltkarte (KartenBlockadeWert.EAchse, KartenBlockadeWert.YAchse, KartenBlockadeWert.XAchse).Grund = GlobaleDatentypen.Sumpf
              or
                Karten.Weltkarte (KartenBlockadeWert.EAchse, KartenBlockadeWert.YAchse, KartenBlockadeWert.XAchse).Grund = GlobaleDatentypen.Wald))
      then
         return False;
         
      else
         null;
      end if;
      
      return True;
      
   end SichtbarkeitBlockadeTesten;
   
   
   
   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      SichtweiteExtern : in GlobaleDatentypen.Sichtweite)
   is begin
         
      YÄnderungEinheitenSchleife:
      for YÄnderungSchleifenwert in -SichtweiteExtern .. SichtweiteExtern loop            
         XÄnderungEinheitenSchleife:
         for XÄnderungSchleifenwert in -SichtweiteExtern .. SichtweiteExtern loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            case
              KartenWert.YAchse
            is
               when 0 =>
                  null;
                  
               when others =>            
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenWert);
            end case;
            
         end loop XÄnderungEinheitenSchleife;
      end loop YÄnderungEinheitenSchleife;
      
   end SichtbarkeitsprüfungOhneBlockade;



   procedure SichtbarkeitsprüfungFürStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) < 10
      then
         SichtweiteObjekt := 2;
            
      else
         SichtweiteObjekt := 3;
      end if;

      YÄnderungStadtSchleife:         
      for YÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop            
         XÄnderungStadtSchleife:
         for XÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                                                        ÄnderungExtern      => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            case
              KartenWert.YAchse
            is
               when 0 =>
                  null;
                  
               when others =>            
                  SichtbarkeitSetzen (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenWert);
            end case;
                        
         end loop XÄnderungStadtSchleife;
      end loop YÄnderungStadtSchleife;
      
   end SichtbarkeitsprüfungFürStadt;
   
   
   
   procedure SichtbarkeitSetzen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
   is begin      
      
      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Sichtbar (RasseExtern)
      is
         when True =>
            return;
            
         when False =>
            Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Sichtbar (RasseExtern) := True;
      end case;
      
      FremdeEinheitStadt := EinheitSuchen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => RasseExtern,
                                                                                      KoordinatenExtern => KoordinatenExtern);
      
      case
        FremdeEinheitStadt.Rasse
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Diplomatie.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                    FremdeRasseExtern => FremdeEinheitStadt.Rasse);
            return;
      end case;
      
      FremdeEinheitStadt := StadtSuchen.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => RasseExtern,
                                                                                  KoordinatenExtern => KoordinatenExtern);
      
      case
        FremdeEinheitStadt.Rasse
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            Diplomatie.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                    FremdeRasseExtern => FremdeEinheitStadt.Rasse);
      end case;
      
   end SichtbarkeitSetzen;

end Sichtbarkeit;
