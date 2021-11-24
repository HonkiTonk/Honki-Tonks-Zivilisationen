pragma SPARK_Mode (On);

with Sf;

with KartenKonstanten;

with LeseEinheitenGebaut;

with KartePositionPruefen;
with Eingabe;
with EinheitenModifizieren;
with StadtBauen;
with Aufgaben;
with BewegungCursorSFML;
with BewegungEinheiten;
with GrafikEinstellungen;
with BerechnungenKarteSFML;

package body BewegungEinheitenSFML is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      BewegenSchleife:
      loop
         
         -- Eingabe.Tastenwert direkt als Übergabeparameter?
         Befehl := Eingabe.Tastenwert;
         
         case
           EinheitBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                           BefehlExtern             => Befehl)
         is
            when True =>
               null;
               
            when False =>
               return;
         end case;
         
      end loop BewegenSchleife;
      
   end BewegungEinheitenRichtung;
   
   
   
   function EinheitBefehle
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      BefehlExtern : in SystemDatentypen.Tastenbelegung_Enum)
      return Boolean
   is begin
      
      Änderung := KeineÄnderung;
      
      case
        BefehlExtern
      is
         when SystemDatentypen.Tastenbelegung_Bewegung_Enum'Range =>
            Änderung := Richtung (BefehlExtern);
               
         when SystemDatentypen.Heimatstadt_Ändern =>
            EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
         when SystemDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range | SystemDatentypen.Tastenbelegung_Allgemeine_Befehle_Enum'Range =>
            AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 BefehlExtern             => BefehlExtern);
               
            case
              AufgabeDurchführen
            is
               when True =>
                  return False;
               
               when False =>
                  return True;
            end case;
               
         when SystemDatentypen.Bauen =>
            NullWert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
         when SystemDatentypen.Mausbewegung =>
            if
              BefehleMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               null;
                  
            else
               return False;
            end if;
            
         when others =>
            return False;
      end case;
         
      if
        Änderung = KeineÄnderung
      then
         BewegungNochMöglich := BewegungEinheiten.NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      else
         KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                     ÄnderungExtern    => Änderung);
         
         case
           KartenWert.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               BewegungNochMöglich := True;
               
            when others =>
               BewegungNochMöglich := BewegungEinheiten.BewegungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                          NeuePositionExtern       => KartenWert);
         end case;
      end if;
      
      return BewegungNochMöglich;
      
   end EinheitBefehle;
   
   
   
   function BefehleMaus
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      MausPosition := GrafikEinstellungen.MausPosition;
      
      MausSchleife:
      loop
         
         if
           MausPosition.x in 0 .. Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.x)
           and
             MausPosition.y in 0 .. Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.y)
         then
            return MausInKarte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         elsif
           MausPosition.x in Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.x) .. Sf.sfInt32 (BerechnungenKarteSFML.FensterAnzeige.x)
           and
             MausPosition.y in Sf.sfInt32 (BerechnungenKarteSFML.FensterKarte.y) .. Sf.sfInt32 (BerechnungenKarteSFML.FensterAnzeige.y)
         then
            return MausInAnzeige (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
         else
            -- Die Schleife entfernen und immer True zurückgeben, wenn der Mauszeiger außerhalb des Fensters ist?
            null;
         end if;
         
      end loop MausSchleife;
      
   end BefehleMaus;
   
   
   
   function MausInKarte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      Änderung := KeineÄnderung;
      
      EingabeSchleife:
      loop
         
         BefehlMaus := Eingabe.Tastenwert;
         
         case
           BefehlMaus
         is
            when SystemDatentypen.Menü_Zurück =>
               return False;
               
            when SystemDatentypen.Auswählen =>
               BewegungCursorSFML.CursorPlatzierenKarteSFML (RasseExtern => EinheitRasseNummerExtern.Rasse);
               
               YÄnderungSchleife:
               for YÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  XÄnderungSchleife:
                  for XÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     
                     if
                       GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).Position.YAchse = LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern).YAchse + YÄnderungSchleifenwert
                       and
                         GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).Position.XAchse = LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern).XAchse + XÄnderungSchleifenwert
                     then
                        Änderung := (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert);
                        return True;
                        
                     else
                        null;
                     end if;
                     
                  end loop XÄnderungSchleife;
               end loop YÄnderungSchleife;
               
            when SystemDatentypen.Mausbewegung =>
               null;
               
            when others =>
               return EinheitBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                      BefehlExtern             => BefehlMaus);
         end case;
         
      end loop EingabeSchleife;
      
   end MausInKarte;
   
   
   
   function MausInAnzeige
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        EinheitRasseNummerExtern.Platznummer
      is
         when 1 =>
            null;
            
         when others =>
            null;
      end case;
      
      return True;
      
   end MausInAnzeige;

end BewegungEinheitenSFML;
