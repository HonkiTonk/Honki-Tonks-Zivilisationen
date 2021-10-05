pragma SPARK_Mode (On);

with KartenKonstanten, EinheitStadtDatentypen;

with SchreibeKarten;
with LeseKarten, LeseEinheitenGebaut, LeseEinheitenDatenbank, LeseStadtGebaut;
  
with KartePositionPruefen, EinheitSuchen, StadtSuchen, KennenLernen;

package body Sichtbarkeit is
   
   function SichtweiteErmitteln
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return KartenDatentypen.Sichtweite
   is begin
      
      KoordinatenEinheit := LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        (LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                WelcheUmgebungExtern => EinheitStadtDatentypen.Luft)
         = True
         or
           LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                  IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                  WelcheUmgebungExtern => EinheitStadtDatentypen.Weltraum)
         = True)
        and
          KoordinatenEinheit.EAchse >= 0
      then
         return 3;
         
      else
         AktuellerGrund := LeseKarten.Grund (PositionExtern => KoordinatenEinheit);
      end if;
      
      if
        AktuellerGrund = KartenDatentypen.Gebirge
        or
          AktuellerGrund = KartenDatentypen.Hügel
          or
            LeseKarten.Hügel (PositionExtern => KoordinatenEinheit) = True
      then
         return 3;

      elsif
        AktuellerGrund = KartenDatentypen.Dschungel
        or
          AktuellerGrund = KartenDatentypen.Sumpf
          or
            AktuellerGrund = KartenDatentypen.Wald
      then
         return 1;
               
      else
         return 2;
      end if;
      
   end SichtweiteErmitteln;
   


   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SichtweiteObjekt := SichtweiteErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        SichtweiteObjekt
      is
         when KartenDatentypen.Sichtweite'First =>
            SichtbarkeitsprüfungOhneBlockade (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               SichtweiteExtern         => SichtweiteObjekt);
            return;
            
         when 3 =>
            if
              (LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                      IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                      WelcheUmgebungExtern => EinheitStadtDatentypen.Luft)
               = True
               or
                 LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                        IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                        WelcheUmgebungExtern => EinheitStadtDatentypen.Weltraum)
               = True)
              and
                LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern).EAchse >= 0
            then
               SichtbarkeitsprüfungOhneBlockade (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  SichtweiteExtern         => SichtweiteObjekt);
               return;
               
            else
               null;
            end if;
            
         when others =>
            null;
      end case;

      QuadrantenDurchlaufen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end SichtbarkeitsprüfungFürEinheit;
   
   
   
   procedure QuadrantenDurchlaufen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
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
      
   end QuadrantenDurchlaufen;
   
   
   
   procedure QuadrantEins
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite)
   is begin
              
      KartenQuadrantWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                          ÄnderungExtern    => (0, -SichtweiteYRichtungExtern, SichtweiteXRichtungExtern));
            
      if
        KartenQuadrantWert.XAchse = KartenKonstanten.LeerXAchse
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
                                             SichtweiteExtern  => SichtweiteMaximalExtern)
                 = False
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
                                             SichtweiteExtern  => SichtweiteMaximalExtern)
                 = False
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
                                             SichtweiteExtern  => SichtweiteMaximalExtern)
                 = False
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite)
   is begin
                    
      KartenQuadrantWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                          ÄnderungExtern    => (0, SichtweiteYRichtungExtern, SichtweiteXRichtungExtern));
            
      if
        KartenQuadrantWert.XAchse = KartenKonstanten.LeerXAchse
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
                                             SichtweiteExtern  => SichtweiteMaximalExtern)
                 = False
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
                                             SichtweiteExtern  => SichtweiteMaximalExtern)
                 = False
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
                                             SichtweiteExtern  => SichtweiteMaximalExtern)
                 = False
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite)
   is begin
                    
      KartenQuadrantWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                          ÄnderungExtern    => (0, SichtweiteYRichtungExtern, -SichtweiteXRichtungExtern));
            
      if
        KartenQuadrantWert.XAchse = KartenKonstanten.LeerXAchse
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
                                             SichtweiteExtern  => SichtweiteMaximalExtern)
                 = False
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
                                             SichtweiteExtern  => SichtweiteMaximalExtern)
                 = False
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
                                             SichtweiteExtern  => SichtweiteMaximalExtern)
                 = False
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteMitNullwert;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite)
   is begin
                    
      KartenQuadrantWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                          ÄnderungExtern    => (0, -SichtweiteYRichtungExtern, -SichtweiteXRichtungExtern));
            
      if
        KartenQuadrantWert.XAchse = KartenKonstanten.LeerXAchse
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
                                             SichtweiteExtern  => SichtweiteMaximalExtern)
                 = False
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
                                             SichtweiteExtern  => SichtweiteMaximalExtern)
                 = False
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
                                             SichtweiteExtern  => SichtweiteMaximalExtern)
                 = False
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      YÄnderungExtern : in KartenDatentypen.LoopRangeMinusZweiZuZwei;
      XÄnderungExtern : in KartenDatentypen.LoopRangeMinusZweiZuZwei;
      SichtweiteExtern : in KartenDatentypen.LoopRangeMinusDreiZuDrei)
      return Boolean
   is begin
      
      KartenBlockadeWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                          ÄnderungExtern    => (0, YÄnderungExtern, XÄnderungExtern));
      
      if
        KartenBlockadeWert.XAchse = KartenKonstanten.LeerXAchse
      then
         null;
         
      elsif
        LeseKarten.Grund (PositionExtern => KartenBlockadeWert) = KartenDatentypen.Gebirge
        or
          LeseKarten.Grund (PositionExtern => KartenBlockadeWert) = KartenDatentypen.Hügel
        or
          LeseKarten.Hügel (PositionExtern => KartenBlockadeWert) = True
        or
          (SichtweiteExtern /= 3
           and
             (LeseKarten.Grund (PositionExtern => KartenBlockadeWert) = KartenDatentypen.Dschungel
              or
                LeseKarten.Grund (PositionExtern => KartenBlockadeWert) = KartenDatentypen.Sumpf
              or
                LeseKarten.Grund (PositionExtern => KartenBlockadeWert) = KartenDatentypen.Wald))
      then
         return False;
         
      else
         null;
      end if;
      
      return True;
      
   end SichtbarkeitBlockadeTesten;
   
   
   
   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      SichtweiteExtern : in KartenDatentypen.Sichtweite)
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
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenWert);
            end case;
            
         end loop XÄnderungEinheitenSchleife;
      end loop YÄnderungEinheitenSchleife;
      
   end SichtbarkeitsprüfungOhneBlockade;



   procedure SichtbarkeitsprüfungFürStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
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
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  SichtbarkeitSetzen (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                      KoordinatenExtern => KartenWert);
            end case;
                        
         end loop XÄnderungStadtSchleife;
      end loop YÄnderungStadtSchleife;
      
   end SichtbarkeitsprüfungFürStadt;
   
   
   
   procedure SichtbarkeitSetzen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
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
         when SonstigeDatentypen.Leer =>
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
         when SonstigeDatentypen.Leer =>
            null;
            
         when others =>
            KennenLernen.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                      FremdeRasseExtern => FremdeEinheitStadt.Rasse);
      end case;
      
   end SichtbarkeitSetzen;
   
end Sichtbarkeit;
