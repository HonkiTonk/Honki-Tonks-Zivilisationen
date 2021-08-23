pragma SPARK_Mode (On);

with GlobaleKonstanten;
  
with KartePositionPruefen, EinheitSuchen, StadtSuchen, KennenLernen, LeseKarten, SchreibeKarten, LeseEinheitenGebaut, LeseEinheitenDatenbank, LeseStadtGebaut;

package body Sichtbarkeit is

   procedure SichtbarkeitsprüfungFürRasse
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop

         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert))
         is
            when GlobaleKonstanten.LeerEinheitenID =>
               null;
            
            when others =>
               SichtbarkeitsprüfungFürEinheit (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert));
         end case;
         
      end loop EinheitenSchleife;

      StädteSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop

         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert))
         is
            when GlobaleKonstanten.LeerStadtID =>
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
        (LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                WelcheUmgebungExtern => GlobaleDatentypen.Luft) = True
         or
           LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                  IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                  WelcheUmgebungExtern => GlobaleDatentypen.Weltraum) = True)
        and
          LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern).EAchse >= 0
      then
         SichtbarkeitsprüfungOhneBlockade (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                            SichtweiteExtern         => 3);
         return;
         
      else
         KoordinatenEinheit := LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         AktuellerGrund := LeseKarten.Grund (PositionExtern => KoordinatenEinheit);
      end if;
      
      if
        AktuellerGrund = GlobaleDatentypen.Gebirge
        or
          AktuellerGrund = GlobaleDatentypen.Hügel
          or
            LeseKarten.Hügel (PositionExtern => KoordinatenEinheit) = True
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
        KartenQuadrantWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
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
                    
               if
                 SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                             YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                             XÄnderungExtern   => -XÄnderungSchleifenwert,
                                             SichtweiteExtern  => SichtweiteMaximalExtern) = False
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
                                 
               if
                 SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                             YÄnderungExtern   => YÄnderungSchleifenwert,
                                             XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                             SichtweiteExtern  => SichtweiteMaximalExtern) = False
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
                     
               if
                 SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                             YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                             XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                             SichtweiteExtern  => SichtweiteMaximalExtern) = False
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
        KartenQuadrantWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
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
                                         
               if
                 SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                             YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                             XÄnderungExtern   => -XÄnderungSchleifenwert,
                                             SichtweiteExtern  => SichtweiteMaximalExtern) = False
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
                                 
               if
                 SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                             YÄnderungExtern   => -YÄnderungSchleifenwert,
                                             XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                             SichtweiteExtern  => SichtweiteMaximalExtern) = False
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
                     
               if
                 SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                             YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                             XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                             SichtweiteExtern  => SichtweiteMaximalExtern) = False
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
        KartenQuadrantWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
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
                    
               if
                 SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                             YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                             XÄnderungExtern   => XÄnderungSchleifenwert,
                                             SichtweiteExtern  => SichtweiteMaximalExtern) = False
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
               
               if
                 SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                             YÄnderungExtern   => -YÄnderungSchleifenwert,
                                             XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                             SichtweiteExtern  => SichtweiteMaximalExtern) = False
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
                                       
               if
                 SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                             YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                             XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                             SichtweiteExtern  => SichtweiteMaximalExtern) = False
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
        KartenQuadrantWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
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
               
               if
                 SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                             YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                             XÄnderungExtern   => XÄnderungSchleifenwert,
                                             SichtweiteExtern  => SichtweiteMaximalExtern) = False
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
               
               if
                 SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                             YÄnderungExtern   => YÄnderungSchleifenwert,
                                             XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                             SichtweiteExtern  => SichtweiteMaximalExtern) = False
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
                     
               if
                 SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                             YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                             XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                             SichtweiteExtern  => SichtweiteMaximalExtern) = False
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
        KartenBlockadeWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
      then
         null;
         
      elsif
        LeseKarten.Grund (PositionExtern => KartenBlockadeWert) = GlobaleDatentypen.Gebirge
        or
          LeseKarten.Grund (PositionExtern => KartenBlockadeWert) = GlobaleDatentypen.Hügel
        or
          LeseKarten.Hügel (PositionExtern => KartenBlockadeWert) = True
        or
          (SichtweiteExtern /= 3
           and
             (LeseKarten.Grund (PositionExtern => KartenBlockadeWert) = GlobaleDatentypen.Dschungel
              or
                LeseKarten.Grund (PositionExtern => KartenBlockadeWert) = GlobaleDatentypen.Sumpf
              or
                LeseKarten.Grund (PositionExtern => KartenBlockadeWert) = GlobaleDatentypen.Wald))
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
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when GlobaleKonstanten.LeerYXKartenWert =>
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
      
      SichtweiteObjekt := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) + 1;
            
      YÄnderungStadtSchleife:         
      for YÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop            
         XÄnderungStadtSchleife:
         for XÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when GlobaleKonstanten.LeerYXKartenWert =>
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
      
      -- Die Kontaktsichtbarkeitsprüfung aus BewegungBerechnen kann hier nicht reingebaut werden, da dann jedes neu sichtbare Feld geprüft wird ob die anderen Rassen das sehen
      -- und nicht nur für das Feld auf dem die Einheit dann steht.
      
      case
        LeseKarten.Sichtbar (PositionExtern => KoordinatenExtern,
                             RasseExtern    => RasseExtern)
      is
         when True =>
            return;
            
         when False =>
            SchreibeKarten.Sichtbar (PositionExtern => KoordinatenExtern,
                                     RasseExtern    => RasseExtern,
                                     SichtbarExtern => True);
      end case;
      
      FremdeEinheitStadt := EinheitSuchen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => RasseExtern,
                                                                                      KoordinatenExtern => KoordinatenExtern);
      
      case
        FremdeEinheitStadt.Rasse
      is
         when GlobaleDatentypen.Leer =>
            null;
            
         when others =>
            KennenLernen.Erstkontakt (EigeneRasseExtern => RasseExtern,
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
            KennenLernen.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                      FremdeRasseExtern => FremdeEinheitStadt.Rasse);
      end case;
      
   end SichtbarkeitSetzen;
   
   
   
   procedure SichtbarkeitHandel
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      WelcherHandelExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
   is begin
      
      case
        WelcherHandelExtern
      is
         when 0 | -1 =>
            EAchseEinsSchleife:
            for EAchseEinsSchleifenwert in Karten.WeltkarteArray'Range (1) loop
               YAchseEinsSchleife:
               for YAchseEinsSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
                  XAchseEinsSchleife:
                  for XAchseEinsSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop

                     if
                       LeseKarten.Sichtbar (PositionExtern => (EAchseEinsSchleifenwert, YAchseEinsSchleifenwert, XAchseEinsSchleifenwert),
                                            RasseExtern    => RasseEinsExtern) = False
                       and
                         LeseKarten.Sichtbar (PositionExtern => (EAchseEinsSchleifenwert, YAchseEinsSchleifenwert, XAchseEinsSchleifenwert),
                                              RasseExtern    => RasseZweiExtern) = True
                     then
                        SichtbarkeitSetzen (RasseExtern       => RasseEinsExtern,
                                            KoordinatenExtern => (EAchseEinsSchleifenwert, YAchseEinsSchleifenwert, XAchseEinsSchleifenwert));
                        
                     else
                        null;
                     end if;

                  end loop XAchseEinsSchleife;
               end loop YAchseEinsSchleife;
            end loop EAchseEinsSchleife;

         when others =>
            null;
      end case;
      
      case
        WelcherHandelExtern
      is
         when 0 | 1 =>
            EAchseZweiSchleife:
            for EAchseZweiSchleifenwert in Karten.WeltkarteArray'Range (1) loop
               YAchseZweiSchleife:
               for YAchseZweiSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
                  XAchseZweiSchleife:
                  for XAchseZweiSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop

                     if
                       LeseKarten.Sichtbar (PositionExtern => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert),
                                            RasseExtern    => RasseZweiExtern) = False
                       and
                         LeseKarten.Sichtbar (PositionExtern => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert),
                                              RasseExtern    => RasseEinsExtern) = True
                     then
                        SichtbarkeitSetzen (RasseExtern       => RasseZweiExtern,
                                            KoordinatenExtern => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert));
                        
                     else
                        null;
                     end if;

                  end loop XAchseZweiSchleife;
               end loop YAchseZweiSchleife;
            end loop EAchseZweiSchleife;
            
         when others =>
            null;
      end case;
              
   end SichtbarkeitHandel;

end Sichtbarkeit;
