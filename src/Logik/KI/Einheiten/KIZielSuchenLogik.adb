with KartenRecordKonstanten;
with KartenKonstanten;
with KartengrundDatentypen;

with LeseEinheitenGebaut;
with LeseWeltkarte;
with LeseAllgemeines;

with ZufallegeneratorenAllgemein;
with KartenkoordinatenberechnungssystemLogik;

with KIKonstanten;

with KIAufgabenVerteiltLogik;
with KIEinheitAllgemeinePruefungenLogik;
with KIKartenfeldbewertungModifizierenLogik;

package body KIZielSuchenLogik is

   function ZielSuchen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      ZielartExtern : in KIDatentypen.Ziel_Suchen_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KIDatentypen.Ziel_Suchen_Enum;
   begin
      
      EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      Schwierigkeitsgrad := LeseAllgemeines.Schwierigkeitsgrad;
      
      -- Hier noch eine Überprüfung einbauen ob die Ebenenänderung überhaupt möglich ist? äöü
      -- Dann müsste ich nicht immer alles durchgehen. äöü
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         
         QuadrantenDurchgegangen := (others => False);
         
         QuadrantenSchleife:
         for QuadrantenSchleifenwert in QuadrantenDurchgegangenArray'Range loop
            QuadrantenauswahlSchleife:
            loop
            
               WelcherQuadrant := KartenDatentypen.StandardQuadranten (ZufallegeneratorenAllgemein.VorgegebenerZahlenbereich (AnfangExtern => Positive (QuadrantenDurchgegangenArray'First),
                                                                                                                              EndeExtern   => Positive (QuadrantenDurchgegangenArray'Last)));
            
               case
                 QuadrantenDurchgegangen (WelcherQuadrant)
               is
                  when False =>
                     QuadrantenDurchgegangen (WelcherQuadrant) := True;
                     exit QuadrantenauswahlSchleife;
                  
                  when True =>
                     null;
               end case;
            
            end loop QuadrantenauswahlSchleife;
         
            case
              WelcherQuadrant
            is
               when 1 =>
                  -- Y geht hier von 0 bis -Reichweite, deswegen den Multiplikator auf -1 setzen.
                  YQuadrantenbereich := (0, KIKonstanten.Felderreichweite (Schwierigkeitsgrad));
                  XQuadrantenbereich := (0, KIKonstanten.Felderreichweite (Schwierigkeitsgrad));
                  Multiplikator := (-1, 1);
                  
               when 2 =>
                  YQuadrantenbereich := (1, KIKonstanten.Felderreichweite (Schwierigkeitsgrad));
                  XQuadrantenbereich := (0, KIKonstanten.Felderreichweite (Schwierigkeitsgrad));
                  Multiplikator := (1, 1);
               
               when 3 =>
                  YQuadrantenbereich := (0, KIKonstanten.Felderreichweite (Schwierigkeitsgrad));
                  -- X geht hier von -1 bis -Reichweite, deswegen den Multiplikator auf -1 setzen.
                  XQuadrantenbereich := (1, KIKonstanten.Felderreichweite (Schwierigkeitsgrad));
                  Multiplikator := (1, -1);
               
               when 4 =>
                  -- Hier geht beides von -1 bis -Reichweite, deswegen den Multiplikator auf -1 setzen.
                  YQuadrantenbereich := (1, KIKonstanten.Felderreichweite (Schwierigkeitsgrad));
                  XQuadrantenbereich := (1, KIKonstanten.Felderreichweite (Schwierigkeitsgrad));
                  Multiplikator := (-1, -1);
            end case;
         
            YAchseSchleife:
            for YAchseSchleifenwert in YQuadrantenbereich.Anfang .. YQuadrantenbereich.Ende loop
               XAchseSchleife:
               for XAchseSchleifenwert in XQuadrantenbereich.Anfang .. XQuadrantenbereich.Ende loop
            
                  Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => EinheitenKoordinaten,
                                                                                                            ÄnderungExtern    => (EAchseSchleifenwert,
                                                                                                                                   Multiplikator.YAchse * YAchseSchleifenwert,
                                                                                                                                   Multiplikator.XAchse * XAchseSchleifenwert),
                                                                                                            LogikGrafikExtern => True);

                  if
                    Kartenwert.XAchse = KartenKonstanten.LeerXAchse
                  then
                     ZielGefunden := False;
                     
                  elsif
                    ZielartExtern = KIDatentypen.Fliehen_Enum
                  then
                     ZielGefunden := Fliehen (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                              KoordinatenExtern => Kartenwert);
                     
                  elsif
                    ZielartExtern = KIDatentypen.Siedeln_Enum
                  then
                     ZielGefunden := Siedeln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                              KoordinatenExtern          => Kartenwert);
                    
                  else
                     ZielGefunden := False;
                  end if;
                  
                  case
                    ZielGefunden
                  is
                     when True =>
                        return Kartenwert;
                        
                     when False =>
                        null;
                  end case;
               
               end loop XAchseSchleife;
            end loop YAchseSchleife;
         end loop QuadrantenSchleife;
      end loop EAchseSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end ZielSuchen;
   
   
   
   -- Die ganzen Prüfungen die hier kommen eventuell auch in eine eigene Datei auslagern, wenn das irgendwann einmal richtig viele werden sollten. äöü
   
   -- Die Prüfungen hier drin später noch erweitern. äöü
   function Fliehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        LeseWeltkarte.BelegterGrund (SpeziesExtern     => SpeziesExtern,
                                     KoordinatenExtern => KoordinatenExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      return False;
      
   end Fliehen;
   
   
   
   function Siedeln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      -- Diese Prüfungen hier mal Speziesspezifisch erweitern. äöü
      if
        False = KIEinheitAllgemeinePruefungenLogik.KartenfeldPrüfen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                      KoordinatenExtern          => KoordinatenExtern)
      then
         null;
      
      elsif
        LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern) = KartengrundDatentypen.Eis_Enum
      then
         null;
         
      elsif
        False = KIKartenfeldbewertungModifizierenLogik.BewertungStadtBauen (KoordinatenExtern => KoordinatenExtern,
                                                                            SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies)
      then
         null;
         
      elsif
        False = KIAufgabenVerteiltLogik.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bauen_Enum,
                                                            SpeziesExtern         => EinheitSpeziesNummerExtern.Spezies,
                                                            ZielKoordinatenExtern => KoordinatenExtern)
      then
         return True;
      
      else
         null;
      end if;
      
      return False;
      
   end Siedeln;

end KIZielSuchenLogik;
