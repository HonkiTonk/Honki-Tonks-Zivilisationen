pragma SPARK_Mode (On);

with Sf;

with KartenKonstanten;

with LeseEinheitenGebaut;

with Eingabe;
with EinheitenModifizieren;
with StadtBauen;
with Aufgaben;
with BewegungEinheiten;
with GrafikEinstellungenSFML;
with BerechnungenKarteSFML;
with KartePositionPruefen;

-- Das hier mal umbenennen, man kann hier ja inzwischen wesentlich mehr mahen als nur die Einheit zu bewegen.
package body BewegungEinheitenSFML is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      BewegenSchleife:
      loop
         
         Änderung := KeineÄnderung;
         
         case
           EinheitBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                           BefehlExtern             => Eingabe.Tastenwert)
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
            
      case
        BefehlExtern
      is
         when SystemDatentypen.Tastenbelegung_Bewegung_Enum'Range =>
            Änderung := Richtung (BefehlExtern);
               
         when SystemDatentypen.Heimatstadt_Ändern =>
            EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
         when SystemDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range | SystemDatentypen.Tastenbelegung_Allgemeine_Befehle_Enum'Range =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichen Aufgabenanfang keine Bewegung mehr möglich ist und umgekehrt.
            return not Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     BefehlExtern             => BefehlExtern);
               
         when SystemDatentypen.Bauen =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichem Städtebau keine Bewegung mehr möglich ist und umgekehrt.
            return not StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when SystemDatentypen.Leer =>
            -- Statt nur bei Leer nichts machen und in allen anderen Fällen zurück oder nur bei Menü_Zurück zurück und sonst nicht?
            null;
            
         when others =>
            return False;
      end case;
      
      case
        BefehleMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when True =>
            null;
            
         when False =>
            return False;
      end case;
         
      if
        Änderung = KeineÄnderung
      then
         BewegungNochMöglich := BewegungEinheiten.NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      else
         BewegungNochMöglich := BewegungEinheiten.BewegungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                    PositionÄnderungExtern  => Änderung);
      end if;
      
      Änderung := KeineÄnderung;
      
      return BewegungNochMöglich;
      
   end EinheitBefehle;
   
   
   
   function BefehleMaus
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausPosition := GrafikEinstellungenSFML.MausPosition;
      
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
               YÄnderungSchleife:
               for YÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  XÄnderungSchleife:
                  for XÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     
                     
                     KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                 ÄnderungExtern   => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
                     
                     if
                       KartenWert.XAchse = KartenKonstanten.LeerXAchse
                     then
                        null;
                        
                     elsif
                       KartenWert = GlobaleVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).Position
                     then
                        Änderung := (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert);
                        return True;
                        
                     else
                        null;
                     end if;
                     
                  end loop XÄnderungSchleife;
               end loop YÄnderungSchleife;
               
            when SystemDatentypen.Leer =>
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
