pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;
with EinheitenDatentypen;
with StadtKonstanten;

with SchreibeKarten;
with LeseKarten;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;
  
with Kartenkoordinatenberechnungssystem;
with EinheitSuchen;
with KennenlernenLogik;

package body Sichtbarkeit is
   
   -- Über die Sachen hier nochmal drüber gehen. Eventuell auch Sicht nach oben einbauen? äöü
   function SichtweiteErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenDatentypen.Sichtweite
   is begin
      
      KoordinatenEinheit := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      if
        (True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                       IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                       WelcheUmgebungExtern => EinheitenDatentypen.Luft_Enum)
         or
           True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                         IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                         WelcheUmgebungExtern => EinheitenDatentypen.Weltraum_Enum))
        and
          KoordinatenEinheit.EAchse >= 0
      then
         return 3;
         
      else
         AktuellerGrund := LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenEinheit);
         BasisGrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenEinheit);
      end if;
      
      if
        AktuellerGrund = KartengrundDatentypen.Gebirge_Enum
        or
          AktuellerGrund = KartengrundDatentypen.Hügel_Enum
          or
            BasisGrund = KartengrundDatentypen.Gebirge_Enum
            or
              BasisGrund = KartengrundDatentypen.Hügel_Enum
      then
         return 3;

      elsif
        AktuellerGrund = KartengrundDatentypen.Dschungel_Enum
        or
          AktuellerGrund = KartengrundDatentypen.Sumpf_Enum
          or
            AktuellerGrund = KartengrundDatentypen.Wald_Enum
      then
         return 1;
               
      else
         return 2;
      end if;
      
   end SichtweiteErmitteln;
   


   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
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
              (True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                             IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                             WelcheUmgebungExtern => EinheitenDatentypen.Luft_Enum)
               or
                 True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                               IDExtern             => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                               WelcheUmgebungExtern => EinheitenDatentypen.Weltraum_Enum))
              and
                LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern).EAchse >= 0
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
   
   
   
   -- Das hier Parallelisieren?
   procedure QuadrantenDurchlaufen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite)
   is begin
              
      KartenQuadrantWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                   ÄnderungExtern    => (0, -SichtweiteYRichtungExtern, SichtweiteXRichtungExtern),
                                                                                                   LogikGrafikExtern => True);
            
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
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                     XÄnderungExtern   => -XÄnderungSchleifenwert,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
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
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => YÄnderungSchleifenwert,
                                                     XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
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
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                     XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite)
   is begin
                    
      KartenQuadrantWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                   ÄnderungExtern    => (0, SichtweiteYRichtungExtern, SichtweiteXRichtungExtern),
                                                                                                   LogikGrafikExtern => True);
            
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
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                     XÄnderungExtern   => -XÄnderungSchleifenwert,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
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
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => -YÄnderungSchleifenwert,
                                                     XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
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
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                     XÄnderungExtern   => -XÄnderungSchleifenwert + 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite)
   is begin
                    
      KartenQuadrantWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                   ÄnderungExtern    => (0, SichtweiteYRichtungExtern, -SichtweiteXRichtungExtern),
                                                                                                   LogikGrafikExtern => True);
            
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
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                     XÄnderungExtern   => XÄnderungSchleifenwert,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
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
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => -YÄnderungSchleifenwert,
                                                     XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
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
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => -YÄnderungSchleifenwert + 1,
                                                     XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      SichtweiteYRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteXRichtungExtern : in KartenDatentypen.SichtweiteNatural;
      SichtweiteMaximalExtern : in KartenDatentypen.Sichtweite)
   is begin
                    
      KartenQuadrantWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                   ÄnderungExtern    => (0, -SichtweiteYRichtungExtern, -SichtweiteXRichtungExtern),
                                                                                                   LogikGrafikExtern => True);
            
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
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                     XÄnderungExtern   => XÄnderungSchleifenwert,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
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
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => YÄnderungSchleifenwert,
                                                     XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
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
                 False = SichtbarkeitBlockadeTesten (KoordinatenExtern => KartenQuadrantWert,
                                                     YÄnderungExtern   => YÄnderungSchleifenwert - 1,
                                                     XÄnderungExtern   => XÄnderungSchleifenwert - 1,
                                                     SichtweiteExtern  => SichtweiteMaximalExtern)
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      YÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      XÄnderungExtern : in KartenDatentypen.UmgebungsbereichZwei;
      SichtweiteExtern : in KartenDatentypen.UmgebungsbereichDrei)
      return Boolean
   is begin
      
      KartenBlockadeWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                   ÄnderungExtern    => (0, YÄnderungExtern, XÄnderungExtern),
                                                                                                   LogikGrafikExtern => True);
      
      if
        KartenBlockadeWert.XAchse = KartenKonstanten.LeerXAchse
      then
         return True;
         
      else
         AktuellerGrund := LeseKarten.AktuellerGrund (KoordinatenExtern => KartenBlockadeWert);
         BasisGrund := LeseKarten.AktuellerGrund (KoordinatenExtern => KartenBlockadeWert);
      end if;
         
      if
        AktuellerGrund = KartengrundDatentypen.Gebirge_Enum
        or
          AktuellerGrund = KartengrundDatentypen.Hügel_Enum
          or
            BasisGrund = KartengrundDatentypen.Gebirge_Enum
            or
              BasisGrund = KartengrundDatentypen.Hügel_Enum
              or
                (SichtweiteExtern /= 3
                 and
                   (AktuellerGrund = KartengrundDatentypen.Dschungel_Enum
                    or
                      AktuellerGrund = KartengrundDatentypen.Sumpf_Enum
                    or
                      AktuellerGrund = KartengrundDatentypen.Wald_Enum))
      then
         return False;
         
      else
         return True;
      end if;
            
   end SichtbarkeitBlockadeTesten;
   
   
   
   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      SichtweiteExtern : in KartenDatentypen.Sichtweite)
   is begin
         
      YÄnderungEinheitenSchleife:
      for YÄnderungSchleifenwert in -SichtweiteExtern .. SichtweiteExtern loop
         XÄnderungEinheitenSchleife:
         for XÄnderungSchleifenwert in -SichtweiteExtern .. SichtweiteExtern loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                 ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
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
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      SichtweiteObjekt := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) + 1;
            
      YÄnderungStadtSchleife:
      for YÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop
         XÄnderungStadtSchleife:
         for XÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                                 ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
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
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      -- Die Kontaktsichtbarkeitsprüfung aus BewegungBerechnen kann hier nicht reingebaut werden, da dann jedes neu sichtbare Feld geprüft wird ob die anderen Rassen das sehen.
      -- Und nicht nur für das Feld auf dem die Einheit dann steht.
      
      case
        LeseKarten.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                             RasseExtern       => RasseExtern)
      is
         when True =>
            return;
            
         when False =>
            SchreibeKarten.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                                     RasseExtern       => RasseExtern,
                                     SichtbarExtern    => True);
      end case;
      
      FremdeEinheit := EinheitSuchen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => RasseExtern,
                                                                                 KoordinatenExtern => KoordinatenExtern,
                                                                                 LogikGrafikExtern => True);
      
      case
        FremdeEinheit.Rasse
      is
         when StadtKonstanten.LeerRasse =>
            null;
            
         when others =>
            KennenlernenLogik.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                           FremdeRasseExtern => FremdeEinheit.Rasse);
            return;
      end case;
      
      FremdeStadt := LeseKarten.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        FremdeStadt.Rasse = RassenDatentypen.Keine_Rasse_Enum
        or
          FremdeStadt.Rasse = RasseExtern
      then
         null;
            
      else
         KennenlernenLogik.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                        FremdeRasseExtern => FremdeStadt.Rasse);
      end if;
      
   end SichtbarkeitSetzen;
   
end Sichtbarkeit;
