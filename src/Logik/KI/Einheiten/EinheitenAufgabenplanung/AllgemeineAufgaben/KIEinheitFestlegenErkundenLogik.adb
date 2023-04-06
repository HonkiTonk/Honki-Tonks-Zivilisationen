with KartenKonstanten;

with LeseWeltkarte;
with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseAllgemeines;

with PassierbarkeitspruefungLogik;
with KartenkoordinatenberechnungssystemLogik;
with ZufallegeneratorenAllgemein;

with KIDatentypen;
with KIKonstanten;

with KIAufgabenVerteiltLogik;

package body KIEinheitFestlegenErkundenLogik is

   function Erkunden
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      return ZielSuchen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                         KoordinatenExtern          => EinheitKoordinaten);
      
   end Erkunden;
   
   
   
   -- Kann ich das hier noch an anderen Stellen verwenden? äöü
   function ZielSuchen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
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
                  YQuadrantenbereich := (0, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
                  XQuadrantenbereich := (0, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
                  Multiplikator := (-1, 1);
                  
               when 2 =>
                  YQuadrantenbereich := (1, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
                  XQuadrantenbereich := (0, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
                  Multiplikator := (1, 1);
               
               when 3 =>
                  YQuadrantenbereich := (0, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
                  -- X geht hier von -1 bis -Reichweite, deswegen den Multiplikator auf -1 setzen.
                  XQuadrantenbereich := (1, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
                  Multiplikator := (1, -1);
               
               when 4 =>
                  -- Hier geht beides von -1 bis -Reichweite, deswegen den Multiplikator auf -1 setzen.
                  YQuadrantenbereich := (1, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
                  XQuadrantenbereich := (1, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
                  Multiplikator := (-1, -1);
            end case;
         
            YAchseSchleife:
            for YAchseSchleifenwert in YQuadrantenbereich.Anfang .. YQuadrantenbereich.Ende loop
               XAchseSchleife:
               for XAchseSchleifenwert in XQuadrantenbereich.Anfang .. XQuadrantenbereich.Ende loop
            
                  KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                            ÄnderungExtern    => (EAchseSchleifenwert,
                                                                                                                                   Multiplikator.YAchse * YAchseSchleifenwert,
                                                                                                                                   Multiplikator.XAchse * XAchseSchleifenwert),
                                                                                                            LogikGrafikExtern => True);
                  
                  if
                    KartenWert.XAchse = KartenKonstanten.LeerXAchse
                  then
                     null;
                        
                  elsif
                    False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                                    SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies)
                    and
                      True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                       NeueKoordinatenExtern      => KartenWert)
                    and
                      False = KIAufgabenVerteiltLogik.EinheitZiel (SpeziesExtern         => EinheitSpeziesNummerExtern.Spezies,
                                                                   ZielKoordinatenExtern => KartenWert)
                    -- and
                    --   False = KIEinheitAllgemeinePruefungenLogik.AktuellUnpassierbar (KoordinatenExtern          => KartenWert,
                    --                                                                   EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
                  then
                     SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                KoordinatenExtern          => KartenWert);
                     SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             AufgabeExtern              => KIDatentypen.Erkunden_Enum);
                     return True;
                     
                  else
                     null;
                  end if;
               
               end loop XAchseSchleife;
            end loop YAchseSchleife;
         end loop QuadrantenSchleife;
      end loop EAchseSchleife;
      
      return False;
      
   end ZielSuchen;

end KIEinheitFestlegenErkundenLogik;
