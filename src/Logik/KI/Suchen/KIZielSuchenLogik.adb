with KartenRecordKonstanten;
with KartenKonstanten;
with KartengrundDatentypen;
with SystemDatentypen;

with LeseEinheitenGebaut;
with LeseWeltkarte;
with LeseAllgemeines;

with ZufallsgeneratorenHTSEB;
with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;

with KIKonstanten;

with KIAufgabenVerteiltLogik;
with KIEinheitAllgemeinePruefungenLogik;
with KIKartenfeldbewertungModifizierenLogik;

package body KIZielSuchenLogik is

   function ZielSuchen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      ZielartExtern : in KIDatentypen.Ziel_Suchen_Enum)
      return KartenRecords.KartenfeldNaturalRecord
   is begin
      
      EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      Schwierigkeitsgrad := LeseAllgemeines.Schwierigkeitsgrad;
      
      -- Hier noch eine Überprüfung einbauen ob die Ebenenänderung überhaupt möglich ist? äöü
      -- Dann müsste ich nicht immer alles durchgehen. äöü
      EbeneSchleife:
      for EbeneSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         
         QuadrantenDurchgegangen := (others => False);
         
         QuadrantenSchleife:
         for QuadrantenSchleifenwert in QuadrantenDurchgegangenArray'Range loop
            QuadrantenauswahlSchleife:
            loop
            
               WelcherQuadrant := KartenDatentypen.StandardQuadranten (ZufallsgeneratorenHTSEB.VorgegebenerZahlenbereich (AnfangExtern => Positive (QuadrantenDurchgegangenArray'First),
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
                  YQuadrantenbereich := (0, KIKonstanten.YFelderreichweite (Schwierigkeitsgrad));
                  XQuadrantenbereich := (0, KIKonstanten.XFelderreichweite (Schwierigkeitsgrad));
                  -- Man könnte die Mutliplikatoren in einem konstanten Array speichern und dann einfach zuweisen. äöü
                  Multiplikator := (-1, 1);
                  
               when 2 =>
                  YQuadrantenbereich := (1, KIKonstanten.YFelderreichweite (Schwierigkeitsgrad));
                  XQuadrantenbereich := (0, KIKonstanten.XFelderreichweite (Schwierigkeitsgrad));
                  Multiplikator := (1, 1);
               
               when 3 =>
                  YQuadrantenbereich := (0, KIKonstanten.YFelderreichweite (Schwierigkeitsgrad));
                  -- X geht hier von -1 bis -Reichweite, deswegen den Multiplikator auf -1 setzen.
                  XQuadrantenbereich := (1, KIKonstanten.XFelderreichweite (Schwierigkeitsgrad));
                  Multiplikator := (1, -1);
               
               when 4 =>
                  -- Hier geht beides von -1 bis -Reichweite, deswegen den Multiplikator auf -1 setzen.
                  YQuadrantenbereich := (1, KIKonstanten.YFelderreichweite (Schwierigkeitsgrad));
                  XQuadrantenbereich := (1, KIKonstanten.XFelderreichweite (Schwierigkeitsgrad));
                  Multiplikator := (-1, -1);
            end case;
         
            SenkrechteSchleife:
            for SenkrechteSchleifenwert in YQuadrantenbereich.Anfang .. YQuadrantenbereich.Ende loop
               WaagerechteSchleife:
               for WaagerechteSchleifenwert in XQuadrantenbereich.Anfang .. XQuadrantenbereich.Ende loop
            
                  Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => EinheitenKoordinaten,
                                                                                                            ÄnderungExtern    => (EbeneSchleifenwert,
                                                                                                                                   Multiplikator.Senkrechte * SenkrechteSchleifenwert,
                                                                                                                                   Multiplikator.Waagerechte * WaagerechteSchleifenwert),
                                                                                                            TaskExtern        => SystemDatentypen.Logik_Task_Enum);
                  
                  -- Könnte man ZielGefunden nicht vor der Schleife auf False setze und sich hier das Neusetzen bei LeerAchse sparen? äöü
                  case
                    Kartenwert.Waagerechte
                  is
                     when KartenKonstanten.LeerWaagerechte =>
                        ZielGefunden := False;
                        
                     when others =>
                        ZielGefunden := Aufteilung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    KoordinatenExtern          => Kartenwert,
                                                    ZielartExtern              => ZielartExtern);
                  end case;
                                    
                  case
                    ZielGefunden
                  is
                     when True =>
                        return Kartenwert;
                        
                     when False =>
                        null;
                  end case;
               
               end loop WaagerechteSchleife;
            end loop SenkrechteSchleife;
         end loop QuadrantenSchleife;
      end loop EbeneSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end ZielSuchen;
   
   
   
   function Aufteilung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      ZielartExtern : in KIDatentypen.Ziel_Suchen_Enum)
      return Boolean
   is begin
      
      case
        ZielartExtern
      is
         when KIDatentypen.Fliehen_Enum =>
            return Fliehen (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                            KoordinatenExtern => KoordinatenExtern);
                     
         when KIDatentypen.Siedeln_Enum =>
            return Siedeln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                            KoordinatenExtern          => KoordinatenExtern);
                     
         when KIDatentypen.Erkunden_Enum =>
            return Erkunden (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                             KoordinatenExtern          => KoordinatenExtern);
                     
         when KIDatentypen.Eigenes_Feld_Enum =>
            return EigenesFeld (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                KoordinatenExtern          => KoordinatenExtern);
      end case;
      
   end Aufteilung;
   
   
   
   -- Die ganzen Prüfungen die hier kommen eventuell auch in eine eigene Datei auslagern, wenn das irgendwann einmal richtig viele werden sollten. äöü
   
   -- Die Prüfungen hier drin später noch erweitern. äöü
   function Fliehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
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
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
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
   
   
   
   function Erkunden
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      if
        False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                                        SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies)
        and
          True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                           NeueKoordinatenExtern      => KoordinatenExtern)
        and
          False = KIAufgabenVerteiltLogik.EinheitZiel (SpeziesExtern         => EinheitSpeziesNummerExtern.Spezies,
                                                       ZielKoordinatenExtern => KoordinatenExtern)
        -- Hier noch einen Weg finden einen Transporter einzubauen. äöü
      then
         return True;
                     
      else
         return False;
      end if;
      
   end Erkunden;
   
   
   
   function EigenesFeld
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
   is begin
      
      if
        True = LeseWeltkarte.BelegterGrund (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                            KoordinatenExtern => KoordinatenExtern)
        and
          True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                           NeueKoordinatenExtern      => KoordinatenExtern)
      then
         return True;
         
      else
         return False;
      end if;
      
   end EigenesFeld;

end KIZielSuchenLogik;
