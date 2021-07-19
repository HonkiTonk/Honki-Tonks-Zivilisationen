pragma SPARK_Mode (On);
  
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
      
      case
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).Grund
      is
         when GlobaleDatentypen.Gebirge =>
            SichtweiteObjekt := 3;

         when GlobaleDatentypen.Dschungel =>
            SichtweiteObjekt := 1;
               
         when others =>
            SichtweiteObjekt := 2;
      end case;

      YÄnderungEinheitenSchleife:
      for YÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop            
         XÄnderungEinheitenSchleife:
         for XÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop
            
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
      
   end SichtbarkeitsprüfungFürEinheit;
   
   
   
   procedure SichtbarkeitsprüfungFürEinheitNeu
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      SichtbarkeitUmgebung := (others => (others => (0, 0, 0, 0)));
      
      AktuellerGrund := Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.EAchse,
                                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.YAchse,
                                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position.XAchse).Grund;
      
      case
        AktuellerGrund
      is
         when GlobaleDatentypen.Gebirge =>
            SichtweiteObjekt := 3;

         when GlobaleDatentypen.Dschungel =>
            SichtweiteObjekt := 1;
            
         when others =>
            SichtweiteObjekt := 2;
      end case;
      
      YÄnderungEinheitenSchleife:
      for YÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop            
         XÄnderungEinheitenSchleife:
         for XÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            if
              KartenWert.YAchse = 0
            then
               SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert) := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse, -1);
               
            elsif
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = 0
            then
               SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert) := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse, 100);
               
            elsif
              AktuellerGrund = GlobaleDatentypen.Dschungel
            then
               SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert) := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse, 1);
               
            elsif
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund = GlobaleDatentypen.Gebirge
            then
               SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert) := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse, 1);
               
            elsif
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund = GlobaleDatentypen.Dschungel
              and
                AktuellerGrund = GlobaleDatentypen.Gebirge
            then
               SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert) := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse, 50);
               
            elsif
              AktuellerGrund = GlobaleDatentypen.Gebirge
              and
                Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund /= GlobaleDatentypen.Dschungel
              and
                Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund /= GlobaleDatentypen.Gebirge
            then
               SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert) := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse, 50);
               
            else
               SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert) := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse, 5);
            end if;
            
         end loop XÄnderungEinheitenSchleife;
      end loop YÄnderungEinheitenSchleife;
      
      case
        SichtweiteObjekt
      is
         when 1 =>
            null;
            
         when others =>
            YÄnderungEinheitenSchleife2:
            for YÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop            
               XÄnderungEinheitenSchleife2:
               for XÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop
            
                  if
                    YÄnderungSchleifenwert <= -2
                    and
                      XÄnderungSchleifenwert = 0
                  then
                     if
                       SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung < SichtbarkeitUmgebung (YÄnderungSchleifenwert + 1, XÄnderungSchleifenwert).Bewertung
                     then
                        SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung := 0;
                        
                     else
                        null;
                     end if;
                     
                  elsif
                    YÄnderungSchleifenwert >= 2
                    and
                      XÄnderungSchleifenwert = 0
                  then
                     if
                       SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung < SichtbarkeitUmgebung (YÄnderungSchleifenwert - 1, XÄnderungSchleifenwert).Bewertung
                     then
                        SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung := 0;
               
                     else
                        null;
                     end if;
                     
                  elsif
                    XÄnderungSchleifenwert <= -2
                    and
                      YÄnderungSchleifenwert = 0
                  then
                     if
                       SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung < SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert + 1).Bewertung
                     then
                        SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung := 0;
                        
                     else
                        null;
                     end if;
                     
                  elsif
                    XÄnderungSchleifenwert >= 2
                    and
                      YÄnderungSchleifenwert = 0
                  then
                     if
                       SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung < SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert - 1).Bewertung
                     then
                        SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung := 0;
                        
                     else
                        null;
                     end if;
                     
                  elsif
                    YÄnderungSchleifenwert <= -2
                    and
                      XÄnderungSchleifenwert <= -2
                  then
                     if
                       SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung < SichtbarkeitUmgebung (YÄnderungSchleifenwert + 1, XÄnderungSchleifenwert + 1).Bewertung
                     then
                        SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung := 0;
                        
                     else
                        null;
                     end if;
                     
                  elsif
                    YÄnderungSchleifenwert <= -2
                    and
                      XÄnderungSchleifenwert >= 2
                  then
                     if
                       SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung < SichtbarkeitUmgebung (YÄnderungSchleifenwert + 1, XÄnderungSchleifenwert - 1).Bewertung
                     then
                        SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung := 0;
                        
                     else
                        null;
                     end if;
                     
                  elsif
                    YÄnderungSchleifenwert >= 2
                    and
                      XÄnderungSchleifenwert <= -2
                  then
                     if
                       SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung < SichtbarkeitUmgebung (YÄnderungSchleifenwert - 1, XÄnderungSchleifenwert + 1).Bewertung
                     then
                        SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung := 0;
                        
                     else
                        null;
                     end if;
                     
                  elsif
                    YÄnderungSchleifenwert >= 2
                    and
                      XÄnderungSchleifenwert >= 2
                  then
                     if
                       SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung < SichtbarkeitUmgebung (YÄnderungSchleifenwert - 1, XÄnderungSchleifenwert - 1).Bewertung
                     then
                        SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung := 0;
                        
                     else
                        null;
                     end if;
                     
                  elsif
                    YÄnderungSchleifenwert <= -2
                    and
                      XÄnderungSchleifenwert = 1
                  then
                     if
                       SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung < SichtbarkeitUmgebung (YÄnderungSchleifenwert + 1, XÄnderungSchleifenwert).Bewertung
                     then
                        SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung := 0;
                        
                     else
                        null;
                     end if;
                     
                  elsif
                    YÄnderungSchleifenwert >= 2
                    and
                      XÄnderungSchleifenwert = 1
                  then
                     if
                       SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung < SichtbarkeitUmgebung (YÄnderungSchleifenwert - 1, XÄnderungSchleifenwert).Bewertung
                     then
                        SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung := 0;
               
                     else
                        null;
                     end if;
                     
                  elsif
                    XÄnderungSchleifenwert <= -2
                    and
                      YÄnderungSchleifenwert = 1
                  then
                     if
                       SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung < SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert + 1).Bewertung
                     then
                        SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung := 0;
                        
                     else
                        null;
                     end if;
                     
                  elsif
                    XÄnderungSchleifenwert >= 2
                    and
                      YÄnderungSchleifenwert = 1
                  then
                     if
                       SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung < SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert - 1).Bewertung
                     then
                        SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung := 0;
                        
                     else
                        null;
                     end if;
                     
                  else
                     null;
                  end if;
            
               end loop XÄnderungEinheitenSchleife2;
            end loop YÄnderungEinheitenSchleife2;
      end case;

      YÄnderungEinheitenSchleife1:
      for YÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop            
         XÄnderungEinheitenSchleife1:
         for XÄnderungSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop
            
            if
              SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).Bewertung > 0
            then
               SichtbarkeitSetzen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                   KoordinatenExtern => (SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).EAchse,
                                                         SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).YAchse,
                                                         SichtbarkeitUmgebung (YÄnderungSchleifenwert, XÄnderungSchleifenwert).XAchse));
               
            else
               null;
            end if;
            
         end loop XÄnderungEinheitenSchleife1;
      end loop YÄnderungEinheitenSchleife1;
      
   end SichtbarkeitsprüfungFürEinheitNeu;



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
